# Vikunja

Tasks, lists and project boards. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Vikunja` |
| Slug | `vikunja` |
| Category | `Productivity` |
| Description | `Tasks, lists and project boards` |
| Web service | `vikunja` |
| Web port | `3456` |
| RAM reserved (MB) | `128` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE create
docker run --rm -v "${P}_files:/f" -v "${P}_db:/d" alpine:3 chown -R 1000:1000 /f /d
```

## Login info

```
Open the address and register your account.
Then turn off registration (see the app README) if only you will use it.
```

## Image tags

`vikunja/vikunja:latest` (single image with API and frontend; version tags exist, pin one once tested).

## First login

1. Open the address and register.
2. To close registration after your users exist, add `VIKUNJA_SERVICE_ENABLEREGISTRATION: "false"` to the template and retry the app.

## Admin checks

- Vikunja runs as UID 1000, so **run once** creates the volumes (`compose create`) and gives them to UID 1000 with a throwaway `alpine` container. Without it Vikunja can't write its SQLite file.
- Both `VIKUNJA_SERVICE_SECRET` (current name) and `VIKUNJA_SERVICE_JWTSECRET` (older name) are set to the same secret.
- Email reminders need SMTP (`VIKUNJA_MAILER_*`).

## Paid products

None: free in every plan.
