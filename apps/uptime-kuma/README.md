# Uptime Kuma

Uptime monitoring. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Uptime Kuma` |
| Slug | `uptime-kuma` |
| Category | `Monitoring` |
| Description | `Uptime monitoring` |
| Web service | `kuma` |
| Web port | `3001` |
| RAM reserved (MB) | `256` |
| Disk reserved (MB) | `1024` |
| Free from | **Q1** |
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

`louislam/uptime-kuma:1` (major pin). Version 2 is a separate major with a database migration: stay on `1` until v2 has been tested.

## First login

1. Open the address.
2. Create the admin account.

## Admin checks

- Notifications (email, Telegram, WhatsApp…) use the customer's own accounts, set inside Uptime Kuma.

## Paid products

None: free in every plan.
