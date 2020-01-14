FROM ruby

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
COPY . .

# Bundler will raise an error if it does not have writable permissions in HOME
ENV HOME /myapp
RUN chmod a+rw /myapp
