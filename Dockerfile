FROM ruby:2.7.8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

#yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn=1.22.15-1 \
    && apt-get install -y imagemagick

RUN curl -fsSL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs


RUN mkdir /app
WORKDIR /app

# install bundle
COPY Gemfile* /app/
# RUN bundle update --bundler
RUN bundle install

# ENV BUNDLE_PATH /gemcache

# install node packages
#COPY package.json /app/
#COPY yarn.lock /app/
#RUN yarn

RUN apt-get install python -y

EXPOSE 3000
CMD ["rails", "server", "--binding=0.0.0.0"]