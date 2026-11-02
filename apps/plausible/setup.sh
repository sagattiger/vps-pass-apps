if [ ! -f app.env ]; then
  printf 'TOTP_VAULT_KEY=%s\n' "$(head -c 32 /dev/urandom | base64 | tr -d '\n')" > app.env
fi
