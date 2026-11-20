# OpenClaw

Personal AI agent (OpenClaw 2.0). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `OpenClaw` |
| Slug | `openclaw` |
| Category | `AI` |
| Description | `Personal AI agent (OpenClaw 2.0)` |
| Web service | `openclaw` |
| Web port | `18789` |
| RAM reserved (MB) | `1024` |
| Disk reserved (MB) | `4096` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
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
```

## Login info

```
Open {{url}} and enter the gateway token in Settings:
{{secret}}
If it says "pairing required", approve this browser in the VM:
cd /opt/qsync/apps/{{app_id}} && docker compose -p qa{{app_id}} exec openclaw node openclaw.mjs devices list
then: ... devices approve <request id>
```

## Image tags

`ghcr.io/openclaw/openclaw:latest`: the official image (GHCR is the primary registry; `latest` is the stable channel, now on the 2.0 line, release 2026.8.1 and later). Version tags (`2026.9.x`) and `extended-stable` exist: pin one once tested. Not the `-browser` variant (adds Chromium, ~1 GB more RAM).

## First login

1. Open the address. In **Settings**, paste the gateway token from the login info.
2. If the page says **pairing required**, approve this browser in the VM:
   ```bash
   cd /opt/qsync/apps/<id>
   docker compose -p qa<id> exec openclaw node openclaw.mjs devices list
   docker compose -p qa<id> exec openclaw node openclaw.mjs devices approve <request id>
   ```
3. Finish the 2.0 onboarding in the chat: connect a model (API key, ChatGPT/Claude subscription), then channels (Telegram, WhatsApp, Discord…).

## Admin checks

- **Run once** creates **or updates** `openclaw.json` at every install and Retry (other keys are kept): `mode: local` (the gateway refuses to start without it; the command also passes `--allow-unconfigured`), `bind: lan`, port 18789, `publicOrigin: {{url}}` (browser-origin check; `controlUi.allowedOrigins` defaults to it), token auth if none is set, and **`trustedProxies`**.
- **`trustedProxies`** must list every proxy hop, or every request fails with `proxy_attribution_required` ("Proxy client attribution is required"): Zoraxy (10.128.101.101), the central Traefik VIP and nodes (10.128.101.253, .113, .114) and the VM's own Traefik, whose `qsync` Docker network range run once reads with `docker network inspect qsync`. If the edge proxies change, update the addresses in `setup.sh` and Retry the installs.
- **404 after install** = the gateway isn't running or the image's built-in `HEALTHCHECK` (`/healthz`) isn't passing yet; Traefik doesn't route to unhealthy containers. Check `docker compose -p qa<id> ps` and the logs. The token itself stays in the `OPENCLAW_GATEWAY_TOKEN` variable, not in the file.
- **Auth:** token mode, token = `{{secret}}`. Browser pairing stays on (OpenClaw's recommendation); the first browser is approved with the `devices approve` command above. Never set the retired `dangerouslyDisableDeviceAuth`.
- **No Docker sandbox:** 2.0's Docker/Podman sandbox needs the Docker socket, which VPS Pass templates don't allow (it's off by default anyway). The agent's tools run inside its own container, with `no-new-privileges` and `NET_RAW`/`NET_ADMIN` dropped, as in the upstream compose.
- **Ports:** only the gateway port (Control UI + API + WebSocket) is routed. The bridge port 18790 and the Teams port 3978 aren't exposed (one HTTP address per app); Telegram/WhatsApp/Discord channels connect outwards and work.
- **Upgrading:** 2.0 moved sessions to SQLite. Back up the `config` volume before moving to a new major.
- RAM 1 GB: gateway idle plus a working agent. Heavy tool use or the `-browser` image needs more; that's why it's free from Q2, like Hermes Agent.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
