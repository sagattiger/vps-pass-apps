# OpenCloud

File sync and sharing (lightweight Nextcloud alternative). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `OpenCloud` |
| Slug | `opencloud` |
| Category | `Files` |
| Description | `File sync and sharing (lightweight Nextcloud alternative)` |
| Web service | `opencloud` |
| Web port | `9200` |
| RAM reserved (MB) | `768` |
| Disk reserved (MB) | `5120` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE create
docker run --rm -v "${P}_config:/v/config" -v "${P}_data:/v/data" alpine:3 chown -R 1000:1000 /v/config /v/data
```

## Login info

```
User: admin
Password: {{password}}
Desktop and mobile apps: server {{url}}
```

## Image tags

`opencloudeu/opencloud-rolling:latest` (the image used in OpenCloud's Docker docs; a stable `opencloudeu/opencloud` line with version tags also exists, move to it after testing).

## First login

1. Log in as `admin` with the password from the login info.
2. Create users and spaces; install the desktop/mobile apps with server `{{url}}`.

## Admin checks

- `opencloud init` runs at every start but only creates the config once (`|| true` when it exists), with `IDM_ADMIN_PASSWORD` as the admin password.
- **Behind the proxies:** `PROXY_TLS: false` (plain HTTP inside, TLS at Zoraxy), `OC_URL` is the public HTTPS address (OpenCloud's built-in login server uses it as the issuer, so it must match exactly).
- **Run once** gives both volumes to UID 1000 (OpenCloud's user).
- **Uploads:** OpenCloud's docs warn that proxies with small body limits or 60 s timeouts break big uploads (502). Check Zoraxy's limits.
- Collabora/OnlyOffice editing isn't included (separate services and domains).

## Paid products

None: free in every plan.
