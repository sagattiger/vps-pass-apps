# Homepage

Customizable start page for your apps and services. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Homepage` |
| Slug | `homepage` |
| Category | `Dashboard` |
| Description | `Customizable start page for your apps and services` |
| Web service | `web` |
| Web port | `8080` |
| RAM reserved (MB) | `192` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
User: admin
Password: {{password}}
Edit the dashboard in the VM: docker run --rm -it -v qa{{app_id}}_config:/c alpine vi /c/services.yaml
```

## Image tags

`ghcr.io/gethomepage/homepage:latest` (v1.x; version tags exist, pin one once tested), `caddy:2-alpine` in front for the login.

## First login

1. Open the address and log in as `admin` with the password from the login info.
2. Edit the dashboard in the VM (the files are created on the first start):
   ```bash
   docker run --rm -it -v qa<id>_config:/c alpine vi /c/services.yaml
   ```
   Also `bookmarks.yaml`, `widgets.yaml`, `settings.yaml`. Homepage reloads them automatically.

## Admin checks

- **Homepage has no login of its own**, and its widgets can show data from the services they call, so a small Caddy (`web`) asks for a password first (bcrypt hash made at every start from `{{password}}`), as with CookCLI.
- `HOMEPAGE_ALLOWED_HOSTS` is required since v1 and is set to the app's host; Caddy keeps the original Host header, so it matches.
- No Docker integration: it needs the Docker socket, which templates don't allow. Service widgets that call other apps over HTTPS (Uptime Kuma, Grafana, Nextcloud…) work.
- Editing YAML in the VM is the only way to configure it; consider pairing it with a file editor later if customers ask.

## Paid products

None: free in every plan.
