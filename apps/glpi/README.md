# GLPI

IT service desk and asset management. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `GLPI` |
| Slug | `glpi` |
| Category | `Business` |
| Description | `IT service desk and asset management` |
| Web service | `glpi` |
| Web port | `80` |
| RAM reserved (MB) | `512` |
| Disk reserved (MB) | `2048` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE up -d
ok=""
for i in $(seq 1 40); do
  n=$($COMPOSE exec -T db mariadb -uglpi -p"{{password}}" glpi -N -e "SELECT COUNT(*) FROM glpi_users WHERE name='glpi'" 2>/dev/null || true)
  if [ "$n" = "1" ]; then ok=1; break; fi
  sleep 10
done
if [ -n "$ok" ]; then
  HASH=$($COMPOSE exec -T glpi php -r 'echo password_hash($argv[1], PASSWORD_DEFAULT);' "{{secret2}}")
  $COMPOSE exec -T db mariadb -uglpi -p"{{password}}" glpi -e "UPDATE glpi_users SET password='$HASH' WHERE name='glpi'; UPDATE glpi_users SET is_active=0 WHERE name IN ('tech','normal','post-only');"
  echo "GLPI admin password set, demo accounts disabled"
else
  echo "WARNING: GLPI not installed yet; log in with glpi/glpi and change the passwords of glpi, tech, normal and post-only now"
fi
```

## Login info

```
User: glpi
Password: {{secret2}}
(The demo accounts tech, normal and post-only are disabled.)
```

## Image tags

`glpi/glpi:latest` (the official image, GLPI 11; version tags exist), `mariadb:11.4` (LTS).

## First login

1. Log in as `glpi` with the password from the login info.
2. Setup → General: set the URL of the application to `{{url}}` if links in emails are wrong.
3. Create entities, users and categories; optionally install the GLPI Agent on computers to send inventory.

## Admin checks

- The image installs the database by itself on the first start.
- **Default accounts:** GLPI creates `glpi/glpi`, `tech/tech`, `normal/normal` and `post-only/postonly`, which bots try. **Run once** waits for the install, sets a bcrypt password (`{{secret2}}`) on `glpi` and disables the other three. If the install takes longer than ~6 minutes, the log says so and they must be changed by hand at once.
- Automatic actions run in GLPI mode (triggered by visits) unless the customer sets up CLI cron.
- Email (notifications, mail collectors) needs SMTP/IMAP set in Setup → Notifications.

## Paid products

None: free in every plan.
