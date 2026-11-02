# 2FAuth

Two-factor authentication codes (TOTP/HOTP) in the browser. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `2FAuth` |
| Slug | `2fauth` |
| Category | `Security` |
| Description | `Two-factor authentication codes (TOTP/HOTP) in the browser` |
| Web service | `2fauth` |
| Web port | `8000` |
| RAM reserved (MB) | `128` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
if [ ! -f app.env ]; then
  printf 'APP_KEY=%s\n' "$(head -c 16 /dev/urandom | od -An -tx1 | tr -d ' \n')" > app.env
fi
```

## Login info

```
Open the address right away and register: the first account is the admin.
Then turn off registration in the admin panel.
```

## Image tags

`2fauth/2fauth:latest` (official; version tags exist).

## First login

1. Open the address **right away** and register: the first account is promoted to admin.
2. Admin → Registration: turn it off.
3. Add accounts by scanning QR codes (or importing from Google Authenticator / Aegis / 2FAS).

## Admin checks

- **Run once** writes `APP_KEY` into `app.env`: 2FAuth needs exactly 32 characters (it encrypts the stored secrets), which no placeholder gives. Back it up with the app folder; without it the stored 2FA secrets can't be read.
- `APP_URL` must be the public address or WebAuthn (passkey login) fails.
- Data (SQLite, icons, keys) is in the `data` volume.

## Paid products

None: free in every plan.
