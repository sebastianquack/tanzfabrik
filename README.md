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

* run rake commands: `docker-compose run web rake --help`
* check logs: `docker-compose logs`
* Adminer: `http://localhost:8080` (postgres/postgres)
* volatile data such as database files are stored in `.data/`
* add gem: `docker-compose run web bundle install`followed by `docker-compose up --build`