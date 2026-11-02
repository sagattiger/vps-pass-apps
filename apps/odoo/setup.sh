$COMPOSE up -d db
FLAG=""
if $COMPOSE run --rm -T odoo odoo --help 2>/dev/null | grep -q -- '--without-demo'; then FLAG="--without-demo=all"; fi
$COMPOSE run --rm -T odoo odoo -i base -d odoo --stop-after-init $FLAG
echo "env.ref('base.user_admin').password = '{{secret2}}'; env.cr.commit()" | $COMPOSE run --rm -T odoo odoo shell -d odoo --no-http
echo "Odoo database created, admin password set"
