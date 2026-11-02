# Mautic

Marketing automation, email campaigns and lead scoring. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Mautic` |
| Slug | `mautic` |
| Category | `Marketing` |
| Description | `Marketing automation, email campaigns and lead scoring` |
| Web service | `mautic_web` |
| Web port | `80` |
| RAM reserved (MB) | `1024` |
| Disk reserved (MB) | `3072` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE up -d
for i in $(seq 1 30); do
  $COMPOSE exec -T mautic_web test -f /var/www/html/bin/console >/dev/null 2>&1 && break
  sleep 5
done
if $COMPOSE exec -T -u www-data mautic_web php /var/www/html/bin/console mautic:install "{{url}}" --db_host=db --db_port=3306 --db_name=mautic --db_user=mautic --db_password="{{password}}" --admin_firstname=Admin --admin_lastname=User --admin_username=admin --admin_email="{{email}}" --admin_password="{{secret2}}!"; then
  echo "Mautic installed"
else
  echo "WARNING: command-line install failed; open the address right away and finish the web installer"
fi
```

## Login info

```
User: admin
Password: {{secret2}}!
Then Settings > Configuration > Email Settings: add your SMTP / email provider.
```

## Image tags

`mautic/mautic:6-apache` (official image, one image for the web, cron and worker roles; Mautic 7 exists, move the tag after testing it), `mysql:8.4`.

## First login

1. Log in as `admin` with the password from the login info (it ends with `!`).
2. **Settings → Configuration → Email Settings**: add the email provider (SMTP, Amazon SES, Brevo…). Mautic can't send campaigns without it.
3. Add the tracking script to the customer's website.

## Admin checks

- **Run once** starts the stack and runs `mautic:install` from the command line (site URL `{{url}}`, database, admin `admin` with `{{secret2}}!`; Mautic 5.1+ demands a complex password, hence the `!`). If it fails, the log says so and the web installer is shown instead: open the address **right away** and finish it there.
- Three containers share the volumes: web, cron (segment updates, campaigns, scheduled emails) and the queue worker.
- `MAUTIC_TRUSTED_PROXIES` trusts the forwarded HTTPS headers.
- **Sending reputation:** customers must use their own email provider; bulk mail from the VM's IP would get it blocklisted.
- RAM ~1 GB for three PHP containers plus MySQL, so it's free from Q2.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
