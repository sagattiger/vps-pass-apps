# Immich

Photo and video backup. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Immich` |
| Slug | `immich` |
| Category | `Photos` |
| Description | `Photo and video backup` |
| Web service | `immich-server` |
| Web port | `2283` |
| RAM reserved (MB) | `2560` |
| Disk reserved (MB) | `10240` |
| Free from | **Q2** (Q1 price R$ 6,99/month) |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and create the admin account (the first account is the admin).
Mobile app server URL: {{url}}
```

## Image tags

`ghcr.io/immich-app/immich-server:v3` and `immich-machine-learning:v3` (major tag, v3 is the current major), `ghcr.io/immich-app/postgres:14-vectorchord0.4.3` (Immich's own Postgres with VectorChord; v3 no longer needs pgvecto.rs), `valkey/valkey:9`.

## First login

1. Open the address and create the admin account (the first account is the admin).
2. Mobile app: enter the server address `{{url}}`.

## Admin checks

- **CPU type:** v3's machine-learning container needs an x86-64-v2 CPU. Proxmox's default `x86-64-v2-AES` (or `host`) is fine; the old `kvm64` type is not, and face/smart search would fail.
- RAM 2.5 GB: server + machine learning + Postgres. That's why it's free only from Q2 (Q1 has 3 GB for apps).
- Disk reserved 10 GB covers the images (~3.6 GB) and a start; photos grow from there. Watch disk use on busy customers.
- Large uploads go through Zoraxy and two Traefiks: check that no proxy body-size limit blocks videos.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Q1 price: **R$ 6,99/month**.
