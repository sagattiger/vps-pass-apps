$COMPOSE up -d
ok=""
for i in $(seq 1 40); do
  n=$($COMPOSE exec -T db mariadb -uglpi -p"{{password}}" glpi -N -e "SELECT COUNT(*) FROM glpi_users WHERE name='glpi'" 2>/dev/null || true)
  if [ "$n" = "1" ]; then ok=1; break; fi
  sleep 10
done
if [ -n "$ok" ]; then
  HASH=$($COMPOSE exec -T glpi php -r 'echo password_hash($argv[1], PASSWORD_DEFAULT);' "{{secret2}}")
  $COMPOSE exec -T db mariadb -uglpi -p"{{password}}" glpi -e "UPDATE glpi_users SET password='$HASH' WHERE name='glpi'; UPDATE glpi_users SET is_active=0 WHERE name IN ('tech','normal','post-only');"
  echo "GLPI admin password set, demo accounts disabled"
else
  echo "WARNING: GLPI not installed yet; log in with glpi/glpi and change the passwords of glpi, tech, normal and post-only now"
fi
