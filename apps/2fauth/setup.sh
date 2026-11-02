if [ ! -f app.env ]; then
  printf 'APP_KEY=%s\n' "$(head -c 16 /dev/urandom | od -An -tx1 | tr -d ' \n')" > app.env
fi
