---
title: Deploy With Capistrano
menus:
  basic/cd:
    title: Capistrano
    weight: 13
tags:
  - deployment
  - capistrano
categories:
  - Continuous Deployment   
redirect_from:
  - /continuous-deployment/deployment-with-capistrano/
---

* include a table of contents
{:toc}

You can deploy any kind of application with Capistrano. For detailed information about Capistrano check [capistranorb.com](http://capistranorb.com). Don't forget to [include Capistrano](#capistrano-is-not-installed-by-default) in your projects as it's not preinstalled on our build servers.

## Capistrano with a custom script deployment

To setup a Capistrano deployment on Codeship, first create a new [custom script deployment]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}). From there you can add any commands you need, including installing and calling your Capistrano deployment.

```shell
gem install capistrano
bundle exec cap $STAGE deploy
```

## Common Errors

### Authentication fails

Usually Capistrano relies on a SSH connection to copy files and execute remote commands. If connecting to your server fails with an error message (e.g. asking for a password), please take a look at our [documentation on authenticating via SSH public keys]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-ftp-sftp-scp.md %}#authenticating-via-ssh-public-keys) for more information.

### Capistrano is not installed by default

If you don't have Capistrano in your `Gemfile` you need to install it first. Simply add the following command to a script based deployment which runs before the Capistrano deployment.

```shell
gem install capistrano
```

### Deployment fails because of detached checkout

Because Codeship only fetches the last 50 commits as well as checks out your repository in detached head mode, Capistrano may fail the deployment. If this is the case for your setup, please add the following two commands to your deployment script. They will fetch the full history of the repository and switch to the branch you are currently testing.

```shell
git fetch --unshallow || true
git checkout "${CI_BRANCH}"
```
