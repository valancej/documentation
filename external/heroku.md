[Codeship](http://addons.heroku.com/codeship) is an easy to use hosted [continuous integration and delivery](http://en.wikipedia.org/wiki/Continuous_delivery) service.

Whenever you push your application to GitHub we run all your tests on the new version and automatically deploy your application to Heroku on success. Easily test and deploy your applications without setting up your own test server. Getting started takes less than two minutes and is fully integrated with Heroku. **Try it for free!**

## Installing the add-on

The free Codeship add-on can be installed to a Heroku application via the CLI by running the following command:

```shell
$ heroku addons:add codeship:free
-----> Adding codeship to sharp-mountain-4005... done, v18 (free)
```

<div class="callout">
A list of all plans available can be found
<a href="http://addons.heroku.com/codeship">here</a>.
</div>

To jump aboard the ship open your Codeship account by running

```shell
$ heroku addons:open codeship
```

You will be taken to the setup wizard if you haven't already configured a project. You can always access your Codeship dashboard using the above command. Alternatively you can sign in through GitHub / BitBucket or with your email and password.

## Configuration

When you start setting up a project you have to select your source code repository first. At the moment we support GitHub and BitBucket based repositories. Choose your provider and select the project's repository.

![SCM Selection](https://s3.amazonaws.com/docs.codeship.io/documentation/images/external/heroku/connect_scm.png)

Now let's edit your setup and test commands. Setup commands usually include installing your dependencies or setting up your database. Test commands are shell commands needed to run your tests. For example `bundle exec rake` for ruby, `npm test` for Node.js or `mvn test` for JVM based languages. You can run as many test commands as you like.

If a command's return code isn't zero the build will fail.

![Test Settings](https://s3.amazonaws.com/docs.codeship.io/documentation/images/external/heroku/configure_tests.png)

You can **configure deployments** for branches in the next step. The wizard will let you add a branch to make the setup quick and easy.

![Select Deployment Branch](https://s3.amazonaws.com/docs.codeship.io/documentation/images/external/heroku/configure_deployment_branch.png)

You can always go to back to the configuration later on and manage deployment commands for other branches as well.

For example you might want to have a _production_ branch in your repository that gets deployed to your production app, plus a _master_ branch that is deployed to your staging application.

You can also configure multiple deployments for a single branch. For example deploy to staging first and then, if the deployment works, to production. Another use case would be to run specific commands before and / or after your deployment.

To add a deployment method simply click on the logo. It will be added to the end of the list of deployments. You can easily re-order your deployment methods by simply dragging and dropping their logos. All of your configured deployment methods will be run sequentially.

Over time we will add more and more deployment methods so you can run various tools, test environments or commands easily. You can always fall back to **script deployments** which let you run any shell commands during the deployment.

![Deploy Settings](https://s3.amazonaws.com/docs.codeship.io/documentation/images/external/heroku/configure_deployment_heroku.png)

Deploying to Heroku is incredibly easy. Just click on the Heroku deployment method. The only necessary setting you have to do is type in your application name.

### Additional Settings

#### Backup

A backup through the standard Heroku [PostgreSQL backups](https://devcenter.heroku.com/articles/heroku-postgres-backups) will be done.

#### Force

Push via `git push --force` to Heroku to overwrite whatever was in the repository before. This is handy for deploying to your staging application as you may have pushed something to give it a try but haven't reverted. **You should never enable this for your production application**.

#### Migrate

Runs Rails migrations for your application.

#### Restore From

Copies the PostgreSQL database from another app into this applications database. For example you are pushing to staging and want to run the migrations with production data. You can restore the production db into your staging application to have it accessible for your migrations.

#### URL

The URL that will be called to check that a *HTTP/2xx* Status is returned. By default this will be `https://APP_NAME.herokuapp.com/`, but you can change that to anything you want. If you use *HTTP Basic Authentication*  add your credentials to the URL like  `https://USER:PASSWORD@APP_NAME.herokuapp.com`.

### How to connect to the databases

Codeship currently supports SQLite, PostgreSQL, MySQL, MongoDB, Redis and Memcached. All of them run on their respective default ports. Connecting to MongoDB, Redis and Memcached doesn't need any further configuration than the default one.

#### PostgreSQL and MySQL

If you use Rails Codeship automatically checks your `database.yml` file and replaces the appropriate configuration so you can access our databases.

If a `database.yml` file cannot be found we will read your Gemfile and configure the `database.yml` depending on the gems you use.

The credentials for our database are stored as **environment variables**

* PostgreSQL

  ```shell
  Username: $PGUSER
  Password: $PGPASSWORD
  ```

* MySQL

  ```shell
  Username: $MYSQL_USER
  Password: $MYSQL_PASSWORD
  ```

See [the documentation](https://codeship.com/documentation/databases/) for more information on this topic.

## Supported technologies

Following is a list of technologies, languages and additional tools supported by the Codeship.

### Source Code Management

* Git
* Mercurial (for BitBucket based repositories)

### Databases

* PostgreSQL
* MySQL
* SQLite
* MongoDB
* Beanstalkd
* RabbitMQ
* Redis
* ElasticSearch
* Memcached

### Languages

* Ruby
  * Anything Ruby native (Rails, Sinatra, ...) is supported
  * Rspec, Cucumber, Test::Uni, Minitest, ...
  * Capybara(-webkit)
* NodeJS (npm)
* Python (virtualenv) – Django is supported
* PHP (phpunit)
* Java (Maven, Ant)
* Scala (sbt)
* Clojure
* Groovy

### Additional tools

* Selenium
  * Firefox
  * Chrome
* PhantomJS
* CasperJS

## Migrating between plans

We all want to have flexibility. Changing plans is not a problem at all. Migrating from one Codeship plan to another will simply alter the resource limits of the service. No data will be lost in any way, thus making it a safe operation.

Use the CLI to migrate to a new plan.

```shell
$ heroku addons:upgrade codeship:medium
-----> Upgrading codeship:medium to sharp-mountain-4005... done,
v18 ($49/mo) Your plan has been updated to: codeship:medium
```

You can upgrade your plan on one of your Heroku apps. All of your other Heroku apps are then covered by that one plan upgrade.

## Removing the add-on

If some strange outlandish circumstances should force you to remove the add-on (remember, you don't want to remove the add-on!) Codeship can be removed via the CLI. **This will destroy all associated data and cannot be undone!**

Before removing the add-on please have a little [chat with Marko](mailto:marko@codeship.com) from the Codeship crew and tell him what made you remove it so we can improve our service for future users.

```shell
$ heroku addons:remove codeship
-----> Removing codeship from sharp-mountain-4005... done, v20
(free)
```

All your keys are named with the project name, so you can easily see which keys are in there from Codeship.

```term
$ heroku keys
ssh-rsa AAAAB3FcbR.../uX8kI4rsL codeship/owner/name
```

## Support

Heroku provides support requests for all add-ons through [https://support.heroku.com](https://support.heroku.com).
If you have any questions or need anything you can create a ticket there and they will let us know.

If you use our app the best & fastest way to contact is via our in-app support system. Additionally you can also contact us via email at [support@codeship.com](mailto:support@codeship.com) or on [twitter.com/codeship](https://twitter.com/codeship).

## The Codeship Blog

You should frequently take a look at our blog on [blog.codeship.com](https://blog.codeship.com/?utm_source=heroku&utm_medium=link&utm_campaign=herokuadd-onprogram). Our crew works hard to bring you awesome content. A lot of interesting articles about using Codeship with Heroku, automated testing, continuous integration and delivery can be found there.

Should you have any other questions, [just let us know](mailto:support@codeship.com)! And ***always keep shipping!***
