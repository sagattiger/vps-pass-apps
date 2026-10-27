# BookStack

Wiki and documentation. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `BookStack` |
| Slug | `bookstack` |
| Category | `Documents & Notes` |
| Description | `Wiki and documentation` |
| Web service | `bookstack` |
| Web port | `80` |
| RAM reserved (MB) | `512` |
| Disk reserved (MB) | `1536` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
printf 'APP_KEY=base64:%s\n' "$(head -c 32 /dev/urandom | base64)" > bookstack.env
$COMPOSE up -d
DONE=0
for i in $(seq 1 24); do
  if $COMPOSE exec -T bookstack php /app/www/artisan bookstack:create-admin --initial --email="{{email}}" --name="Admin" --password="{{password}}"; then
    DONE=1
    break
  fi
  sleep 10
done
[ "$DONE" = 1 ] || echo "WARNING: admin not set; default login is admin@admin.com / password - change it now"
```

## Login info

```
Email: {{email}}
Password: {{password}}
```

## Image tags

`lscr.io/linuxserver/bookstack:latest` (LinuxServer also publishes version tags: pin once tested), `mariadb:11.4` (LTS).

## First login

1. Log in with the customer's email and the password from the login info.
2. Create shelves, books and pages.

## Admin checks

- **Run once** generates `APP_KEY` (Laravel `base64:` key, which no placeholder can produce) into `bookstack.env` in the app folder, starts the app and sets the admin with `bookstack:create-admin --initial`. If that step fails, the install log says so and the default login `admin@admin.com` / `password` is still active: change it at once.
- `bookstack.env` holds the encryption key: it must survive reinstalls of the app, or sessions and some encrypted settings break.
- Email (password reset, notifications) needs SMTP (`MAIL_*` variables).

## Paid products

None: free in every plan.
