# Listmonk

Newsletters and mailing lists. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Listmonk` |
| Slug | `listmonk` |
| Category | `Marketing` |
| Description | `Newsletters and mailing lists` |
| Web service | `listmonk` |
| Web port | `9000` |
| RAM reserved (MB) | `192` |
| Disk reserved (MB) | `1024` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE up -d db
for i in $(seq 1 30); do
  $COMPOSE exec -T db pg_isready -U listmonk -d listmonk >/dev/null 2>&1 && break
  sleep 2
done
$COMPOSE run --rm --no-deps -T listmonk ./listmonk --install --idempotent --yes --config ''
$COMPOSE exec -T db psql -U listmonk -d listmonk -c "UPDATE settings SET value = '\"{{url}}\"' WHERE key = 'app.root_url';"
```

## Login info

```
Log in at {{url}}/admin
User: admin
Password: {{password}}
Set your SMTP server in Settings > SMTP before sending.
```

## Image tags

`listmonk/listmonk:latest` (official image), `postgres:17-alpine`, as in the upstream compose.

## First login

1. Open `{{url}}/admin` and log in as `admin` with the password from the login info.
2. **Settings → SMTP**: add the mail server (Amazon SES, Brevo, Mailgun, your own…). Listmonk sends nothing without it.
3. Create a list, import subscribers (CSV) and send a campaign.

## Admin checks

- **Run once** installs the database and writes the public address into Listmonk's settings (`app.root_url` lives in the database, not in an env variable). Without it, unsubscribe and tracking links would point to `localhost:9000`.
- The container command runs `--install --idempotent` and `--upgrade` at every start, as upstream does, so new images migrate themselves.
- **Sending reputation:** customers must use their own SMTP provider. Sending bulk mail straight from the VM would get your IPs blocklisted.

## Paid products

None: free in every plan.
