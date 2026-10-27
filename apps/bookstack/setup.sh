printf 'APP_KEY=base64:%s\n' "$(head -c 32 /dev/urandom | base64)" > bookstack.env
$COMPOSE up -d
DONE=0
for i in $(seq 1 24); do
  if $COMPOSE exec -T bookstack php /app/www/artisan bookstack:create-admin --initial --email="{{email}}" --name="Admin" --password="{{password}}"; then
    DONE=1
    break
  fi
  sleep 10
done
[ "$DONE" = 1 ] || echo "WARNING: admin not set; default login is admin@admin.com / password - change it now"
