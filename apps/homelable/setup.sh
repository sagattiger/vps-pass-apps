HASH=$($COMPOSE run --rm --no-deps -T --entrypoint python backend -c 'import bcrypt; print(bcrypt.hashpw(b"{{password}}", bcrypt.gensalt()).decode())')
printf "AUTH_PASSWORD_HASH='%s'\n" "$HASH" > auth.env
