# Evolution API

WhatsApp API. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Evolution API` |
| Slug | `evolution-api` |
| Category | `Messaging` |
| Description | `WhatsApp API` |
| Web service | `api` |
| Web port | `8080` |
| RAM reserved (MB) | `768` |
| Disk reserved (MB) | `3072` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Manager: {{url}}/manager
API key: {{secret}}
```

## Image tags

`evoapicloud/evolution-api:v2.2.3` (pinned release), `postgres:16-alpine`, `redis:7-alpine`.

The project moved its images from `atendai/evolution-api` to `evoapicloud/evolution-api`; pulls from the old name now fail ("could not download the app images"). Same version, same variables. Newer v2.3.x releases exist under the new name: test one before moving the pin.

## First login

1. Open `{{url}}/manager`.
2. Log in with the API key from the login info.
3. Create an instance and scan the QR code with WhatsApp.

## Admin checks

- The API key is the global admin key: anyone with it controls every instance. The customer must keep it private.
- RAM 768 MB covers the API, Postgres and Redis together.

## Paid products

None: free in every plan.
