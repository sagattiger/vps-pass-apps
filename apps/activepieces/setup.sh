if [ ! -f app.env ]; then
  printf 'AP_ENCRYPTION_KEY=%s\n' "$(head -c 16 /dev/urandom | od -An -tx1 | tr -d ' \n')" > app.env
fi
