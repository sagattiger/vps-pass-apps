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

`flowiseai/flowise:latest`. Flowise also publishes version tags: pin to one once tested.

## First login

1. Open the address.
2. Create the admin account.

## Admin checks

- LLM API keys (OpenAI, etc.) are the customer's own, saved as Flowise credentials.
- If the customer uses Flowise's rate limiting, set `NUMBER_OF_PROXIES` after checking the client IP it logs (same proxy-hop rule as n8n).

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3.
