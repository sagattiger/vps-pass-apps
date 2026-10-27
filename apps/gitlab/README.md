# GitLab

Git hosting with CI/CD. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `GitLab` |
| Slug | `gitlab` |
| Category | `Developer` |
| Description | `Git hosting with CI/CD` |
| Web service | `gitlab` |
| Web port | `80` |
| RAM reserved (MB) | `3072` |
| Disk reserved (MB) | `10240` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
The first start takes 5-10 minutes.
User: root
Password: {{password}}
Then turn off public sign-up in Admin > Settings > General.
```

## Image tags

`gitlab/gitlab-ce:19.5.1-ce.0` (exact pin on purpose: GitLab must be upgraded through its required upgrade stops, so never use `latest`).

## First login

1. Wait 5–10 minutes: the first start configures everything. The install may end as *still starting*; that's normal.
2. Log in as `root` with the password from the login info.
3. Turn off public sign-up: **Admin → Settings → General → Sign-up restrictions**.

## Admin checks

- **RAM:** tuned for low memory (Puma single mode, Sidekiq 10, no Prometheus/KAS) and still needs ~3 GB, **all of Q1's app space**. Free from Q1 as asked, but a Q1 customer can't run anything next to it, and it will be slow on 2 vCPU. Consider making it free from Q2.
- No SSH (HTTP-only routing): clone over HTTPS with a personal access token. No container registry, no Pages.
- CI needs a GitLab Runner somewhere else; it isn't part of this template.
- `initial_root_password` only applies on the first start.

## Paid products

None: free in every plan.
