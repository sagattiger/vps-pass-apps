$COMPOSE create
docker run --rm -v "${P}_files:/f" -v "${P}_db:/d" alpine:3 chown -R 1000:1000 /f /d
