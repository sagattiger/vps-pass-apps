# AnythingLLM

Chat with your documents, AI agents and workspaces. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `AnythingLLM` |
| Slug | `anythingllm` |
| Category | `AI` |
| Description | `Chat with your documents, AI agents and workspaces` |
| Web service | `anythingllm` |
| Web port | `3001` |
| RAM reserved (MB) | `1024` |
| Disk reserved (MB) | `4096` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE create
docker run --rm -v "${P}_storage:/v/storage" alpine:3 chown -R 1000:1000 /v/storage
```

## Login info

```
Password: {{password}}
Then pick an LLM provider (OpenAI, Anthropic, Ollama, OpenRouter...) in the onboarding.
```

## Image tags

`mintplexlabs/anythingllm:latest` (official; version tags exist).

## First login

1. Open the address and enter the password from the login info.
2. Onboarding: choose the LLM (OpenAI, Anthropic, Ollama such as the VPS Pass Ollama app, OpenRouter, OmniRoute…); the built-in embedder and LanceDB vector store work without extra setup.
3. Create a workspace and upload documents.

## Admin checks

- Single-user mode protected by `AUTH_TOKEN` (`{{password}}`). Multi-user mode can be turned on later in the settings (it then asks for an admin account).
- **Run once** gives the `storage` volume to UID 1000 (the image's user).
- Upstream adds `cap_add: SYS_ADMIN` for the Chromium website scraper; templates don't allow it, so **website scraping may not work**. Documents, agents and chat do.
- RAM ~1 GB with the built-in embedder.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
