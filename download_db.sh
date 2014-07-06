heroku pgbackups:capture --expire
curl -o /tmp/latest.dump `heroku pgbackups:url`
pg_restore --verbose --clean --no-acl --no-owner -h localhost -d tanzfabrik/development /tmp/latest.dump
