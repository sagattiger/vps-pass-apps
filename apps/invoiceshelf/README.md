# InvoiceShelf

Invoices, estimates, expenses and payments. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `InvoiceShelf` |
| Slug | `invoiceshelf` |
| Category | `Business` |
| Description | `Invoices, estimates, expenses and payments` |
| Web service | `invoiceshelf` |
| Web port | `8080` |
| RAM reserved (MB) | `256` |
| Disk reserved (MB) | `1024` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
printf 'APP_KEY=base64:%s\n' "$(head -c 32 /dev/urandom | base64)" > app.env
```

## Login info

```
Open the address right away and follow the installer: keep SQLite, then create your company and admin account.
```

## Image tags

`invoiceshelf/invoiceshelf:latest` (v2; `:2` and version tags exist). Chosen over Invoice Ninja: Invoice Ninja's new Debian image needs a separate nginx sharing its files and a config file from their repo, which the template rules (no host files) make fragile.

## First login

1. Open the address right away and follow the installer (whoever opens it first sets it up).
2. Keep **SQLite**, then create the company and your admin account.
3. Settings → Mail: set SMTP so invoices can be emailed.

## Admin checks

- **Run once** writes a Laravel `APP_KEY` (`base64:` key) into `app.env` in the app folder; no placeholder can produce that format. It must survive reinstalls, or encrypted data can't be read.
- `SESSION_DOMAIN`/`SANCTUM_STATEFUL_DOMAINS` are the app's host, needed for login. If pages load over `http://` behind the proxies (mixed content), check that the image honours `TRUSTED_PROXIES`.
- The scheduler (recurring invoices, reminders) runs inside the container.

## Paid products

None: free in every plan.
