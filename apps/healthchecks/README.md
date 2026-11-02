# Healthchecks

Cron job and background task monitoring. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Healthchecks` |
| Slug | `healthchecks` |
| Category | `Monitoring` |
| Description | `Cron job and background task monitoring` |
| Web service | `healthchecks` |
| Web port | `8000` |
| RAM reserved (MB) | `256` |
| Disk reserved (MB) | `1024` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE up -d
ok=""
for i in $(seq 1 30); do
  if $COMPOSE exec -T healthchecks /opt/healthchecks/manage.py shell -c "
from django.contrib.auth.models import User
from hc.accounts.views import _make_user
u = User.objects.filter(email='{{email}}').first() or _make_user('{{email}}')
u.set_password('{{password}}')
u.is_staff = True
u.is_superuser = True
u.save()
" >/dev/null 2>&1; then ok=1; break; fi
  sleep 10
done
if [ -n "$ok" ]; then echo "Healthchecks admin created"; else echo "WARNING: admin not created; run manage.py createsuperuser in the healthchecks container"; fi
```

## Login info

```
Email: {{email}}
Password: {{password}}
```

## Image tags

`healthchecks/healthchecks:latest` (the official image; version tags like `v2.x` exist, pin one once tested), `postgres:16-alpine`.

## First login

1. Log in with the customer's email and the password from the login info.
2. Add a check, copy its ping URL, and call it at the end of a cron job: `curl -fsS -m 10 --retry 5 <ping url>`.

## Admin checks

- **Run once** waits for the database migrations and creates the admin (email `{{email}}`, password `{{password}}`) with Healthchecks' own user helper. Sign-up is closed (`REGISTRATION_OPEN: False`), so this is the only account. If it fails, the log says so; create one with `docker compose -p qa<id> exec healthchecks /opt/healthchecks/manage.py createsuperuser`.
- **Alerts by email need SMTP** (`EMAIL_HOST`, `EMAIL_PORT`, `EMAIL_HOST_USER`, `EMAIL_HOST_PASSWORD`, `EMAIL_USE_TLS`). Telegram, Slack, Discord, ntfy, Gotify and webhooks work without it.
- Ping by email (`SMTPD_PORT`) isn't available: it needs a raw TCP port.

## Paid products

None: free in every plan.
