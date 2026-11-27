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
# The admin user is provisioned by ntfy itself at every start (NTFY_AUTH_USERS, "user:bcrypt-hash:role").
# Only the bcrypt hash is made here, once; ntfy creates its auth database when the server starts.
if [ ! -f auth.env ]; then
  HASH=$(docker run --rm caddy:2-alpine caddy hash-password --plaintext "{{password}}")
  case "$HASH" in
    '$2'*) ;;
    *) echo "could not make the password hash"; exit 1 ;;
  esac
  printf "NTFY_AUTH_USERS='admin:%s:admin'\n" "$HASH" > auth.env
fi
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

- Access is **deny-all** by default with login on: nobody can read or publish without an account. The `admin` user is **provisioned by ntfy at every start** from `NTFY_AUTH_USERS` (`admin:<bcrypt hash>:admin`), loaded from `auth.env` in the app folder. **Run once** only makes that hash (with a throwaway `caddy:2-alpine` container) and writes `auth.env`, once. It no longer runs `ntfy user add`, which failed with *auth-file does not exist* because ntfy only creates `auth.db` when the server starts.
- `auth.env` holds a bcrypt hash, not the password. Users removed from `NTFY_AUTH_USERS` are deleted at the next start; users the customer adds in the web UI or with `ntfy user add` are kept.
- `NTFY_UPSTREAM_BASE_URL: https://ntfy.sh` is needed for instant notifications on iOS (it relays only a poll request, not the message).
- `NTFY_BEHIND_PROXY: true` so ntfy uses the client IP from `X-Forwarded-For` for rate limits (check it after a test install).

## Paid products

None: free in every plan.
