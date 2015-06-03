heroku pg:backups capture --app tanzfabrik
curl -o /tmp/latest.dump `heroku pg:backups public-url --app tanzfabrik`
pg_restore --verbose --clean --no-acl --no-owner -h localhost -d tanzfabrik/development /tmp/latest.dump
