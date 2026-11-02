$COMPOSE up -d
ok=""
for i in $(seq 1 30); do
  if $COMPOSE exec -T healthchecks /opt/healthchecks/manage.py shell -c "
from django.contrib.auth.models import User
from hc.accounts.views import _make_user
u = User.objects.filter(email='{{email}}').first() or _make_user('{{email}}')
u.set_password('{{password}}')
u.is_staff = True
u.is_superuser = True
u.save()
" >/dev/null 2>&1; then ok=1; break; fi
  sleep 10
done
if [ -n "$ok" ]; then echo "Healthchecks admin created"; else echo "WARNING: admin not created; run manage.py createsuperuser in the healthchecks container"; fi
