$COMPOSE run --rm --no-deps -T --entrypoint sh homeassistant -c '
[ -f /config/configuration.yaml ] && exit 0
cat > /config/configuration.yaml <<EOF
default_config:

http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 10.0.0.0/8
    - 172.16.0.0/12
    - 192.168.0.0/16

automation: !include automations.yaml
script: !include scripts.yaml
scene: !include scenes.yaml
EOF
echo "[]" > /config/automations.yaml
: > /config/scripts.yaml
echo "[]" > /config/scenes.yaml
'
