---
title: Deploy to DigitalOcean
menus:
  basic/cd:
    title: Digital Ocean
    weight: 11
tags:
  - deployment
  - digital ocean
  - digitalocean
categories:
  - Deployment 
redirect_from:
  - /continuous-deployment/deployment-to-digitalocean/
---

* include a table of contents
{:toc}

{% csnote info %}
This article is about deploying to DigitalOcean with Codeship Basic.

If you'd like to learn more about Codeship Basic, we recommend the [getting started guide]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}) or [the features overview page](http://codeship.com/features/basic)

You should also be aware of how [deployment pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}) work on Codeship Basic.
{% endcsnote %}

## Getting Started with DigitalOcean

DigitalOcean offers virtual servers (called Droplets). If you have not yet set up a Droplet, check out [DigitalOcean's tutorial](https://www.digitalocean.com/community/tutorials/how-to-create-your-first-digitalocean-droplet-virtual-server).

While not necessary, selecting the Ubuntu 14.04 image for your Droplet will provide even greater parity between your production and [CI/CD environment]({{ site.baseurl }}{% link _general/about/vm-and-infrastructure.md %}).

For the ssh key section, be sure that you are including/authorizing your [Codeship project's ssh key](https://documentation.codeship.com/general/projects/project-ssh-key/) with your Droplet.

With the exception of the Capistrano tool, all the following options would need to be configured as [custom scripts]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}) in your deployment pipeline.

## Option One: Instructing the Droplet to pull changes directly from Github/Bitbucket/Gitlab

### Capistrano

If you have a Ruby on Rails application the most common way to deploy to DigitalOcean is with [Capistrano](http://capistranorb.com/).
Check out our article on [Capistrano Deployments in Codeship]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-capistrano.md %}) for general guidance on how to run Capistrano commands from Codeship. Please also take a look at DigitalOcean's example project for [setting up Capistrano within a Droplet](https://www.digitalocean.com/community/tutorials/deploying-a-rails-app-on-ubuntu-14-04-with-capistrano-nginx-and-puma).

```shell
bundle exec cap production deploy
```

### SSH

You can also provide explicit commands on the Droplet shell via [ssh]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-ftp-sftp-scp.md %}).

```shell
ssh codeship_user@your.droplet.com \
'cd ~/src/repo ; systemctl stop node-sample ; git pull ; systemctl restart node-sample'
```

## Option Two: Copy files directly from Codeship build to Droplet

Files can be copied directly over from your Codeship deployment build to your Droplet via [ftp, sftp, scp or rsync]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-ftp-sftp-scp.md %}). Your custom deployment commands would be included in your deployment pipeline as a [custom script]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}).

### SCP

```shell
scp -rp ~/clone/* codeship_user@your.droplet.com:/path/on/droplet/
```

### Rsync

```shell
rsync -avz ~/clone/ codeship_user@your.droplet.com:/path/on/droplet/
```
