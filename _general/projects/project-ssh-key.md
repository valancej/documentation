---
title: Project SSH Public Key
menus:
  general/projects:
    title: SSH Public Key
    weight: 2
tags:
  - project settings
  - ssh key
  - faq
categories:
  - Projects
redirect_from:
  - /continuous-integration/where-can-i-find-the-ssh-public-key-for-my-project/
  - /general/projects/where-can-i-find-the-ssh-public-key-for-my-project/
---

* include a table of contents
{:toc}

For communication between your Codeship project and outside via SSH, you will need your project's SSH public key which you can find in your project settings.

* Select a project and then click _Project Settings_ in the upper right corner
* Then click _General_ in the upper right corner
* Scroll down until you find the _SSH public key_ section

![SSH Public Key]({{ site.baseurl }}/images/general/sshpublickey.png)

If you need more information on how to use SSH and similar tools, see [Deployment via FTP, SFTP, SCP, RSYNC, and SSH]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-ftp-sftp-scp.md %}).

## Reset the SSH Key

If you need to reset the SSH key pair for the project you can use the _Reset project SSH key_ button. This will generate a new SSH key pair and also add the new key to your source control provider.

## Use Case Examples

* You are deploying to one of your own servers instead of using Codeship's integrations to services like AWS and Heroku.

* Your deployment script has a few more commands you want to be executed and you want to deploy to another service directly.

* You are using SSH tunnels to connect to your database within your tests.
