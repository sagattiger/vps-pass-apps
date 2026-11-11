# Flowise

AI agents and chatflows. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Flowise` |
| Slug | `flowise` |
| Category | `AI` |
| Description | `AI agents and chatflows` |
| Web service | `flowise` |
| Web port | `3000` |
| RAM reserved (MB) | `768` |
| Disk reserved (MB) | `2048` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and create the admin account.
```

## Image tags

`flowiseai/flowise:3.1.3`, pinned on purpose. **Never use `latest`:** images built after `connect-sqlite3` 0.9.17 was published (including `latest` and 3.1.4) crash at start with `TypeError: this.db.exec is not a function` (restart loop, 502 in the browser). The official 3.1.3 image was built before that change and starts ([Flowise#6688](https://github.com/FlowiseAI/Flowise/issues/6688)). The `@smithy/eventstream-codec` error still printed at start only disables the AWS Bedrock node; the server runs.

**Flowise is end-of-life** (announced 2026-08-03, repo archived in August 2026): no more official releases or security fixes. The 3.1.3 image reportedly contains the 3.1.2 server code. Treat it as legacy: keep it for existing customers, and point new AI-flow customers to Activepieces, n8n, LibreChat or AnythingLLM. A community fork exists (Flow-Wiser, `dblagbro/flow-wiser`), not affiliated with FlowiseAI and not tested here.

## First login

1. Open the address.
2. Create the admin account.

## Admin checks

- LLM API keys (OpenAI, etc.) are the customer's own, saved as Flowise credentials.
- If the customer uses Flowise's rate limiting, set `NUMBER_OF_PROXIES` after checking the client IP it logs (same proxy-hop rule as n8n).

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
