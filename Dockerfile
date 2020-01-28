FROM ruby:2.6

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile .
COPY Gemfile.lock .
RUN gem install bundler
RUN bundle install
COPY . .
