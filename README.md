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

dokku run rake db:create
dokku run rake db:migrate
dokku letsencrypt
```

## staging server
https://relaunch2020.tanzfabrik.intergestalt.cloud/

## convert pages from old site to content modules and seed menu items

1. copy live data to local `bin/download_db.sh`
2. convert and seed `docker-compose run -v $(pwd)/app web rake populate_content_modules`
