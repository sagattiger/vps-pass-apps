$COMPOSE create
docker run --rm -v "${P}_config:/c" alpine:3 sh -c 'if [ ! -f /c/config.yaml ]; then cat > /c/config.yaml <<"YML"
storage:
  type: sqlite
  path: /data/data.db

ui:
  title: Status

endpoints:
  - name: This status page
    group: Example
    url: "{{url}}/health"
    interval: 5m
    conditions:
      - "[STATUS] == 200"
YML
fi'
