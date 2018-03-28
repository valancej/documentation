---
title: Using MySQL In CI/CD with Codeship Basic
shortTitle: MySQL
tags:
  - services
  - databases
  - mysql
  - db
menus:
  basic/db:
    title: MySQL
    weight: 1
redirect_from:
  - /databases/mysql/
  - /classic/getting-started/mysql/
categories:
  - Databases  
---

* include a table of contents
{:toc}

MySQL **5.6** runs on the default port and the credentials are stored in the `MYSQL_USER` and `MYSQL_PASSWORD` environment variables.

A **development** and **test** database are setup by default for you in addition to the system databases.

## Ruby on Rails

We replace the values in your `config/database.yml` automatically.

If you have your Rails application in a subdirectory or want to change
it from our default values you can add the following to a codeship.database.yml
(or any other filename) in your repository:

```yaml
development:
  adapter: mysql2
  host: localhost
  encoding: utf8
  pool: 10
  username: <%= ENV['MYSQL_USER'] %>
  password: <%= ENV['MYSQL_PASSWORD'] %>
  database: development<%= ENV['TEST_ENV_NUMBER'] %>
  socket: /var/run/mysqld/mysqld.sock
test:
  adapter: mysql2
  host: localhost
  encoding: utf8
  pool: 10
  username: <%= ENV['MYSQL_USER'] %>
  password: <%= ENV['MYSQL_PASSWORD'] %>
  database: test<%= ENV['TEST_ENV_NUMBER'] %>
  socket: /var/run/mysqld/mysqld.sock
```

Then in your setup commands run

```shell
cp codeship.database.yml YOUR_DATABASE_YAML_PATH
```

to copy the file wherever you need it.

If you don't use Rails and load `database.yml` yourself you might see an error like the following instead of the value of the environment variable:

```
MYSQL2::Error: Access denied for user '<%= ENV['MYSQL_USER'] %>'@'localhost'
```

This is because the `database.yml` example includes ERB syntax. You need to load `database.yml` and run it through ERB before you can use it:

```ruby
require "erb"
require "yaml"

DATABASE_CONFIG = YAML.load(ERB.new(File.read("config/database.yml")).result)
```

## Django

```python
DATABASES = {
  'default': {
    'ENGINE': 'django.db.backends.mysql',
    'NAME': 'test',
    'USER': os.environ.get('MYSQL_USER'),
    'PASSWORD': os.environ.get('MYSQL_PASSWORD'),
    'HOST': '127.0.0.1',
  }
}
```
