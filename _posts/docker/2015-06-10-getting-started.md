---
title: Getting Started
layout: page
weight: 85
tags:
  - docker
  - jet
  - introduction
  - getting started
  - tutorial
categories:
  - docker
---

Welcome to a simple introductory tutorial for our Codeship _Docker Infrastructure_. This document will help you getting started and configuring a project for both building locally via _Jet_ as well as on Codeship.

The source for the tutorial is available on Github as [codeship/jet-tutorial](https://github.com/codeship/jet-tutorial) and you can clone it via

```bash
git clone git@github.com:codeship/jet-tutorial.git
```

## 1. Installation

Once you followed the [Installation Documentation]({{ site.baseurl }}{% post_url docker/jet/2015-05-25-installation %}) and have Docker and _Jet_ installed on your machine you can follow these steps to configure the project for use with the _Docker Infrastructure_ on Codeship.

## 2. Dockerfile

You need to define a [Dockerfile](http://docs.docker.com/reference/builder/) used for running your tests.

> A Dockerfile is a text document that contains all the commands you would normally execute manually in order to build a Docker image.

The most simple _Dockerfile_ needs to contain only one instruction, the base image to use:

```
FROM ubuntu:14.04
```

As we want to build a more realistic example our _Dockerfile_ contains the following steps.

```
# Start with the offical image for Ruby 2.2.2
FROM ruby:2.2.2

# Update the base system and install any required dependencies
RUN apt-get update -qq

# You could install further dependencies via e.g.
# RUN apt-get install \
#   apt-utils \
#   build-essential

# Create the folders needed by the application and set the
# current working directory with the following commands
RUN mkdir /app
WORKDIR /app

# Copy over the Gemfile and run bundle install.
# This is done as a separate steps so the image can be cached
# this step won't be rerun unless you change the Gemfile or
# Gemfile.lock
COPY Gemfile Gemfile.lock /app/
RUN bundle install --jobs 20 --retry 5

# Copy the complete application onto the container
COPY . /app
```

Let's build our _Dockerfile_ to make sure we didn't miss anything.

```bash
docker build .
```

```text
Sending build context to Docker daemon 8.192 kB
Sending build context to Docker daemon
Step 0 : FROM ruby:2.2.2
 ---> 587d0d048bce
Step 1 : RUN apt-get update -qq
 ---> Using cache
 ---> 4c84c211ba4f
Step 2 : RUN mkdir /app
 ---> Using cache
 ---> 6807abe5a5a3
Step 3 : WORKDIR /app
 ---> Using cache
 ---> 4d97b62db967
Step 4 : COPY Gemfile Gemfile.lock /app/
 ---> 5e7734a705f5
Removing intermediate container e22e69c97556
Step 5 : RUN bundle install --jobs 20 --retry 5
 ---> Running in d924c85e423a
Don't run Bundler as root. Bundler can ask for sudo if it is needed, and
installing your bundle as root will break this application for all non-root
users on this machine.
Fetching gem metadata from https://rubygems.org/..........
Fetching version metadata from https://rubygems.org/..
Using bundler 1.9.9
Installing redis 3.2.1
Installing pg 0.18.2
Bundle complete! 2 Gemfile dependencies, 3 gems now installed.
Bundled gems are installed into /usr/local/bundle.
 ---> baf0b6c7b83f
Removing intermediate container d924c85e423a
Step 6 : COPY . /app
 ---> f332d461322c
Removing intermediate container 515540bf1beb
Successfully built f332d461322c
```

### .dockerignore

Similar to a _.gitignore_ file you can add a _[.dockerignore](https://docs.docker.com/reference/builder/#the-dockerignore-file)_ file to the directory. This file allows you to ignore parts of the project when copying files to the container.

As we are copying the complete directory in the last step, we'll add the following _.dockerignore_ file to the project.

```
.git
Dockerfile
```

## 3. Service Definition

Now that we have a Docker container for our tests we need to define our _codeship-services.yml_ file, which configures which containers are required for running the tests and how they are linked together.

We'll show the complete file first and will then walk you through the individual sections. See [Services]({{ site.baseurl }}{% post_url docker/2015-05-25-services %}) for the full documentation on that file.

```yml
app:
  build:
    image: app
    dockerfile_path: Dockerfile
  environment:
    REDIS_URL: "redis://redis:6379"
    POSTGRES_HOST: postgres
    POSTGRES_DB: postgres
    POSTGRES_USER: postgres
  links:
    - redis
    - postgres
redis:
  image: redis:3.0.2
postgres:
   image: postgres:9.4.3
```

This file configures 3 containers, the first one called _app_ runs our application via the Dockerfile configured in Step #2 of this tutorial.

We also define environment variables for use in the _app_ container, configuring how to access the PostgreSQL database as well as the Redis server.

Furthermore, as our application depends on Redis and PostgreSQL we link the official images for those two services as well. In most cases there are Docker containers for services like databases or queues readily available. You can search the available images on the [Docker Hub](https://registry.hub.docker.com/).

(We should also add the _codeship-services.yml_ file to our _.dockerignore_ file mentioned above.)

## 4. Step Definition

Lastly we need to define the steps that will be run during our builds. This is done in the _codeship-steps.yml_ file. See [Steps]({{ site.baseurl }}{% post_url docker/2015-05-25-steps %}) for more information on how to define and run various commands.

```yml
- service: app
  command: bundle exec ruby check.rb
```

This is a very basic step definition, we run a single command on the _app_ container defined in step #3. The `check.rb` file includes the following code.

```ruby
require "redis"
require "pg"

def log(message)
  puts "\e[34m#{message}\e[0m"
end

log "Checking Redis server..."
redis = Redis.new()
log "REDIS VERSION: #{redis.info["redis_version"]}"

sleep 2

log "Checking PostgreSQL server..."
pg = PG.connect({
  host: ENV['POSTGRES_HOST'],
  dbname: ENV['POSTGRES_DB'],
  user: ENV['POSTGRES_USER']
  })
log pg.exec("SELECT version();").first["version"]
```

## 5. Run it :)

Once we have all steps configured we can use _Jet_ to test the configuration locally. You will see output like the following, which indicates that _Jet_ first builds the _Dockerfile_ and then runs the `bundle exec ruby check.rb` step defined.

You also see the output of the two linked containers (_redis_  and _postgres_) plus the 4 lines we print during the ruby script.

```bash
jet steps
```

```text
{StepStarted=step_name:"bundle_exec_ruby_check.rb"}
{BuildImageStarted=image_name:"app"}
{BuildImageStdout=image_name:"app"}: Step 0 : FROM ruby:2.2.2
{BuildImageStdout=image_name:"app"}:  ---> 587d0d048bce
{BuildImageStdout=image_name:"app"}: Step 1 : RUN apt-get update -qq
{BuildImageStdout=image_name:"app"}:  ---> Using cache
{BuildImageStdout=image_name:"app"}:  ---> 4c84c211ba4f
{BuildImageStdout=image_name:"app"}: Step 2 : RUN mkdir /app
{BuildImageStdout=image_name:"app"}:  ---> Using cache
{BuildImageStdout=image_name:"app"}:  ---> 6807abe5a5a3
{BuildImageStdout=image_name:"app"}: Step 3 : WORKDIR /app
{BuildImageStdout=image_name:"app"}:  ---> Using cache
{BuildImageStdout=image_name:"app"}:  ---> 4d97b62db967
{BuildImageStdout=image_name:"app"}: Step 4 : COPY Gemfile Gemfile.lock /app/
{BuildImageStdout=image_name:"app"}:  ---> Using cache
{BuildImageStdout=image_name:"app"}:  ---> d9131e1af886
{BuildImageStdout=image_name:"app"}: Step 5 : RUN bundle install --jobs 20 --retry 5
{BuildImageStdout=image_name:"app"}:  ---> Using cache
{BuildImageStdout=image_name:"app"}:  ---> 8a2729a777ff
{BuildImageStdout=image_name:"app"}: Step 6 : COPY . /app
{BuildImageStdout=image_name:"app"}:  ---> 58ee52cd65ed
{BuildImageStdout=image_name:"app"}: Removing intermediate container defd839dacb1
{BuildImageStdout=image_name:"app"}: Successfully built 58ee52cd65ed
{BuildImageFinished=image_name:"app"}
{ContainerRunStdout=step_name:"bundle_exec_ruby_check.rb" service_name:"redis"}: 1:C 10 Jun 17:26:16.115 # Warning: no config
... [skipping redis & postgres output] ...
{ContainerRunStdout=step_name:"bundle_exec_ruby_check.rb" service_name:"redis"}: 1:M 10 Jun 17:26:16.116 * The server is now ready to accept connections on port 6379
{ContainerRunStdout=step_name:"bundle_exec_ruby_check.rb" service_name:"app"}: Checking Redis server...
{ContainerRunStdout=step_name:"bundle_exec_ruby_check.rb" service_name:"app"}: REDIS VERSION: 3.0.2
{ContainerRunStdout=step_name:"bundle_exec_ruby_check.rb" service_name:"app"}: Checking PostgreSQL server...
{ContainerRunStdout=step_name:"bundle_exec_ruby_check.rb" service_name:"app"}: PostgreSQL 9.4.3 on x86_64-unknown-linux-gnu, compiled by gcc (Debian 4.7.2-5) 4.7.2, 64-bit
{StepFinished=step_name:"bundle_exec_ruby_check.rb" type:STEP_FINISHED_TYPE_SUCCESS}
```

## 6. Push it!

You can now push the repository to your GitHub or BitBucket remote and Codeship will use the information in those files to run your builds!

Or (if you haven't done so already) you can [configure the project on Codeship]({{ site.baseurl }}{% post_url docker/2015-06-11-codeship-configuration %}).
