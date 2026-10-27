# Ollama

Ollama API for cloud models (no local models). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Ollama` |
| Slug | `ollama` |
| Category | `AI` |
| Description | `Ollama API for cloud models (no local models)` |
| Web service | `proxy` |
| Web port | `8080` |
| RAM reserved (MB) | `192` |
| Disk reserved (MB) | `4096` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
API address: {{url}}
API key (send as "Authorization: Bearer <key>"): {{secret}}
Connect your ollama.com account: open Logs, copy the public key and add it at https://ollama.com/settings/keys. Use cloud model names (ending in -cloud / :cloud).
```

## Image tags

`ollama/ollama:latest` (Ollama ships frequent releases; pin a `0.x.y` tag once tested), `nginx:1-alpine` for the key-protected front.

## First login

1. Open **Logs** on the app card and copy the line after *Ollama public key*.
2. Add it at https://ollama.com/settings/keys (an ollama.com account is needed; cloud usage is billed or limited by that account's plan).
3. Call the API at `{{url}}` with the header `Authorization: Bearer <API key>`, using cloud model names (ending in `-cloud` / `:cloud`, see ollama.com).

## Admin checks

- **Why the extra nginx:** Ollama's API has no authentication, and every cloud request is charged to the customer's ollama.com account. The `proxy` service only lets requests with the app's API key (`{{secret}}`) through. Ollama itself is never on the `qsync` network.
- **Cloud only:** no local models are pulled, so RAM stays small. If a customer pulls a local model, it will use far more RAM than reserved: say in the description that local models aren't supported.
- Tools that can't send a Bearer header (some chat UIs) won't connect; most OpenAI/Ollama clients accept an API key.
- The image is large (~2–3 GB with GPU libraries it doesn't use); disk reserved is 4 GB.

## Paid products

None: free in every plan.
