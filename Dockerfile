FROM ruby:2.6
RUN apt-get update
RUN apt-get install --assume-yes --no-install-recommends \
    build-essential \
    ca-certificates \
    nodejs \
    graphviz

ENV APP /usr/src/app
RUN mkdir -p $APP

WORKDIR $APP

COPY Gemfile* $APP
RUN gem install bundler -v '~> 2.0.0'
RUN bundle install --jobs=$(nproc)

COPY . $APP/

CMD bin/rails s -p 3000 -b 0.0.0.0