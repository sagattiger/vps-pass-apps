$COMPOSE up -d db
for i in $(seq 1 30); do
  $COMPOSE exec -T db pg_isready -U listmonk -d listmonk >/dev/null 2>&1 && break
  sleep 2
done
$COMPOSE run --rm --no-deps -T listmonk ./listmonk --install --idempotent --yes --config ''
$COMPOSE exec -T db psql -U listmonk -d listmonk -c "UPDATE settings SET value = '\"{{url}}\"' WHERE key = 'app.root_url';"
