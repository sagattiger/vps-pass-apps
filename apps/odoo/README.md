# Odoo

ERP, CRM, invoicing, inventory and website (Community). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Odoo` |
| Slug | `odoo` |
| Category | `Business` |
| Description | `ERP, CRM, invoicing, inventory and website (Community)` |
| Web service | `odoo` |
| Web port | `8069` |
| RAM reserved (MB) | `1536` |
| Disk reserved (MB) | `4096` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE up -d db
FLAG=""
if $COMPOSE run --rm -T odoo odoo --help 2>/dev/null | grep -q -- '--without-demo'; then FLAG="--without-demo=all"; fi
$COMPOSE run --rm -T odoo odoo -i base -d odoo --stop-after-init $FLAG
echo "env.ref('base.user_admin').password = '{{secret2}}'; env.cr.commit()" | $COMPOSE run --rm -T odoo odoo shell -d odoo --no-http
echo "Odoo database created, admin password set"
```

## Login info

```
Email/login: admin
Password: {{secret2}}
Change the admin login to your email in Settings > Users.
```

## Image tags

`odoo:20.0` (Odoo 20, released September 2026; the official Community image), `postgres:16-alpine` (Odoo 20 needs PostgreSQL 16+).

## First login

1. Log in with `admin` and the password from the login info.
2. Settings → Users: change the admin login to your email.
3. Apps: install what you need (Invoicing, CRM, Sales, Inventory, Website…). Settings → Languages: add Portuguese if needed.

## Admin checks

- **Run once** creates the `odoo` database with the base module (demo data off: it detects whether this Odoo has `--without-demo`) and sets the admin password through `odoo shell`. Without it Odoo would open its database manager to anyone.
- `--no-database-list` and `--db-filter ^odoo$`: the database manager is off, so nobody can create, copy or drop databases from the web. Backups are made from the VM (`pg_dump`, plus the `data` volume for attachments).
- `--proxy-mode`: Odoo trusts the forwarded HTTPS headers. Live chat and notifications use `/websocket` on the same port (no workers configured), so no extra routing is needed.
- **Sizing:** fine for a small company with a few users. Upstream suggests 4 GB+ for production; that's why it's free from Q2. Many users or heavy apps belong on Q3.
- Extra modules go into the `addons` volume (`/mnt/extra-addons`).

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
