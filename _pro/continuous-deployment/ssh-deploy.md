---
title: Deploying Via SSH With Docker
shortTitle: Deploying With SSH
menus:
  pro/cd:
    title: Deploy Via SSH
    weight: 14
tags:
  - docker
  - deployment
  - ssh key
  - encryption
  - ssh
  - rsync
  - public key
  - private key
  - sftp
  - linode
  - digital ocean
categories:
  - Deployment
---

* include a table of contents
{:toc}

## Using SSH/SCP To Deploy

To deploy using SSH and SCP with Codeship Pro, you will need to create a container that can connect to your server via SSH. Then, you will pass this container the necessary deployment commands.

{% csnote info %}
Please follow our outlined steps on [setting your private SSH key]({{ site.baseurl }}{% link _pro/builds-and-configuration/setting-ssh-private-key.md %}) before proceeding
{% endcsnote %}

### Deploying

After the private SSH key configuration is complete, you can add SSH/SCP deploy commands to the [codeship-steps.yml file]({% link _pro/builds-and-configuration/steps.md %}):

```yaml
- name: Copy Files
  service: app
  command: scp -r /app/ user@myserver.com:app/
- name: Restart Server
  service: app
  command: ssh user@myserver.com restart_server
```

## Common Problems

### Authentication Failure

If your SSH authentication commands are failing, there are several troubleshooting steps to take.

- First, try connecting using that key locally to verify the key and the corresponding public key are configured and working as intended.

- Next, try running your deployments locally with [our local CLI tool]({{ site.baseurl }}{% link _pro/jet-cli/usage-overview.md %}) to see if you receive the same error messages.

- Ensure that your target endpoints are acknowledged in your `$HOME/.ssh/known_hosts`.

- Often times these issues are related to character escaping or issues loading the key into the proper directory, so running `printenv` and `ls` commands will help you verify that the correct key has been loaded and that it is where you want it to be.
