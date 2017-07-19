---
title: Continuous Delivery to Heroku with Docker
shortTitle: Deploying To Heroku
menus:
  pro/cd:
    title: Heroku
    weight: 3
tags:
  - deployment
  - heroku
  - docker

redirect_from:
  - /docker-integration/heroku/
---

<div class="info-block">
You can find a sample repository for deploying to Heroku with Codeship Pro on Github [here](https://github.com/codeship-library/heroku-deployment).
</div>

* include a table of contents
{:toc}

To make it easy for you to deploy your application to Heroku we've built an image that you can add to your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) and use in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

This image will support both a standard Heroku deployment by using the Heroku Toolbelt CLI to let you run Heroku deployment command, as well as a Docker deployment to Heroku by letting you push an image to Heroku's image registry to trigger your deployment.

## Authentication

### Heroku API Key

Before setting up the [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) and [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) files, you will need to create an encrypted environment file that contains the Heroku API key.

This will be done by using Codehip Pro's [encrypted environment files feature]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}), which allows you to add your environment variables through an encrypted file placed in your repository. In this example, the file will be called `heroku-deployment.env.encrypted` and will encrypt the following data at a minimum:

```bash
HEROKU_API_KEY=your_api_key_here
```

You can get the Heroku API key from your [Heroku Dashboard](https://dashboard.heroku.com/account) or other methods outlined in the [Heroku documentation](https://devcenter.heroku.com/articles/platform-api-quickstart#authentication).

### Heroku Deployment Container

In the [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}), you will add a new service definition in addition to your primary application services. This definition will be for an image that will create the deployment container, which is the container all Heroku authentication and deployment commands will execute on.

Note that Codeship maintains an image for this purpose. All you need to do is include it and provide your API key through the encrypted file discussed above, as well as set a [host volume]({{ site.baseurl }}{% link _pro/builds-and-configuration/docker-volumes.md %}) so that you can share data with your primary containers.

```yaml
herokudeployment:
  image: codeship/heroku-deployment
  encrypted_env_file: heroku-deployment.env.encrypted
  volumes:
    - ./:/deploy
```

## Deploying To Heroku

### Deployment Option #1: Platform Deployment

If you are  not using [Heroku's Docker suppport](https://devcenter.heroku.com/articles/container-registry-and-runtime) to run Docker in production, you will most likely want to deploy using Heroku CLI commands and the [Heroku Platform API](https://devcenter.heroku.com/articles/build-and-release-using-the-api). By using the Platform API, no SSH key management is necessary.

The deployment container discussed above has a `codeship_heroku deploy` command that you need to call, along with the path to your application. In this example, the path to our application is actually coming through our separate, application container via a [host volume]({{ site.baseurl }}{% link _pro/builds-and-configuration/docker-volumes.md %}) (in this case `/deploy`). You will also need to provide your application name. The default script will then check that it has access to the application and deploy it.

```yaml
- service: herokudeployment
  command: codeship_heroku deploy /deploy codeship-heroku-deployment
- service: herokudeployment
  command: heroku run --app codeship-heroku-deployment -- bundle exec rake db:migrate
```

Additionally, if you provide the location of the application that should be deployed then you can also deploy subfolders of your app, or even run different commands on your codebase before deploying it. These optional specifications will give you more granular control over your deployment steps.

Also note above that the deployment container has the Heroku Toolbelt installed you can use other Heroku commands in further steps, e.g. to run your database migrations.


### Deployment Option #2: Docker Deployment

If you are using [Heroku's Docker suppport](https://devcenter.heroku.com/articles/container-registry-and-runtime), you can trigger a deployment simply by doing an [image push]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}#push-steps) to the Heroku registry.

On Codeship Pro, a push step happens in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) and requires that we generate an authentication token to authenticate with the Heroku registry. Codeship maintains an image that you will use to generate your authentication token, simply add it to your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) and provide your Heroku API key via the encrypted environment variables file discussed above.

```bash
dockercfg_generator:
  build:
    image: codeship/heroku-dockercfg-generator
    path: ./dockercfg-generator
  add_docker: true
  encrypted_env_file: heroku-deployment.env.encrypted
```

This image will be used on our push step, and is configured to automatically generate the token using the API key provided in the encrypted environment variables file.

Once we have this service in place, we can push to the Heroku registry in our [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):

```bash
- name: Push
  service: dockercfg_test
  type: push
  image_name: registry.heroku.com/your_image/name
  registry: registry.heroku.com
  dockercfg_service: dockercfg_generator
```

Note that the `dockercfg_service` directive calls the `dockercfg_generator` we specified above, to generate our token. The only variable you need to be sure to modify if the `image_name`, which must be set to the name for the application image you are pushing as defined in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).
