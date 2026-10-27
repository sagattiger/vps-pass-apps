# ntfy

Push notifications to phone and desktop. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `ntfy` |
| Slug | `ntfy` |
| Category | `Notifications` |
| Description | `Push notifications to phone and desktop` |
| Web service | `ntfy` |
| Web port | `80` |
| RAM reserved (MB) | `128` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE run --rm --no-deps -T -e NTFY_PASSWORD="{{password}}" ntfy user add --role=admin admin
```

## Login info

```
User: admin
Password: {{password}}
Server for the ntfy apps: {{url}}
```

## Image tags

`binwiederhier/ntfy:latest` (version tags `vX.Y.Z` exist: pin once tested).

## First login

1. Open the address and log in as `admin` with the password from the login info.
2. In the ntfy phone app, add the server `{{url}}` with the same login, then subscribe to topics.
3. Publish: `curl -u admin:<password> -d "Hello" {{url}}/my-topic`.

## Admin checks

- Access is **deny-all** by default with login on: nobody can read or publish without an account. The admin user is created by the run-once command (`ntfy user add`, password from `NTFY_PASSWORD`).
- `NTFY_UPSTREAM_BASE_URL: https://ntfy.sh` is needed for instant notifications on iOS (it relays only a poll request, not the message).
- `NTFY_BEHIND_PROXY: true` so ntfy uses the client IP from `X-Forwarded-For` for rate limits (check it after a test install).

## Paid products

None: free in every plan.
