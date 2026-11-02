# Umami

Privacy-friendly website analytics. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Umami` |
| Slug | `umami` |
| Category | `Analytics` |
| Description | `Privacy-friendly website analytics` |
| Web service | `umami` |
| Web port | `3000` |
| RAM reserved (MB) | `384` |
| Disk reserved (MB) | `1536` |
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
  n=$($COMPOSE exec -T db psql -U umami -d umami -tAc "SELECT COUNT(*) FROM \"user\" WHERE username='admin'" 2>/dev/null || true)
  if [ "$n" = "1" ]; then ok=1; break; fi
  sleep 10
done
if [ -n "$ok" ]; then
  $COMPOSE exec -T db psql -U umami -d umami -c "CREATE EXTENSION IF NOT EXISTS pgcrypto; UPDATE \"user\" SET password = crypt('{{password}}', gen_salt('bf', 10)) WHERE username = 'admin';"
  echo "Umami admin password set"
else
  echo "WARNING: admin user not found; the login is still admin / umami - change it now"
fi
```

## Login info

```
User: admin
Password: {{password}}
Add a website in Settings and paste its tracking script into your site.
```

## Image tags

`ghcr.io/umami-software/umami:latest` (v3, PostgreSQL only; version tags like `v3.0.3` exist), `postgres:16-alpine`.

## First login

1. Log in as `admin` with the password from the login info.
2. Settings → Websites → Add website, then put the tracking script in the site's `<head>`.

## Admin checks

- **Run once** starts the app, waits for Umami to create its default `admin / umami` account and replaces that password with `{{password}}` (bcrypt through Postgres `pgcrypto`). If it can't, the install log says so and the default password must be changed at once.
- The tracking script and the `/api/send` endpoint must stay public, so there's no password page in front; only the dashboard needs the login.
- Umami is a Next.js app, not Fastify, so the Zoraxy 415 problem from Docmost shouldn't apply. If the dashboard stays blank, check the browser console for 415s.

## Paid products

None: free in every plan.
