# ERPNext

Full ERP: accounting, stock, sales, HR, manufacturing. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `ERPNext` |
| Slug | `erpnext` |
| Category | `Business` |
| Description | `Full ERP: accounting, stock, sales, HR, manufacturing` |
| Web service | `frontend` |
| Web port | `8080` |
| RAM reserved (MB) | `3072` |
| Disk reserved (MB) | `8192` |
| Free from | **Q3** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE up -d db redis-cache redis-queue
for i in $(seq 1 30); do
  $COMPOSE exec -T db mariadb-admin ping -uroot -p"{{password}}" >/dev/null 2>&1 && break
  sleep 3
done
$COMPOSE run --rm --no-deps -T backend bash -c 'ls -1 apps > sites/apps.txt; bench set-config -g db_host db; bench set-config -gp db_port 3306; bench set-config -g redis_cache redis://redis-cache:6379; bench set-config -g redis_queue redis://redis-queue:6379; bench set-config -g redis_socketio redis://redis-queue:6379; bench set-config -gp socketio_port 9000'
if ! $COMPOSE run --rm --no-deps -T backend test -d sites/frontend; then
  $COMPOSE run --rm --no-deps -T backend bench new-site --mariadb-user-host-login-scope='%' --admin-password='{{secret2}}' --db-root-username=root --db-root-password='{{password}}' --install-app erpnext --set-default frontend
fi
$COMPOSE run --rm --no-deps -T backend bench --site frontend set-config host_name '{{url}}'
echo "ERPNext site created"
```

## Login info

```
User: Administrator
Password: {{secret2}}
The setup wizard (company, country, currency) opens after the first login.
```

## Image tags

`frappe/erpnext:v16` (ERPNext 16, currently v16.53.0; one image for all Frappe services), `mariadb:11.4` (LTS), `redis:7-alpine`. Same layout as frappe_docker's `pwd.yml`.

## First login

1. Log in as `Administrator` with the password from the login info.
2. Complete the setup wizard: language, country (Brazil sets the chart of accounts and taxes), currency, company.
3. Add users from the Users list.

## Admin checks

- **Nine services:** web (nginx), backend (gunicorn), websocket, two queue workers, scheduler, MariaDB and two Redis. The one-shot `configurator` and `create-site` services of `pwd.yml` are done by **run once** instead (they would restart in a loop with `restart: unless-stopped`): global config, then `bench new-site frontend` with the admin password `{{secret2}}`, then `host_name` = `{{url}}` so links and emails use HTTPS.
- The site is called `frontend` internally (`FRAPPE_SITE_NAME_HEADER`), so any host name works.
- **Heavy:** ~2.5–3 GB RAM and 4 vCPU recommended, so free only from Q3 (paid in Q1 and Q2). The first install takes several minutes and may end as *still starting*.
- Upgrades: pull a new `v16` image, then `bench --site frontend migrate` in the backend container.

## Paid products

Needs a **Q1 price** and a (cheaper) **Q2 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q3. Price not set yet.
