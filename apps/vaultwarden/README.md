# Vaultwarden

Password manager (Bitwarden compatible). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Vaultwarden` |
| Slug | `vaultwarden` |
| Category | `Security` |
| Description | `Password manager (Bitwarden compatible)` |
| Web service | `vaultwarden` |
| Web port | `80` |
| RAM reserved (MB) | `128` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Create your account, then use the Bitwarden apps with the server address {{url}}.
Admin page: {{url}}/admin (token: {{secret}})
```

## Image tags

`vaultwarden/server:latest`: follows Vaultwarden's stable releases. Pin to a release tag once tested.

## First login

1. Open the address and create your account.
2. In the Bitwarden apps / browser extension choose **Self-hosted** and enter the address (`{{url}}`).
3. Admin page: `{{url}}/admin` with the token from the login info.

## Admin checks

- `SIGNUPS_ALLOWED: "true"`: anyone who knows the address can register. Tell the customer to turn sign-ups off in `/admin` once their accounts exist.
- `ADMIN_TOKEN` is a plain token, so Vaultwarden logs a warning recommending an Argon2 hash. It works as is.
- Email (invites, email 2FA, emergency access) needs SMTP, set by the customer in `/admin`.

## Paid products

None: free in every plan.
