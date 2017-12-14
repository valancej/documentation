---
title: Deploy To Heroku
menus:
  basic/cd:
    title: Heroku
    weight: 3
tags:
  - deployment
  - heroku
categories:
  - Continuous Deployment  
redirect_from:
  - /continuous-deployment/deployment-to-heroku/
  - /faq/push-to-heroku-rejected/
  - /tutorials/continuous-deployment-heroku-github-ruby-rails/
  - /general/projects/check_url-fails-for-heroku-deployment/
---

* include a table of contents
{:toc}

Codeship makes it easy to deploy your application to Heroku using Codeship's integrated [deployment pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}).

## Setup Heroku Deployment

### Step 1 - Navigate to Deployment Configuration
Navigate to your project's deployment configuration page by selecting _Project Settings_ > _Deploy_ on the top right side of the page.

![Project Settings Deployment]({{ site.baseurl }}/images/continuous-deployment/project_configuration.png)

### Step 2 - Add New Deployment Pipeline
Edit an existing deployment pipeline or create a new deployment pipeline by selecting + _Add new deployment pipeline_. Create the deployment pipeline to match the exact name of your deployment branch or a [wildcard branch]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}#wildcard-branch-deployment-pipelines).

![Create branch deploy]({{ site.baseurl }}/images/continuous-deployment/create_deploy_branch.png)

### Step 3 - Heroku
Select _Heroku_

![Select Heroku]({{ site.baseurl }}/images/continuous-deployment/select_heroku.png)


### Step 4 - Deployment Configuration

![Configure Heroku]({{ site.baseurl }}/images/continuous-deployment/configure_heroku.png)

#### Application Name
Insert the name of the Heroku application you want the pipeline to deploy to.

#### Heroku API Key
In order for you to deploy your app using Codeship, you need to provide the Heroku API key from your Heroku account. You can access your Heroku API key [here](https://dashboard.heroku.com/account).

### Success!

![Heroku Success]({{ site.baseurl }}/images/continuous-deployment/heroku_success.png)

You have now successfully setup deployment to Heroku. Go ahead and [push a commit to your configured deploy branch]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md).

## Additional Configuration Settings (optional)
You can configure additional settings to your Heroku deployment by selecting **More Options**:

![Select Heroku Deploy Options]({{ site.baseurl }}/images/continuous-deployment/select-heroku-deploy-options.png)

![Heroku Deploy Options]({{ site.baseurl }}/images/continuous-deployment/heroku-deploy-options.png)

#### URL
After each deployment, we check your application to make sure that it is up. We will either call the default `*.herokuapp.com` URL or the URL you specified here.

If this URL requires **basic auth** please enter: `http://YOUR_USERNAME:YOUR_PASSWORD@YOUR_URL`

#### Restore
This takes a different Heroku app and will restore the database of the current Heroku application you are deploying to with the main database from the Heroku application posted here.

#### Backup Database
Backup your database before you deploy. See Heroku's [Creating a Backup](https://devcenter.heroku.com/articles/heroku-postgres-backups#creating-a-backup) page for more information.

#### Force Push
This causes git to disable some checks and can cause the remote repository to lose commits. Use this option with care.

See [git push -f](https://git-scm.com/docs/git-push) for more info.

#### Post-deploy Command
You can specify a command to run post-deployment. The dynos will be restarted after running. This can be useful for running migrations or other commands that need to be run on each deploy.

#### Check app URL
This will enable your build to check the URL of your application to make sure that it is up.

## Troubleshooting

### Missing SSH Key
The public SSH key for your Codeship project should automatically get added to Heroku when you setup the deployment. If the key is missing or incorrect you may see an error like this during the `git push` step of the deploy:

```
Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

To fix this issue, get the public SSH key for your project under _Project Settings_ > _General_ and [add it to Heroku](https://devcenter.heroku.com/articles/keys#adding-keys-to-heroku).

### SSH Key is Already in Use

During a Heroku deployment you might encounter this error on the step that syncs your project's SSH key to Heroku:

```
This key is already in use by another account. Each account must have a unique key.
```

To fix this issue, visit _Project Settings_ > _General_ and click _Reset project SSH key_. This will reset the SSH key for the project and add the new key to the repository on your SCM. The next time you deploy the new SSH key will automatically sync to Heroku.

### check_url fails for Heroku deployment

After each deployment we check if your app is up. Therefore we call (`wget`) either the default `*.herokuapps.com` URL or the URL you specified here.

If the build fails during `check_url YOUR_URL` it's usually because your application does not respond with a HTTP/2xx status code at the URL you provided (or the default URL for the deployment if you didn't provide any).

**To solve this, you can:**

* Respond with a HTTP/200 status code at the root of your application.

* Configure a URL that will respond with such an status code in the advanced deployment configuration.

* Enter a generic URL(e.g. `http://google.com`) in the deployment configuration if you want to _disable_ the check entirely.

**Note** that you can disabled the check URL functionality by unselecting the "Check app URL" options on the deployment configuration.
