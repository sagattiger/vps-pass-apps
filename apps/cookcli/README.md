# CookCLI

Recipe book for Cooklang recipes. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `CookCLI` |
| Slug | `cookcli` |
| Category | `Lifestyle` |
| Description | `Recipe book for Cooklang recipes` |
| Web service | `web` |
| Web port | `8080` |
| RAM reserved (MB) | `64` |
| Disk reserved (MB) | `256` |
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
```

## Image tags

`ghcr.io/cooklang/cookcli:latest` (version tags like `0.23.0` exist; pin one once tested), `caddy:2-alpine` in front for the login.

## First login

1. Open the address and log in as `admin` with the password from the login info.
2. Create recipes with the **new recipe** form, or browse, scale recipes and build shopping lists.

## Admin checks

- CookCLI has **no login of its own**, so a small Caddy (`web`) asks for a password (basic auth, bcrypt hash made at every start from `{{password}}`) before anything reaches the recipes.
- Recipes are `.cook` files in the `recipes` volume, empty at first. Bulk import of existing files isn't possible from outside (no host paths): the customer adds them with the web form.
- If saving a new recipe fails, check that the cookcli container can write to `/recipes` (volume ownership) and that its same-origin check accepts the forwarded host; `--no-csrf-check` is the fallback.

## Paid products

None: free in every plan.
