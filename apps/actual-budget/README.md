# Actual Budget

Personal budgeting. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Actual Budget` |
| Slug | `actual-budget` |
| Category | `Finance` |
| Description | `Personal budgeting` |
| Web service | `actual` |
| Web port | `5006` |
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
Open the address and set the server password on the first screen.
```

## Image tags

`actualbudget/actual-server:latest` (monthly releases with version tags: pin once tested).

## First login

1. Open the address.
2. Set the server password on the first screen.
3. Create a budget file or import one.

## Admin checks

- Budgets can be end-to-end encrypted by the customer from the app settings (separate password).

## Paid products

None: free in every plan.
