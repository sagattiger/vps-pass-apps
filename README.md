# vps-pass-apps

Docker compose templates for the **VPS Pass** app catalogue (qsync). In the admin and in the code the product is still called **Core VPS**: Paymenter → Proxmox → Core VPS apps.

Each app is one folder under `apps/`:

```
apps/<slug>/
  docker-compose.yml   the template, pasted into "Docker compose"
  app.json             the catalogue fields (name, web service/port, RAM, disk, free from, login info)
  setup.sh             optional: "Run once before the first start"
  README.md            paste guide, image tags, first login, admin checks, paid products
```

## Apps

| App | Slug | Category | Web service:port | RAM MB | Disk MB | Free from | Status |
|---|---|---|---|---|---|---|---|
| [n8n](apps/n8n) | `n8n` | Automation | `n8n:5678` | 512 | 2048 | Q1 | Testing |
| [Evolution API](apps/evolution-api) | `evolution-api` | Messaging | `api:8080` | 768 | 3072 | Q1 | Testing |
| [Uptime Kuma](apps/uptime-kuma) | `uptime-kuma` | Monitoring | `kuma:3001` | 256 | 1024 | Q1 | Testing |
| [Vaultwarden](apps/vaultwarden) | `vaultwarden` | Security | `vaultwarden:80` | 128 | 512 | Q1 | Testing |
| [Gitea](apps/gitea) | `gitea` | Developer | `gitea:3000` | 384 | 2048 | Q2 | Testing |
| [NocoDB](apps/nocodb) | `nocodb` | Productivity | `nocodb:8080` | 384 | 1024 | Q2 | Testing |
| [WordPress](apps/wordpress) | `wordpress` | Websites | `wordpress:80` | 512 | 3072 | Q2 | Testing |
| [Flowise](apps/flowise) | `flowise` | AI | `flowise:3000` | 768 | 2048 | Q2 | Testing |
| [Metabase](apps/metabase) | `metabase` | Analytics | `metabase:3000` | 1536 | 2048 | Q3 | Testing |
| [Chatwoot](apps/chatwoot) | `chatwoot` | Support | `rails:3000` | 2048 | 4096 | Q3 | Testing |

The first ten are the starter apps of the Proxmox extension (`Services/CoreCatalog.php` in the Proxmox extension repo). When one changes here, change it in the admin catalogue too; the starter list in the extension is only copied into the database once.

## Plans

| Plan | VM | Left for apps |
|---|---|---|
| Q1 | 2 vCPU / 4 GB / 32 GB | 3 GB RAM / 24 GB disk |
| Q2 | 2 vCPU / 8 GB / 64 GB | 7 GB RAM / 56 GB disk |
| Q3 | 4 vCPU / 16 GB / 128 GB | 15 GB RAM / 120 GB disk |

**Free from** Q1 = free in every plan; Q2 = paid in Q1; Q3 = paid in Q1 and Q2. Everything is free in Q3. Paid apps need *Core VPS app* products: a Q1 price, plus a cheaper Q2 price when the app is free only from Q3.

## How an app is installed

The installer writes the template to `/opt/qsync/apps/<id>/` inside the customer's VM, fills the placeholders, adds a `qsync.yml` with the Traefik labels and the `qsync` network for the web service, runs `pull`, the optional run-once command, then `up -d`. The app is reached at `https://<name>.apps.qsync.net`. TLS ends at the edge proxy, so the app gets plain HTTP with `X-Forwarded-Proto: https`.

## Template rules

The installer does not parse YAML, so the layout matters.

1. Top-level `services:`, 2-space indent, no tabs. The web service is on its own line as `  <web_service>:`.
2. Every service has `restart: unless-stopped`.
3. No `ports:`. Traefik reaches the web service over the `qsync` network (HTTP only; a raw TCP/UDP port needs a separate discussion).
4. No `container_name:` (the same app can be installed twice).
5. Named volumes only, declared under top-level `volumes:` with `{}`. No host paths, Docker socket, `privileged`, `network_mode: host`, and no `cap_add` unless unavoidable.
6. No CPU/RAM limits (`mem_limit`, `cpus`, `deploy.resources`): the VM is the limit, and **RAM reserved** does the accounting.
7. No Traefik labels and no `qsync` network: the installer adds them.
8. A literal `$` is written `$$`.
9. Pin images to a major version or a known tag when the project publishes stable ones; say so in the README when only `latest` exists.
10. `depends_on` for startup order, plus a healthcheck when the app crashes on a cold database.
11. Set the app's public URL to `{{url}}` and never enable its own HTTPS / Let's Encrypt / "force SSL".

### Placeholders

Always inside double quotes: `KEY: "{{secret}}"`. Generated once per installed app and kept.

| Placeholder | Value |
|---|---|
| `{{host}}` | `n8n-ab12.apps.qsync.net` |
| `{{url}}` | `https://n8n-ab12.apps.qsync.net` |
| `{{password}}` | 24 letters and digits (database passwords) |
| `{{secret}}`, `{{secret2}}` | 40 letters and digits (API keys, admin tokens, encryption keys) |
| `{{hex64}}` | 64 hex characters (e.g. Rails `SECRET_KEY_BASE`) |
| `{{email}}` | the customer's email |
| `{{app_id}}` | the numeric app id |
| `{{tz}}` | Paymenter's timezone, e.g. `America/Sao_Paulo` |

Any other `{{name}}` stays literal.

## Adding an app

1. Create `apps/<slug>/` (lowercase `a-z0-9-`; the slug also picks the selfh.st logo).
2. Write `docker-compose.yml`, `app.json` (copy one from another app) and, if needed, `setup.sh`.
3. Write `README.md`: catalogue fields, image tags and why, first login, admin checks (SMTP, proxy hops…), paid products.
4. Run the validator:
   ```bash
   pip install pyyaml
   python3 scripts/validate.py              # every app
   python3 scripts/validate.py apps/<slug>  # one app
   ```
   It checks the rules above, renders the placeholders with sample values and runs `docker compose config` with the merged `qsync.yml` (only the Docker CLI with the compose plugin is needed, no daemon). The same check runs on every push (GitHub Actions).
5. Add the app in the admin with status **Testing**. Install it on a real VPS Pass and follow it with `php artisan proxmox:core --app=<id> --logs`. When it works, set it to **Stable** here and in the admin.
6. Add a row to the table above.

## Sizing

- Tiny single binary (Uptime Kuma, Vaultwarden): 128–256 MB, free from Q1.
- Node/Go app with SQLite (n8n, Gitea, NocoDB): 384–512 MB, Q1 or Q2.
- App plus Postgres/Redis (Evolution API, WordPress + MariaDB): 512–768 MB, Q1 or Q2.
- JVM / Rails / multi-service (Metabase, Chatwoot): 1.5–2 GB or more, free from Q3.
- Disk = image pull size plus data growth; 1–4 GB is typical.
