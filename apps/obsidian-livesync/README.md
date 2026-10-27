# Obsidian LiveSync

Sync server for Obsidian notes. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Obsidian LiveSync` |
| Slug | `obsidian-livesync` |
| Category | `Documents & Notes` |
| Description | `Sync server for Obsidian notes` |
| Web service | `couchdb` |
| Web port | `5984` |
| RAM reserved (MB) | `256` |
| Disk reserved (MB) | `1024` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
In Obsidian install the "Self-hosted LiveSync" plugin and use:
Server URI: {{url}}
Username: admin
Password: {{password}}
Database name: obsidian (any name; the plugin creates it)
```

## Image tags

`couchdb:3` (major pin; LiveSync works with CouchDB 3.x).

## First login

1. In Obsidian install the community plugin **Self-hosted LiveSync**.
2. Server URI `{{url}}`, username `admin`, password from the login info, database name of your choice (the plugin creates it).
3. Set the sync mode to LiveSync. End-to-end encryption in the plugin is recommended.

## Admin checks

- The container writes `local.d/livesync.ini` at every start: single node, login required, CORS for the Obsidian apps, large document/request sizes. That's why `entrypoint` is overridden; it then runs CouchDB's own entrypoint.
- The web address shows CouchDB's admin (`{{url}}/_utils`) after login; there's no other web page.
- One CouchDB per app: a customer can make one database per vault or per person.

## Paid products

None: free in every plan.
