# Home Assistant

Home automation (container edition). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Home Assistant` |
| Slug | `home-assistant` |
| Category | `Home automation` |
| Description | `Home automation (container edition)` |
| Web service | `homeassistant` |
| Web port | `8123` |
| RAM reserved (MB) | `512` |
| Disk reserved (MB) | `3072` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE run --rm --no-deps -T --entrypoint sh homeassistant -c '
[ -f /config/configuration.yaml ] && exit 0
cat > /config/configuration.yaml <<EOF
default_config:

http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 10.0.0.0/8
    - 172.16.0.0/12
    - 192.168.0.0/16

automation: !include automations.yaml
script: !include scripts.yaml
scene: !include scenes.yaml
EOF
echo "[]" > /config/automations.yaml
: > /config/scripts.yaml
echo "[]" > /config/scenes.yaml
'
```

## Login info

```
Open the address and create the owner account.
```

## Image tags

`ghcr.io/home-assistant/home-assistant:stable` (the official stable channel).

## First login

1. Open the address and create the owner account (open it right away: the first visitor does the onboarding).
2. Add cloud-based integrations.

## Admin checks

- **This is Home Assistant Container, not Home Assistant OS.** HAOS is a whole operating system and can't run in Docker. No Supervisor, no add-ons store, no backups from the UI.
- **It runs in our datacenter, not in the customer's home:** no USB (Zigbee/Z-Wave sticks), no local device discovery, no Bluetooth. Only cloud integrations work, or local devices through a VPN the customer sets up. Say this clearly on the product page.
- The run-once command writes `configuration.yaml` with `use_x_forwarded_for` and `trusted_proxies` (Docker private ranges). Without it Home Assistant answers **400 Bad Request** behind the proxies.

## Paid products

None: free in every plan.
