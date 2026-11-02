$COMPOSE create
docker run --rm -v "${P}_config:/v/config" -v "${P}_data:/v/data" alpine:3 chown -R 1000:1000 /v/config /v/data
