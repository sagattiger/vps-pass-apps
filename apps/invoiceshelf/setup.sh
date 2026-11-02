printf 'APP_KEY=base64:%s\n' "$(head -c 32 /dev/urandom | base64)" > app.env
