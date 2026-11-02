# Gatus

Status page and uptime checks from a YAML file. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Gatus` |
| Slug | `gatus` |
| Category | `Monitoring` |
| Description | `Status page and uptime checks from a YAML file` |
| Web service | `gatus` |
| Web port | `8080` |
| RAM reserved (MB) | `64` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE create
docker run --rm -v "${P}_config:/c" alpine:3 sh -c 'if [ ! -f /c/config.yaml ]; then cat > /c/config.yaml <<"YML"
storage:
  type: sqlite
  path: /data/data.db

ui:
  title: Status

endpoints:
  - name: This status page
    group: Example
    url: "{{url}}/health"
    interval: 5m
    conditions:
      - "[STATUS] == 200"
YML
fi'
```

## Login info

```
Status page: {{url}}
Edit the checks in the VM:
docker run --rm -it -v qa{{app_id}}_config:/c alpine vi /c/config.yaml
then: cd /opt/qsync/apps/{{app_id}} && docker compose -p qa{{app_id}} restart gatus
```

## Image tags

`ghcr.io/twin/gatus:v5.35.0` (pinned).

## First login

1. Open the address: the status page shows the example check.
2. Edit `config.yaml` in the VM (command in the login info), add your endpoints, restart the container.

## Admin checks

- **Run once** writes a starter `config.yaml` (only if missing): SQLite storage in `/data` and one example endpoint pointing to the app's own address. The image has no shell, so a throwaway `alpine` container writes the file into the volume after `compose create`.
- The status page is **public** (that's its purpose). To make it private, add `security.basic` (username plus bcrypt password, base64-encoded) to the config.
- Alerts (Telegram, Slack, Discord, email, ntfy, Gotify…) are set in the same file.

## Paid products

None: free in every plan.
