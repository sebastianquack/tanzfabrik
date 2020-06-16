FROM ruby:2.4.10
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /app
WORKDIR /app
COPY Gemfile* /app/
RUN bundle install
EXPOSE 3000
CMD ["rails", "server", "--binding=0.0.0.0"]