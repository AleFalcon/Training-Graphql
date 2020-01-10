FROM ruby

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
COPY . .
