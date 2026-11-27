# Paperclip

Run a company of AI agents. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Paperclip` |
| Slug | `paperclip` |
| Category | `AI` |
| Description | `Run a company of AI agents` |
| Web service | `paperclip` |
| Web port | `3100` |
| RAM reserved (MB) | `1024` |
| Disk reserved (MB) | `4096` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
# Paperclip only creates the first-admin invite by itself with its embedded database; this template
# uses Postgres, so the invite is made here with the CLI that ships in the image (pnpm paperclipai,
# run as the "node" user). Never use npx for this: it downloads another copy of Paperclip.
$COMPOSE up -d
INVITE=""
for i in $(seq 1 30); do
  OUT=$($COMPOSE exec -T -u node paperclip pnpm paperclipai auth bootstrap-ceo --base-url "{{url}}" --expires-hours 720 2>&1 | sed 's/\x1b\[[0-9;]*m//g') && {
    INVITE=$(printf '%s\n' "$OUT" | grep -o '{{url}}[^ ]*' | tail -1)
    break
  }
  case "$OUT" in
    *"already exists"*|*"--force"*) INVITE="(an admin already exists)"; break ;;
  esac
  sleep 10
done
if [ -n "$INVITE" ]; then
  echo "Paperclip first-admin invite (valid 30 days): $INVITE"
else
  echo "WARNING: no invite yet. In the VM run:"
  echo "  docker compose -p qa{{app_id}} exec -u node paperclip pnpm paperclipai auth bootstrap-ceo --base-url {{url}}"
fi
```

## Login info

```
Create the first admin with an invite link. Make one in the VM:
cd /opt/qsync/apps/{{app_id}} && docker compose -p qa{{app_id}} exec -u node paperclip pnpm paperclipai auth bootstrap-ceo --base-url {{url}}
Open the printed link, create your account, then add your AI provider key in the settings.
```

## Image tags

`ghcr.io/paperclipai/paperclip:latest` (date-based release tags like `2026.1023.0` exist: pin once tested), `postgres:17-alpine`.

## First login

1. Get an invite link: the install log has one (`Paperclip first-admin invite …`, valid 30 days), or make a new one in the VM with the command in the login info.
2. Open the link, create your account: it becomes the instance admin (board).
3. Add an AI provider key (Anthropic / OpenAI) in the settings.

## Admin checks

- **First admin = `bootstrap-ceo` invite.** Paperclip only generates it by itself with its embedded database; with Postgres (this template) **run once** starts the app, waits for it and runs `pnpm paperclipai auth bootstrap-ceo --base-url {{url}} --expires-hours 720` as the `node` user, then prints the link into the install log. Each new run revokes unaccepted invites; once an admin exists it refuses (use `--force` only to recover access).
- **Never `npx paperclipai`** inside the container: it downloads a second copy of Paperclip into `/paperclip/.npm` (the data volume, as root) and can fill the disk. The CLI is already in the image: `pnpm paperclipai …` as `node` (`gosu node pnpm paperclipai …` from a root shell). On first use Corepack may download pnpm (a few MB).
- Agents only run with the customer's own AI provider key.
- RAM 1 GB covers Paperclip + Postgres with a small agent team. Agents that run coding tools in their workspaces use much more; heavy users belong on Q2/Q3.
- Public sign-up stays possible after the claim. To close it, add `PAPERCLIP_AUTH_DISABLE_SIGN_UP: "true"` to the template (consider making that the default after a test).
- `BETTER_AUTH_SECRET` must not change after users exist (it signs every session).

## Paid products

None: free in every plan.
