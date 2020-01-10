# Credentials

## Introduction

Prior versions of Rails 6 used the secrets.yml file to store secrets. In order to keep keys not stored in the control version system, it was used `dotenv` to store these sensitive variables in a separate .env file that was not commited to the repository.

## Global Credentials

This scheme was complicated enough and error-prone, so Rails 6 introduced credentials to manage these secrets. This new feature adds two files:

* `config/master.key`: this file has your secret key that will be used to encrypt the file `credentials.yml.enc`. This file **should never be commited or sent to a Docker image** and it is already added to `.gitignore` and `.dockerignore` files of this bootstrap to avoid this.
* `config/credentials.yml.enc`: this YAML file will store the sensitive information. It is safe to store it in the git repository or Docker image, because it is encrypted.

In order to create these files for the first time:

```bash
EDITOR="vi" rails credentials:edit
```

This will open `vi` with the newly created `credentials.yml.enc` file, where you can put all the sensitive variables that you need for your project.

The same command is used to edit the contents of `credentials.yml.enc` provided you still have the `master.key` file or you have the contents of that file in the environment variable `RAILS_MASTER_KEY` in your shell:

```bash
`RAILS_MASTER_KEY=your_key EDITOR="vi" rails credentials:edit
```

When deploying, you have only to set the `RAILS_MASTER_KEY` variable for credentials to be decrypted and used in your app, without needing the `master.key` file to be uploaded. To show the credentials in a terminal:

```bash
RAILS_MASTER_KEY=your_key EDITOR="vi" rails credentials:show
```

## Environment Credentials

The scheme described previously only allows to have a global credentials file, so it can not be distinguished between environments. Rails 6 introduced environment credentials using the `--environment` modifier.

For instance, to create credentials for the development environment:

```bash
EDITOR="vi" rails credentials:edit --environment development
```

This will open a `vi` instance for you to edit this file, and after saving it will create two files:

* `config/credentials/development.key`: it will have the same role as the `master.key` file.
* `config/credentials/development.yml.enc`: it will have the same role as the `credentials.yml.enc` file.

Bear in mind that Rails will only use one encrypted file per environment. This means that if you have a `credentials.yml.enc` and a `development.yml.enc` it will only load `development.yml.enc` and will ignore the former. So the `credentials.yml.enc` file will be loaded only if you do not have any `.yml.enc` file for the current environment you are using.

Likewise global credentials, Rails will search for the key only in `RAILS_MASTER_KEY` variable no matter which environment is being used:

```bash
RAILS_MASTER_KEY=your_key EDITOR="vi" rails credentials:edit --environment development
```

This bootstrap has the `development`, `test` and `production` key files added in both `.gitignore` and `.dockerignore` files. Should you use another environment, you need to make sure that this new key is added to these files in order to prevent its leaking.
