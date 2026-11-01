$COMPOSE run --rm --no-deps -T -u 0 --entrypoint sh openclaw -c '
mkdir -p /home/node/.openclaw/workspace
if [ ! -f /home/node/.openclaw/openclaw.json ]; then
cat > /home/node/.openclaw/openclaw.json <<"JSON"
{
  gateway: {
    bind: "lan",
    port: 18789,
    publicOrigin: "{{url}}",
    trustedProxies: ["172.16.0.0/12", "10.0.0.0/8", "192.168.0.0/16"],
    auth: { mode: "token", token: "${OPENCLAW_GATEWAY_TOKEN}" },
  },
}
JSON
fi
chown -R 1000:1000 /home/node/.openclaw
'
