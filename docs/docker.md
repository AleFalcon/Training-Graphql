# Docker

If you don't want to install everything in your computer you can opt to run your application using [Docker](https://www.docker.com/why-docker)

Install [Docker Compose](https://docs.docker.com/compose/install/) and then run:

```bash
git clone https://github.com/Wolox/rails-graphql-bootstrap.git
docker-compose up
```

When the server starts, run the following command in a different console to setup the database:

```bash
docker-compose run web rails db:create db:migrate db:seed
```

To stop the server run the following command in a different console:

```bash
docker-compose stop
```

To see the running process, run the following command in a different console:

```bash
docker-compose ps
```

To update Docker images, run the following command:

```bash
docker-compose build
```
