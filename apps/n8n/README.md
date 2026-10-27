# n8n

Workflow automation. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `n8n` |
| Slug | `n8n` |
| Category | `Automation` |
| Description | `Workflow automation` |
| Web service | `n8n` |
| Web port | `5678` |
| RAM reserved (MB) | `512` |
| Disk reserved (MB) | `2048` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and create the owner account.
```

## Image tags

`docker.n8n.io/n8nio/n8n:latest`: n8n's `latest` follows the stable release line. Pin to a version tag once a version has been tested on a real VPS Pass.

## First login

1. Open the address.
2. Create the owner account (email + password).

## Admin checks

- **Proxy hops:** after a test install, trigger a workflow with a Webhook node and look at the client IP n8n logs. If it shows a proxy address instead of the visitor's, raise `N8N_PROXY_HOPS` (Zoraxy + central Traefik + VM Traefik can mean 2–3).
- `N8N_ENCRYPTION_KEY` must never change after the install, or saved credentials can't be decrypted. The placeholder is generated once and kept, so only a manual edit would break it.
- Email (invites, password reset) needs SMTP set by the customer (`N8N_SMTP_*`).

## Paid products

None: free in every plan.
