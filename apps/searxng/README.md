# SearXNG

Private metasearch engine (web search for AI apps). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `SearXNG` |
| Slug | `searxng` |
| Category | `AI` |
| Description | `Private metasearch engine (web search for AI apps)` |
| Web service | `web` |
| Web port | `8080` |
| RAM reserved (MB) | `256` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE run --rm --no-deps -T -u 0 --entrypoint sh searxng -c '
if [ ! -f /etc/searxng/settings.yml ]; then
cat > /etc/searxng/settings.yml <<"YML"
use_default_settings: true
server:
  secret_key: "{{secret}}"
  base_url: "{{url}}/"
  limiter: false
  image_proxy: true
search:
  formats:
    - html
    - json
YML
fi
chown -R "$(stat -c %u:%g /etc/searxng)" /etc/searxng
'
```

## Login info

```
User: admin
Password: {{password}}
Open WebUI / AI agents search URL:
https://admin:{{password}}@{{host}}/search?q=<query>&format=json
```

## Image tags

`searxng/searxng:latest` (SearXNG publishes rolling builds only), `caddy:2-alpine` in front for the login.

## First login

1. Open the address, log in as `admin` with the password from the login info, and search.
2. **Open WebUI:** Admin → Settings → Web Search → engine *searxng*, query URL `https://admin:<password>@<host>/search?q=<query>` (also in the login info).
3. AI agents (n8n, Hermes, OpenClaw…) can call the same URL with `&format=json`.

## Admin checks

- **Password page in front:** a public SearXNG gets found and abused by bots, and the search engines then block the VM's IP. Caddy's basic auth keeps it private; credentials in the URL work for API clients.
- **Run once** writes `settings.yml` (only if missing): defaults plus the secret, base URL, JSON output (needed by Open WebUI and agents) and `limiter: false` (the limiter needs Valkey and isn't needed behind a login).
- Heavy automated use can still get the IP rate-limited by Google/Bing; SearXNG then falls back to other engines.

## Paid products

None: free in every plan.
