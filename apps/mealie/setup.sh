$COMPOSE up -d
ok=""
for i in $(seq 1 30); do
  if $COMPOSE exec -T mealie python3 -c "
import sqlite3, sys
c = sqlite3.connect('/app/data/mealie.db')
n = c.execute(\"select count(*) from users where email = 'changeme@example.com'\").fetchone()[0]
sys.exit(0 if n == 1 else 1)
" >/dev/null 2>&1; then ok=1; break; fi
  sleep 10
done
if [ -n "$ok" ] && $COMPOSE exec -T mealie python3 -c "
import sqlite3, bcrypt
h = bcrypt.hashpw(b'{{password}}', bcrypt.gensalt()).decode()
c = sqlite3.connect('/app/data/mealie.db')
c.execute(\"update users set email = ?, password = ? where email = 'changeme@example.com'\", ('{{email}}', h))
c.commit()
"; then
  echo "Mealie default login replaced"
else
  echo "WARNING: default login changeme@example.com / MyPassword is still active - change it now"
fi
