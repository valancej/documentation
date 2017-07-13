---
title: Deploy to DigitalOcean
menus:
  basic/cd:
    title: Digital Ocean
    weight: 8
tags:
  - deployment
  - digital ocean
  - digitalocean

redirect_from:
  - /continuous-deployment/deployment-to-digitalocean/
---

* include a table of contents
{:toc}

## Getting Started with DigitalOcean
DigitalOcean offers virtual servers (called Droplets). If you have not yet set up a Droplet, see DigitalOcean's tutorial [here](https://www.digitalocean.com/community/tutorials/how-to-create-your-first-digitalocean-droplet-virtual-server).

While not necessary, selecting the Ubuntu 14.04 image for your Droplet will provide even greater parity between your production and [CI/CD environment]({{ site.baseurl }}{% link _general/about/vm-and-infrastructure.md %}).

For the ssh key section, be sure that you are including/authorizing your [Codeship project's ssh key](https://documentation.codeship.com/general/projects/project-ssh-key/) with your Droplet.

## Deployment Integrations

If you have a Ruby on Rails application the most common way to deploy to DigitalOcean is with Capistrano.
Check out our article on [Capistrano Deployments in Codeship]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-capistrano.md %}) as well as DigitialOcean's own [tutorial](https://www.digitalocean.com/community/tutorials/deploying-a-rails-app-on-ubuntu-14-04-with-capistrano-nginx-and-puma) for deploying a Rails application to your Droplet with Capistrano.

DigitalOcean also provides deployment integration tutorials for [PHP](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-basic-php-application-using-ansible-on-ubuntu-14-04), [Node](https://www.digitalocean.com/community/tutorials/how-to-deploy-node-js-applications-using-systemd-and-nginx) and [Python](https://www.digitalocean.com/community/tutorials/how-to-deploy-python-web-applications-with-the-bottle-micro-framework-on-ubuntu-14-04).

## Custom Script Deployments

You can also deploy to your DigitalOcean Droplet directly via [ftp, sftp, scp, rsync or ssh]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-ftp-sftp-scp.md %}). Your custom deployment commands would be included in your deployment pipeline as a [custom script]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}).
