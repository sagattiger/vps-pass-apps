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

- **Run once** writes `openclaw.json` (only if it doesn't exist yet): `bind: lan`, port 18789, `publicOrigin: {{url}}` (the browser-origin check, so the Control UI works behind Zoraxy + both Traefiks), `trustedProxies` (Docker private ranges in the VM) and token auth. The token itself stays in the `OPENCLAW_GATEWAY_TOKEN` variable, not in the file.
- **Auth:** token mode, token = `{{secret}}`. Browser pairing stays on (OpenClaw's recommendation); the first browser is approved with the `devices approve` command above. Never set the retired `dangerouslyDisableDeviceAuth`.
- **No Docker sandbox:** 2.0's Docker/Podman sandbox needs the Docker socket, which VPS Pass templates don't allow (it's off by default anyway). The agent's tools run inside its own container, with `no-new-privileges` and `NET_RAW`/`NET_ADMIN` dropped, as in the upstream compose.
- **Ports:** only the gateway port (Control UI + API + WebSocket) is routed. The bridge port 18790 and the Teams port 3978 aren't exposed (one HTTP address per app); Telegram/WhatsApp/Discord channels connect outwards and work.
- **Upgrading:** 2.0 moved sessions to SQLite. Back up the `config` volume before moving to a new major.
- RAM 1 GB: gateway idle plus a working agent. Heavy tool use or the `-browser` image needs more; that's why it's free from Q2, like Hermes Agent.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
