$COMPOSE run --rm --no-deps -T -u 0 --entrypoint sh searxng -c '
if [ ! -f /etc/searxng/settings.yml ]; then
cat > /etc/searxng/settings.yml <<"YML"
use_default_settings: true
server:
  secret_key: "{{secret}}"
  base_url: "{{url}}/"
  limiter: false
  image_proxy: true
search:
  formats:
    - html
    - json
YML
fi
chown -R "$(stat -c %u:%g /etc/searxng)" /etc/searxng
'
