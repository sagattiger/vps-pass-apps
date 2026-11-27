# The admin user is provisioned by ntfy itself at every start (NTFY_AUTH_USERS, "user:bcrypt-hash:role").
# Only the bcrypt hash is made here, once; ntfy creates its auth database when the server starts.
if [ ! -f auth.env ]; then
  HASH=$(docker run --rm caddy:2-alpine caddy hash-password --plaintext "{{password}}")
  case "$HASH" in
    '$2'*) ;;
    *) echo "could not make the password hash"; exit 1 ;;
  esac
  printf "NTFY_AUTH_USERS='admin:%s:admin'\n" "$HASH" > auth.env
fi
