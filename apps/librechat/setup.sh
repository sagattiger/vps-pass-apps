if [ ! -f app.env ]; then
  printf 'CREDS_IV=%s\n' "$(head -c 16 /dev/urandom | od -An -tx1 | tr -d ' \n')" > app.env
fi
$COMPOSE create
docker run --rm -v "${P}_images:/v/images" -v "${P}_uploads:/v/uploads" -v "${P}_logs:/v/logs" alpine:3 chown -R 1000:1000 /v/images /v/uploads /v/logs
