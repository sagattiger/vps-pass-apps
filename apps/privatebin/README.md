# PrivateBin

Encrypted pastebin and one-time secret sharing. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `PrivateBin` |
| Slug | `privatebin` |
| Category | `Security` |
| Description | `Encrypted pastebin and one-time secret sharing` |
| Web service | `privatebin` |
| Web port | `8080` |
| RAM reserved (MB) | `64` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and paste. No account: texts are encrypted in the browser.
```

## Image tags

`privatebin/nginx-fpm-alpine:latest` (official image: nginx + PHP-FPM, listens on 8080).

## First login

1. Open the address, paste a text, set expiry / burn after reading, and share the link.

## Admin checks

- Zero-knowledge: the key is in the link's `#` part and never reaches the server.
- It's public by design (anyone with the address can create pastes). Abuse is limited by PrivateBin's built-in rate limit; turn creation off or add a password page if a customer gets spam.

## Paid products

None: free in every plan.
