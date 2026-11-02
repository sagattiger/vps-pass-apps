# LibreChat

ChatGPT-style chat for many AI providers, with agents and search. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `LibreChat` |
| Slug | `librechat` |
| Category | `AI` |
| Description | `ChatGPT-style chat for many AI providers, with agents and search` |
| Web service | `librechat` |
| Web port | `3080` |
| RAM reserved (MB) | `1536` |
| Disk reserved (MB) | `4096` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
if [ ! -f app.env ]; then
  printf 'CREDS_IV=%s\n' "$(head -c 16 /dev/urandom | od -An -tx1 | tr -d ' \n')" > app.env
fi
$COMPOSE create
docker run --rm -v "${P}_images:/v/images" -v "${P}_uploads:/v/uploads" -v "${P}_logs:/v/logs" alpine:3 chown -R 1000:1000 /v/images /v/uploads /v/logs
```

## Login info

```
Open the address right away and register: the first account is the admin.
Add your API keys in the model menu (OpenAI, Anthropic, Google).
```

## Image tags

`ghcr.io/danny-avila/librechat:latest` (official), `mongo:7`, `getmeili/meilisearch:v1.7` (as in LibreChat's compose).

## First login

1. Open the address **right away** and register: the first account is the admin.
2. Then set `ALLOW_REGISTRATION: "false"` in the template and retry the app, unless others should sign up.
3. Pick a provider in the model menu and paste your own API key (keys are `user_provided`, stored encrypted per user).

## Admin checks

- **CPU with AVX required:** MongoDB 5+ needs AVX, which Proxmox's default `x86-64-v2-AES` CPU type lacks (same as Zipline). The VM needs `host` or `x86-64-v3`; otherwise Mongo crashes on start.
- **Run once** writes `CREDS_IV` (exactly 32 hex characters) into `app.env` and gives the upload/image/log volumes to UID 1000. `CREDS_KEY` and `CREDS_IV` encrypt users' saved API keys: keep `app.env`.
- MongoDB runs without auth (`--noauth`), as upstream does; it's only reachable on the app's private network.
- The RAG API (chat with files via embeddings) is left out to save RAM; files can still be attached to models that accept them.
- A `librechat.yaml` (custom endpoints like OpenRouter, Ollama, OmniRoute) isn't mounted; add one later if customers ask.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
