# Grocy

Groceries, pantry and household management. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Grocy` |
| Slug | `grocy` |
| Category | `Lifestyle` |
| Description | `Groceries, pantry and household management` |
| Web service | `web` |
| Web port | `8080` |
| RAM reserved (MB) | `128` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE up -d grocy
for i in $(seq 1 30); do
  $COMPOSE exec -T grocy test -f /config/data/config.php && break
  sleep 5
done
if $COMPOSE exec -T grocy sed -i "s/Setting('DISABLE_AUTH', false);/Setting('DISABLE_AUTH', true);/" /config/data/config.php; then
  echo "Grocy login turned off; Caddy password page protects it"
else
  echo "WARNING: config.php not found; Grocy login is admin / admin - change it now"
fi
```

## Login info

```
User: admin
Password: {{password}}
```

## Image tags

`lscr.io/linuxserver/grocy:latest` (the image Grocy recommends now that its own Docker project is retired), `caddy:2-alpine` in front.

## First login

1. Log in as `admin` with the password from the login info.
2. Settings: currency (BRL), language, then add products and locations.

## Admin checks

- **Login:** Grocy's own default is `admin / admin`. **Run once** turns Grocy's login off (`DISABLE_AUTH` in `config.php`) and Caddy's password page protects the app instead, so there's no default password left. If run once fails, the install log says so; then change Grocy's admin password at once.
- Grocy is effectively single-household: everyone with the password sees the same data.

## Paid products

None: free in every plan.
