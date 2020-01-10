RailsGraphqlBootstrap
===============

Kickoff for Rails web applications.

## Running local server

### Git pre push hook

You can modify the [pre-push](script/pre-push) script to run different scripts before you `git push` (e.g Rspec, Linters). Then you need to run the following:

```bash
chmod +x script/pre-push
ln -s ../../script/pre-push .git/hooks/pre-push
```

You can skip the hook by adding `--no-verify` to your `git push`.

### 1- Installing Ruby

- Clone the repository by running `git clone git@github.com:Wolox/rails-graphql-bootstrap.git`
- Go to the project root by running `cd rails-graphql-bootstrap`
- Download and install Rbenv and Ruby-Build as instructed by [GoRails guide](https://gorails.com/setup).
- Install the appropriate Ruby version by running `rbenv install`.

### 2- Installing Rails gems

- Install [Bundler](http://bundler.io/).

```bash
gem install bundler
rbenv rehash
```
- Install basic dependencies if you are using Ubuntu:

```bash
sudo apt-get install build-essential libpq-dev
```

- Install all the gems included in the project.

```bash
bundle install
```

### [Kickoff] Application Setup

Run `./script/bootstrap app-name` where `app-name` is your application name.

Your app is ready. Happy coding!

### Database Setup

Run in terminal:

```bash
sudo -u postgres psql
CREATE ROLE "rails-graphql-bootstrap" LOGIN CREATEDB PASSWORD 'rails-graphql-bootstrap';
```

Log out from postgres and run:

```bash
bundle exec rake db:create db:migrate
```

Your server is ready to run. You can do this by executing `rails server` and going to [http://localhost:3000](http://localhost:3000). Happy coding!

## Running with Docker

Read more [here](docs/docker.md)

## Deploy Guide

#### Heroku

If you want to deploy your app using [Heroku](https://www.heroku.com) you need to do the following:

- Add the Heroku Git URL to your remotes

```bash
git remote add heroku-prod your-git-url
```

- Push to Heroku

```bash
git push heroku-prod your-branch:master
```

Read more [here](https://devcenter.heroku.com/articles/getting-started-with-rails6)

## Rollbar Configuration

`Rollbar` is used for exception errors report. To complete this configuration setup the following environment variables in your server
- `ROLLBAR_ACCESS_TOKEN`

with the credentials located in the rollbar application.

If you have several servers with the same environment name you may want to difference them in Rollbar. For this set the `ROLLBAR_ENVIRONMENT` environment variable with your environment name.

## Brakeman

To run the static analyzer for security vulnerabilities run:

```bash
bundle exec brakeman
```

## Dotenv

We use [dotenv](https://github.com/bkeepers/dotenv) to set up our environment variables in combination with `secrets.yml`.

For example, you could have the following `secrets.yml`:

```yml
production: &production
  foo: <%= ENV['FOO'] %>
  bar: <%= ENV['BAR'] %>
```

and a `.env` file in the project root that looks like this:

```
FOO=1
BAR=2
```

When you load up your application, `Rails.application.secrets.foo` will equal `ENV['FOO']`, making your environment variables reachable across your Rails app.
The `.env` will be ignored by `git` so it won't be pushed into the repository, thus keeping your tokens and passwords safe.

# Documentation

You can find more documentation in the [docs](docs) folder. The documentation available is:

- [Run locally with Docker](docs/docker.md)
- [Locales structure](docs/locales.md)
- [Seeds](docs/seeds.md)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run rspec tests (`bundle exec rspec spec -fd`)
5. Run rubocop lint (`bundle exec rubocop app spec`)
6. Push your branch (`git push origin my-new-feature`)
7. Create a new Pull Request

## About

This project is maintained by [Wolox](https://github.com/wolox) and it is written by [Wolox](http://www.wolox.com.ar).

![Wolox](https://raw.githubusercontent.com/Wolox/press-kit/master/logos/logo_banner.png)

## License

**rails-graphql-bootstrap** is available under the MIT [license](LICENSE).

    Copyright (c) 2019 X <X@wolox.com.ar>

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
