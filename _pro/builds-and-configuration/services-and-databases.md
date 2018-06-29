---
title: Supported Services and Databases
shortTitle: Services and Databases
menus:
  pro/builds:
    title: Services And Databases
    weight: 12
tags:
  - docker
  - jet
  - configuration
  - services
  - databases
  - db

categories:
  - Builds and Configuration
  - Databases
  - Docker
  - Configuration

redirect_from:
  - /docker/services-and-databases/
  - /pro/getting-started/services-and-databases/
---

* include a table of contents
{:toc}

Through Docker we support many different databases and services you can use for your build. By adding them to your `codeship-services.yml` file you have a lot of control on how to set up your build environment.

Before reading through the documentation please take a look at the [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) and [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) documentation page so you have a good understanding how services and steps on Codeship work. At first we want to show you how to customize a service or database container so it has the exact configuration you need for your build.

## Customizing a service container

The following example will start a Ruby and Elasticsearch container and make Elasticsearch available to the Ruby container. The Elasticsearch container will get a customized configuration file that is added by building it with a `Dockerfile.elasticsearch` Dockerfile.

At first the configuration file we want to use in our Elasticsearch container. It makes sure that the Elasticsearch container does not build a cluster with other containers. Store this in for example `config/elasticsearch.yml` in your repository.

```yaml
node:
  local: true
  name: ci
```

Now we create a Dockerfile that starts from an Elasticsearch base container and adds our configuration file.

```dockerfile
FROM healthcheck/elasticsearch:alpine

ADD config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
RUN chown elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.yml
```

**Note** that in this example we are using the [healthcheck]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}#healthcheck) version of the Elasticsearch image to avoid startup timing issues.

The following `codeship-services.yml` uses the `Dockerfile.elasticsearch` we just created to build our container. Using `depends_on`, we can make it clear that the Elasticsearch container is a dependency of the Ruby container.

```yaml
ruby:
  image: ruby:2.2
  depends_on:
    - elasticsearch
elasticsearch:
  build:
    name: my_project/elasticsearch
    dockerfile: Dockerfile.elasticsearch
```

Now we have a fully customized instance of Elasticsearch running. This same process applies to any other service or database you might be using. To see how to customize them take a look at the specific Dockerfiles that are used to create the service you want to use.

## Waiting for a service to start

When starting your tests you want to make sure that your service is up and running.

### HEALTHCHECK

The most common and most supported way to make sure that a service is available is to use the `HEALTHCHECK` directive inside your Dockerfile, or to use the `healthcheck` version of a [base image from Docker Hub](https://hub.docker.com/u/healthcheck/) or another source. Learn more about using health checks in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}#healthcheck).

### Service Poll

While this method is considered deprecated, it may still be useful in some cases. The following script will check for Postgres and Redis to be ready and accept connections. You can use this script to add any further checks for other services. You can connect checks with `&&`. The list of supported containers below has tools that help you to test your service for availability. Make sure to set all necessary environment variables used in the commands.

```shell
#!/usr/bin/env bash

function test_postgresql {
  pg_isready -h "${POSTGRESQL_HOST}" -U "${POSTGRESQL_USER}"
}

function test_redis {
  redis-cli -h "${REDIS_HOST}" PING
}

count=0
# Chain tests together by using &&
until ( test_postgresql && test_redis )
do
  ((count++))
  if [ ${count} -gt 50 ]
  then
    echo "Services didn't become ready in time"
    exit 1
  fi
  sleep 0.1
done
```
