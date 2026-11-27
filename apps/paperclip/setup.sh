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
