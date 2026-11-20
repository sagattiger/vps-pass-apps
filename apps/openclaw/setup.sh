# Proxies in front of the gateway: Zoraxy, the central Traefik (VIP and nodes), and the VM's own
# Traefik (a container on the "qsync" Docker network, whose range is read from this VM).
SUBNET=$(docker network inspect qsync 2>/dev/null | grep -o '"Subnet": *"[0-9.]*/[0-9]*"' | grep -o '[0-9.]*/[0-9]*' | head -1)
TRUSTED="10.128.101.101,10.128.101.253,10.128.101.113,10.128.101.114${SUBNET:+,$SUBNET}"

# Create or update openclaw.json (runs again on every Retry, so existing installs get fixed too).
$COMPOSE run --rm --no-deps -T -u 0 -e TRUSTED="$TRUSTED" --entrypoint node openclaw -e '
const fs = require("fs");
const dir = "/home/node/.openclaw", p = dir + "/openclaw.json";
let c = {};
if (fs.existsSync(p)) {
  try { c = JSON.parse(fs.readFileSync(p, "utf8")); }
  catch (e) { console.log("openclaw.json is not plain JSON, left as it is"); process.exit(0); }
}
const g = c.gateway = c.gateway || {};
g.mode = g.mode || "local";
g.bind = "lan";
g.port = 18789;
g.publicOrigin = "{{url}}";
g.trustedProxies = process.env.TRUSTED.split(",").filter(Boolean);
if (!g.auth) g.auth = { mode: "token", token: "${OPENCLAW_GATEWAY_TOKEN}" };
fs.mkdirSync(dir + "/workspace", { recursive: true });
fs.writeFileSync(p, JSON.stringify(c, null, 2) + "\n");
console.log("openclaw.json ready, trusted proxies: " + g.trustedProxies.join(" "));
'
$COMPOSE run --rm --no-deps -T -u 0 --entrypoint sh openclaw -c 'chown -R 1000:1000 /home/node/.openclaw'
