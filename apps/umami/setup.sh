$COMPOSE up -d
ok=""
for i in $(seq 1 30); do
  n=$($COMPOSE exec -T db psql -U umami -d umami -tAc "SELECT COUNT(*) FROM \"user\" WHERE username='admin'" 2>/dev/null || true)
  if [ "$n" = "1" ]; then ok=1; break; fi
  sleep 10
done
if [ -n "$ok" ]; then
  $COMPOSE exec -T db psql -U umami -d umami -c "CREATE EXTENSION IF NOT EXISTS pgcrypto; UPDATE \"user\" SET password = crypt('{{password}}', gen_salt('bf', 10)) WHERE username = 'admin';"
  echo "Umami admin password set"
else
  echo "WARNING: admin user not found; the login is still admin / umami - change it now"
fi
