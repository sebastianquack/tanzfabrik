## develop

### setup

#### install prerequisites

* docker: `brew cask install docker` (you need to start the docker gui app once for it to install docker-compose)
* heroku-cli `brew tap heroku/brew && brew install heroku`
* put `.env` file containing the secrets in repo root folder

#### prepare containers and init db
````
docker-compose build
docker-compose up -d db
docker-compose run web rake db:create
bin/download_db.sh
docker-compose up
open http://localhost:3000
````

### dev workflow after setup

````
docker-compose up -d
docker-compose run web rake db:migrate # if necessary

# ...develop...

docker-compose down
````

### how to docker

* run rake commands: `docker-compose run -v $(pwd)/app web rake --help`
* check logs: `docker-compose logs`
* Adminer: `http://localhost:8080` (postgres/postgres)
* volatile data such as database files are stored in `.data/`
* add gem: `docker-compose run -v $(pwd)/app web bundle install`followed by `docker-compose up --build`


## dokku deploy

1. install dokku on server (ubuntu 18)
2. on server: 
```
sudo dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
dokku config:set --global DOKKU_LETSENCRYPT_EMAIL=<EMAIL>
sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres
```
3. install dokku on client (mac): `brew install dokku/repo/dokku`
4. on client in repo root: 
```
dokku apps:create relaunch2020
dokku postgres:create relaunch2020_postgres
dokku postgres:link relaunch2020_postgres relaunch2020

git remote add dokku <YOUR_SERVER>

dokku config:set BUILDPACK_URL=https://github.com/heroku/heroku-buildpack-ruby PORT=5000

git push dokku relaunch2020:master

# dokku postgres:import relaunch2020_postgres < .data/downloads/latest.dump
# or 
# dokku run rake db:create
# dokku run rake db:migrate
dokku letsencrypt

dokku apps:create minio
dokku config:set --no-restart minio MINIO_ACCESS_KEY=$(echo `openssl rand -base64 45` | tr -d \=+ | cut -c 1-20)
dokku config:set --no-restart minio MINIO_SECRET_KEY=$(echo `openssl rand -base64 45` | tr -d \=+ | cut -c 1-32)
dokku config:set --no-restart minio NGINX_MAX_REQUEST_BODY=100M
dokku config:set --no-restart minio MINIO_DOMAIN=minio.tanzfabrik.intergestalt.cloud
dokku config minio # get keys

mkdir -p /var/lib/dokku/data/storage/minio
chown 32769:32769 /var/lib/dokku/data/storage/minio
dokku storage:mount minio /var/lib/dokku/data/storage/minio:/home/dokku/data

dokku proxy:ports-add minio http:80:9000
dokku proxy:ports-remove minio http:80:5000
dokku proxy:ports-remove minio http:9000:9000

dokku letsencrypt minio

dokku config:set --no-restart relaunch2020 S3_TANZFABRIK_BUCKET=tanzfabrik-relaunch2020
dokku config:set --no-restart relaunch2020 S3_MINIO_HOSTNAME=

```

## staging server
https://relaunch2020.tanzfabrik.intergestalt.cloud/

## convert pages from old site to content modules and seed menu items

1. copy live data to local `bin/download_db.sh`
2. convert and seed `docker-compose run --rm -v $(pwd)/app web rake populate_content_modules`

## seed text items

`docker-compose run --rm -v $(pwd)/app web rake seed_text_items`

## create example page

`docker-compose run --rm -v $(pwd)/app web rake create_example_page`
--> URL /de/module

## mirror production bucket to local minio bucket

`bin/copy_files_live2local.sh`
