---
title: Using PostgreSQL In CI/CD with Codeship Basic
shortTitle: PostgreSQL
tags:
  - services
  - databases
  - postgresql
  - postgres
  - psql
  - pg
  - db
menus:
  basic/db:
    title: PostgreSQL
    weight: 2
redirect_from:
  - /databases/postgresql/
  - /classic/getting-started/postgresql/
categories:
  - Databases  
---

* include a table of contents
{:toc}

<div class="info-block">
PostgreSQL 9.2 officially reached its [end-of-life (EOL)](https://www.postgresql.org/support/versioning) and as a result it was removed from the build environment as of **March 29, 2018**.

PostgreSQL 10 is now the new default running on port 5432.
</div>

PostgreSQL `10` runs on the default port and the credentials are stored in the `PGUSER` and `PGPASSWORD` environment variables. The default databases created for you are **development** and **test**.

We install the Ubuntu `postgresql-contrib` package. It includes the [extension modules](https://www.postgresql.org/docs/10/static/contrib.html) listed in the PostgreSQL documentation.

You need to activate them with `CREATE EXTENSION` as explained in the [Extension Guide](https://www.postgresql.org/docs/10/static/sql-createextension.html).

## Versions

### 10

The **default version** of PostgreSQL on Codeship is **10**, which runs on the default port of `5432`. No additional configuration is required to use version 10.

<div class="info-block">
PostgreSQL 10 includes PostGIS version 2.4.
</div>

### 9.6

PostgreSQL version **9.6** is running on port `5436` and configured (almost) identical to the others. Make sure to specify the correct port in your project configuration if you want to test against this version.

<div class="info-block">
PostgreSQL 9.6 includes PostGIS version 2.3.
</div>

For Rails based projects, please add the following command to your _Setup Commands_ to work around the auto-configuration in place.

```shell
sed -i "s|5432|5436|" "config/database.yml"
```

### 9.5

PostgreSQL version **9.5** is running on port `5435` and configured (almost) identical to the others. Make sure to specify the correct port in your project configuration if you want to test against this version.

<div class="info-block">
PostgreSQL 9.5 includes PostGIS version 2.2.
</div>

For Rails based projects, please add the following command to your _Setup Commands_ to work around the auto-configuration in place.

```shell
sed -i "s|5432|5435|" "config/database.yml"
```

### 9.4

PostgreSQL version **9.4** is running on port `5434` and configured (almost) identical to the others. Make sure to specify the correct port in your project configuration if you want to test against this version.

<div class="info-block">
PostgreSQL 9.4 includes PostGIS version 2.1.
</div>

For Rails based projects, please add the following command to your _Setup Commands_ to work around the auto-configuration in place.

```shell
sed -i "s|5432|5434|" "config/database.yml"
```

### 9.3

PostgreSQL version **9.3** is running on port `5433` and configured (almost) identical to the others. Make sure to specify the correct port in your project configuration if you want to test against this version.

<div class="info-block">
PostgreSQL 9.3 includes PostGIS version 2.1.
</div>

For Rails based projects, please add the following command to your _Setup Commands_ to work around the auto-configuration in place.

```shell
sed -i "s|5432|5433|" "config/database.yml"
```

### pg_dump
You may experience a `pg_dump` version mismatch with the PostgreSQL version you have configured.

```
pg_dump: server version: $YOUR_VERSION; pg_dump version: 9.2.19
pg_dump: aborting because of server version mismatch
```

This can be resolved by adding the following command in your _Setup Commands_ before running your migrations:

```shell
export PATH=/usr/lib/postgresql/<PG_VERSION>/bin/:$PATH
```

## Run psql commands
You can run any SQL query against the PostgreSQL database. For example to create a new database:

```shell
psql -p DATABASE_PORT -c 'create database new_db;'
```

## Enable Extensions
You can enable extensions either through your application framework (if supported) or by running commands directly against the database. For example, you would add the following command to your _Setup Commands_ to enable the `hstore` extension.

```shell
psql -d DATABASE_NAME -p DATABASE_PORT -c 'create extension if not exists hstore;'
```

### PostGIS
PostgreSQL versions 9.3 to 9.4 include PostGIS 2.1, 9.5 includes 2.2, 9.6 includes 2.3 and 10 includes 2.4.

## Framework-specific configuration

### Ruby on Rails
We replace the values in your `config/database.yml` file automatically to a configuration matching the PostgreSQL 10 instance.

If your Rails application is stored in a subdirectory or you want to change the database configuration from our default values, you can add the following data to a `codeship.database.yml` file (or any other filename) and commit that file to your repository.

```yaml
development:
  adapter: postgresql
  host: localhost
  encoding: unicode
  pool: 10
  username: <%= ENV['PGUSER'] %>
  template: template1
  password: <%= ENV['PGPASSWORD'] %>
  database: development<%= ENV['TEST_ENV_NUMBER'] %>
  port: 5432
  sslmode: disable
test:
  adapter: postgresql
  host: localhost
  encoding: unicode
  pool: 10
  username: <%= ENV['PG_USER'] %>
  template: template1
  password: <%= ENV['PG_PASSWORD'] %>
  database: test<%= ENV['TEST_ENV_NUMBER'] %>
  port: 5432
  sslmode: disable
```

In your _Setup Commands_, run the following command to copy the file to its target location.

```shell
cp codeship.database.yml YOUR_DATABASE_YAML_PATH
```

If you don't use Rails and load the database.yml file yourself, you might see `PSQL::Error message stating the raw username <%= ENV['PG_USER'] %>` instead of the value of the environment variable. This is because the database.yml example includes ERB syntax. You need to load database.yml, and run it through ERB before you can use it first.

```ruby
# Sample error message
# PSQL::Error: Access denied for user '<%= ENV['PGUSER'] %>'@'localhost'
#
# Run the file through ERB before loading the YAML data
DATABASE_CONFIG = YAML.load(ERB.new(File.read("config/database.yml")))
```

### Django
You can use the following database configuration for Django based projects.

```python
DATABASES = {
  'default': {
    'ENGINE': 'django.db.backends.postgresql_psycopg2',
    'NAME': 'test',
    'USER': os.environ.get('PGUSER'),
    'PASSWORD': os.environ.get('PGPASSWORD'),
    'HOST': '127.0.0.1',
  }
}
```

## Notes And Known Issues

### Python and earlier Psycopg versions
Earlier versions of [Python PostgreSQL client Psycopg](http://initd.org/psycopg) may not work with version 10. These older versions used a string-comparison to try and work out the PostgreSQL version number and didn't account for version 10. To resolve this issue, upgrade `psycopg2` to version 2.7 or higher.
