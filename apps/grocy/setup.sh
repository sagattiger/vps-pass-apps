$COMPOSE up -d grocy
for i in $(seq 1 30); do
  $COMPOSE exec -T grocy test -f /config/data/config.php && break
  sleep 5
done
if $COMPOSE exec -T grocy sed -i "s/Setting('DISABLE_AUTH', false);/Setting('DISABLE_AUTH', true);/" /config/data/config.php; then
  echo "Grocy login turned off; Caddy password page protects it"
else
  echo "WARNING: config.php not found; Grocy login is admin / admin - change it now"
fi
