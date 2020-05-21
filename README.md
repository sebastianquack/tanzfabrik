## develop

### setup

#### install prerequisites

* docker: `brew cask install docker`
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

### how to docker

* run rake commands: `docker-compose run web rake --help`
* run everything in background: `docker-compose up -d`
* check logs: `docker-compose logs`
* Adminer: `http://localhost:8080` (postgres/postgres)

