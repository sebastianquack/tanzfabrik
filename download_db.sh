heroku pgbackups:capture --expire --app tanzfabrik
curl -o /tmp/latest.dump `heroku pgbackups:url --app tanzfabrik`
pg_restore --verbose --clean --no-acl --no-owner -h localhost -d tanzfabrik/development /tmp/latest.dump
