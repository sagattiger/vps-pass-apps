$COMPOSE run --rm --no-deps -T -u 0 --entrypoint sh openclaw -c '
mkdir -p /home/node/.openclaw/workspace
if [ ! -f /home/node/.openclaw/openclaw.json ]; then
cat > /home/node/.openclaw/openclaw.json <<"JSON"
{
  gateway: {
    mode: "local",
    bind: "lan",
    port: 18789,
    publicOrigin: "{{url}}",
    auth: { mode: "token", token: "${OPENCLAW_GATEWAY_TOKEN}" },
  },
}
JSON
fi
chown -R 1000:1000 /home/node/.openclaw
'
