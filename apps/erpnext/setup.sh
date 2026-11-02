$COMPOSE up -d db redis-cache redis-queue
for i in $(seq 1 30); do
  $COMPOSE exec -T db mariadb-admin ping -uroot -p"{{password}}" >/dev/null 2>&1 && break
  sleep 3
done
$COMPOSE run --rm --no-deps -T backend bash -c 'ls -1 apps > sites/apps.txt; bench set-config -g db_host db; bench set-config -gp db_port 3306; bench set-config -g redis_cache redis://redis-cache:6379; bench set-config -g redis_queue redis://redis-queue:6379; bench set-config -g redis_socketio redis://redis-queue:6379; bench set-config -gp socketio_port 9000'
if ! $COMPOSE run --rm --no-deps -T backend test -d sites/frontend; then
  $COMPOSE run --rm --no-deps -T backend bench new-site --mariadb-user-host-login-scope='%' --admin-password='{{secret2}}' --db-root-username=root --db-root-password='{{password}}' --install-app erpnext --set-default frontend
fi
$COMPOSE run --rm --no-deps -T backend bench --site frontend set-config host_name '{{url}}'
echo "ERPNext site created"
