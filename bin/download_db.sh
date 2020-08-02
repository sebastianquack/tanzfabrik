#/bin/bash

# go to to repo root
cd $(git rev-parse --show-toplevel)

# capture backup
heroku pg:backups capture --app tanzfabrik2020

# download db dump
mkdir -p .data/downloads
curl -o .data/downloads/latest.dump `heroku pg:backups public-url --app tanzfabrik2020`

# run restore
echo "password: postgres"
docker-compose run db pg_restore --verbose --clean --no-acl --no-owner -U postgres -h db -d tanzfabrik/development /downloads/latest.dump
