$COMPOSE up -d
for i in $(seq 1 30); do
  $COMPOSE exec -T mautic_web test -f /var/www/html/bin/console >/dev/null 2>&1 && break
  sleep 5
done
if $COMPOSE exec -T -u www-data mautic_web php /var/www/html/bin/console mautic:install "{{url}}" --db_host=db --db_port=3306 --db_name=mautic --db_user=mautic --db_password="{{password}}" --admin_firstname=Admin --admin_lastname=User --admin_username=admin --admin_email="{{email}}" --admin_password="{{secret2}}!"; then
  echo "Mautic installed"
else
  echo "WARNING: command-line install failed; open the address right away and finish the web installer"
fi
