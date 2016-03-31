---
title: Deploy to Heroku
weight: 90
layout: page
tags:
  - deployment
  - heroku
categories:
  - continuous-deployment
---
Codeship makes makes it easy to deploy your application to Heroku with Codeship's integrated [deployment pipelines]({{ site.baseurl }}{% post_url continuous-deployment/2014-09-03-deployment-pipelines %}).

* include a table of contents
{:toc}

## Setup Heroku Deployment

### Step 1 - Navigate to Deployment Configuration
Navigate to your project's deployment configuration page by selecting _Project Settings_ > _Deployment_ on the top right side of the page.

![Project Settings Deployment]({{ site.baseurl }}/images/continuous-deployment/project_configuration.png)

### Step 2 - Add New Deployment Pipeline 
Edit an existing deployment pipeline or create a new deployment pipeline by selecting + _Add new deployment pipeline_. Create the deployment pipeline to match the exact name of your deployment branch or a [wildcard branch]({{ site.baseurl }}/continuous-deployment/wildcard-deployment-pipelines/). 

![Create branch deploy]({{ site.baseurl }}/images/continuous-deployment/create_deploy_branch.png)

### Step 3 - Heroku
Select _Heroku_

![Select Heroku]({{ site.baseurl }}/images/continuous-deployment/select_heroku.png)


### Step 4 - Deployment Configuration

![Configure Heroku]({{ site.baseurl }}/images/continuous-deployment/configure_heroku.png)

#### Application URL
Insert the name of the Heroku application you want to the pipeline to deploy to.

#### Heroku API Key
In order for you to deploy your app using Codeship, you need to provide your Heroku API key to give codeship access to your Heroku account. You can access your Heroku API key [here](https://dashboard.heroku.com/account).

### Success!

![Heroku Success]({{ site.baseurl }}/images/continuous-deployment/heroku_success.png)

You have now successfully setup deployment to Heroku. Go ahead and push a commit to your configured deploy branch.

## Additonal Configuration Settings (optional)
You can configure additional settings to your Heroku deployment by selecting **More Options**:

![Select Heroku Deploy Options]({{ site.baseurl }}/images/continuous-deployment/select-heroku-deploy-options.png)

![Heroku Deploy Options]({{ site.baseurl }}/images/continuous-deployment/heroku-deploy-options.png)

### URL
After each deployment, we check your application to make sure that it is up. We will either call the default `*.herokuapp.com` URL or the URL you specified here.

If this URL requires **basic auth** please enter: `http://YOUR_USERNAME:YOUR_PASSWORD@YOUR_URL`

### Restore
Add the end URL of the bucket you plan to access and import your dump file into. See Heroku's article [Import to Heroku Postgres](https://devcenter.heroku.com/articles/heroku-postgres-import-export#import-to-heroku-postgres).

### Backup Database
Option to backup your database before deploy. See [Download Backup](https://devcenter.heroku.com/articles/heroku-postgres-import-export#download-backup) for more information.

### Force Push
Pushes into heroku with `-f` so the current commit overwrites anything on Heroku. 

NOTE: Only enable this for staging environments.

### Run Migrations
You can specify to run the migration during the Heroku deployment. If you want to run your migration after the deployment, you can add a [custom script]({{ site.baseurl }}{% post_url continuous-deployment/2014-09-03-deployment-with-custom-scripts %}) after the Heroku deployment and run the migration.

**Example**:

```shell
heroku run --exit-code --app ${HEROKU_APPLICATION_NAME} -- bundle exec rake db:migrate
```

![Heroku Migration After Deploy]({{ site.baseurl }}/images/continuous-deployment/heroku-migration-after-deploy.png)

### Check app URL
This will enable your build to check the URL of your application to make sure that it is up.

## Troubleshooting
- [check_url fails when deploying to Heroku]({{ site.baseurl }}{% post_url faq/2014-09-10-check_url-fails-for-heroku-deployment %})

## Questions
If you have any further questions, please create a post on the [Codeship Community](https://community.codeship.com/) page.








<!--

## Settings
Within Codeship you are able to configure [Deployment Pipelines]({{ site.baseurl }}{% post_url continuous-deployment/2014-09-03-deployment-pipelines %}). You can easily add a Heroku Deployment choosing Heroku as deployment method.

You are asked to enter the **name of your Heroku application** and your **Heroku API key**. You need to create the application on Heroku first.

By clicking on **more options** you can configure additional settings.

### URL of your Heroku Application
After each deployment we check if your app is up. Therefore we call (`wget`) either the default `*.herokuapp.com` URL or the URL you specified here.

If this URL requires **basic auth** please enter: `http://YOUR_USERNAME:YOUR_PASSWORD@YOUR_URL`

## Run commands on Heroku
With the latest versions of the Heroku toolkit it is now possible to run arbitrary command without the need for our `heroku_run` wrapper. Simply specify the command in the following form in a *custom script* deployment. This will trigger using the newest codepath and will exit with the correct exit code.

```shell
heroku run --exit-code --app ${HEROKU_APPLICATION_NAME} -- ${COMMAND_TO_RUN}
```

-->


