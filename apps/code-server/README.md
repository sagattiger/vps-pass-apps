# code-server

VS Code in the browser. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `code-server` |
| Slug | `code-server` |
| Category | `Developer` |
| Description | `VS Code in the browser` |
| Web service | `code-server` |
| Web port | `8443` |
| RAM reserved (MB) | `512` |
| Disk reserved (MB) | `3072` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Password: {{password}}
sudo password (inside the editor terminal): {{password}}
```

## Image tags

`lscr.io/linuxserver/code-server:latest` (LinuxServer's image of code-server, updated weekly; version tags exist).

## First login

1. Open the address and enter the password from the login info.
2. Projects go in `/config/workspace` (kept in the `config` volume). Open the terminal with Ctrl+`.

## Admin checks

- The editor's terminal runs **inside the container**, not on the VM: `sudo apt install …` works there (sudo password = the login password), but packages are lost when the image updates unless installed again. Files in `/config` are kept.
- No Docker inside the editor (that would need the Docker socket).
- `PROXY_DOMAIN` is the app's host, so code-server's port forwarding links build the right addresses.
- Extensions come from Open VSX (Microsoft's marketplace isn't allowed for code-server).

## Paid products

None: free in every plan.
