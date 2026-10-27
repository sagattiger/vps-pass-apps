# Homelable

Infrastructure map with live status checks. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Homelable` |
| Slug | `homelable` |
| Category | `Monitoring` |
| Description | `Infrastructure map with live status checks` |
| Web service | `frontend` |
| Web port | `80` |
| RAM reserved (MB) | `256` |
| Disk reserved (MB) | `1024` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
HASH=$($COMPOSE run --rm --no-deps -T --entrypoint python backend -c 'import bcrypt; print(bcrypt.hashpw(b"{{password}}", bcrypt.gensalt()).decode())')
printf "AUTH_PASSWORD_HASH='%s'\n" "$HASH" > auth.env
```

## Login info

```
User: admin
Password: {{password}}
```

## Image tags

`ghcr.io/pouzor/homelable-frontend:latest` and `homelable-backend:latest` (the project publishes `latest` builds).

## First login

1. Open the address and log in as `admin` with the password from the login info.
2. Add nodes by hand, or import from Proxmox / Zigbee2MQTT; status checks run every 60 s.

## Admin checks

- The run-once command makes the bcrypt hash of the password with the backend image and writes it to `auth.env` in the app folder (loaded with `env_file`, `required: false`). Without it the login is `admin` / `admin`, so check the install log if login fails.
- **Network scanning is off** (`SCANNER_RANGES: "[]"`): in a VPS Pass there's no home network to scan. Health checks of public hosts, the canvas and imports work. Docker's default capabilities already include `NET_RAW`, so ping checks work without `cap_add`.
- The MCP server (port 8001) isn't included: one address per app.

## Paid products

None: free in every plan.
