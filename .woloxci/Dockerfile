FROM ruby:2.6

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile .
COPY Gemfile.lock .
RUN gem install bundler
RUN bundle install
COPY . .

# Bundler will raise an error if it does not have writable permissions in HOME
ENV HOME /myapp
RUN chmod a+rw /myapp

