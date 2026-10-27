$COMPOSE up -d postgres redis
sleep 15
$COMPOSE run --rm rails bundle exec rails db:chatwoot_prepare
