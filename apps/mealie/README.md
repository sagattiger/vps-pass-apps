# Mealie

Recipe manager and meal planner. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Mealie` |
| Slug | `mealie` |
| Category | `Lifestyle` |
| Description | `Recipe manager and meal planner` |
| Web service | `mealie` |
| Web port | `9000` |
| RAM reserved (MB) | `384` |
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
  if $COMPOSE exec -T mealie python3 -c "
import sqlite3, sys
c = sqlite3.connect('/app/data/mealie.db')
n = c.execute(\"select count(*) from users where email = 'changeme@example.com'\").fetchone()[0]
sys.exit(0 if n == 1 else 1)
" >/dev/null 2>&1; then ok=1; break; fi
  sleep 10
done
if [ -n "$ok" ] && $COMPOSE exec -T mealie python3 -c "
import sqlite3, bcrypt
h = bcrypt.hashpw(b'{{password}}', bcrypt.gensalt()).decode()
c = sqlite3.connect('/app/data/mealie.db')
c.execute(\"update users set email = ?, password = ? where email = 'changeme@example.com'\", ('{{email}}', h))
c.commit()
"; then
  echo "Mealie default login replaced"
else
  echo "WARNING: default login changeme@example.com / MyPassword is still active - change it now"
fi
```

## Login info

```
Email: {{email}}
Password: {{password}}
```

## Image tags

`ghcr.io/mealie-recipes/mealie:v3.29.0` (pinned, as upstream recommends).

## First login

1. Log in with the customer's email and the password from the login info.
2. Import recipes from any website by URL, plan meals and build shopping lists.

## Admin checks

- **Default login:** Mealie creates `changeme@example.com / MyPassword`, which is public knowledge. **Run once** waits for it and changes it to the customer's email and `{{password}}` (bcrypt, directly in Mealie's SQLite database). If it can't, the log says so; change it at once in the profile.
- Sign-up is off (`ALLOW_SIGNUP: false`); invite household members from the admin page.
- Email invites need SMTP (`SMTP_*`).

## Paid products

None: free in every plan.
