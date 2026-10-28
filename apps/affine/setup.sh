$COMPOSE up -d postgres redis
for i in $(seq 1 30); do
  $COMPOSE exec -T postgres pg_isready -U affine -d affine >/dev/null 2>&1 && break
  sleep 2
done
$COMPOSE run --rm --no-deps -T migration node ./scripts/self-host-predeploy.js
