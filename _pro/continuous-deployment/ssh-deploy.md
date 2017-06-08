---
title: Continuous Delivery Via SSH With Docker
layout: page
menus:
  pro/cd:
    title: Deploy Via SSH
    weight: 6
tags:
  - docker
  - deployment
  - ssh key
  - encryption
  - ssh
  - rsync
  - sftp

---

<div class="info-block">
To follow this tutorial on your own computer, please [install the `jet` CLI locally first]({{ site.baseurl }}{% link _pro/builds-and-configuration/cli.md %}).
</div>

* include a table of contents
{:toc}

## Using SSH/SCP To Deploy

To deploy using SSH and SCP with Codeship Pro, you will need to create a container that can connect to your server via SSH. Then, you will pass this container the necessary deployment commands.

To do this you need to set up an encrypted SSH Key that is available as an environment variable and can be written to the `.ssh` folder.

## Creating Your SSH Key

The following command will create two files in your local repository. `keyfile.rsa` contains your private key that we will encrypt and put into your repository. This encrypted file will be decrypted on Codeship as part of your build. The second file `keyfile.rsa.pub` can be added to services that you want to access.

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f keyfile.rsa
```

Now you have to copy the content of `keyfile.rsa` into an environment file `sshkey.env`. Make sure to replace newlines with \n so the whole SSH key is in one line. The following is an example of ssh_key.env.

```bash
PRIVATE_SSH_KEY=-----BEGIN RSA PRIVATE KEY-----\nMIIJKAIBAAKCFgEA2LcSb6INQUVZZ0iZJYYkc8dMHLLqrmtIrzZ...
```

After preparing the `sshkey.env` file we can encrypt it with Jet. Follow the [encryption tutorial]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) to turn the `sshkey.env` file into a `sshkey.env.encrypted` file.

You can then add it to a service with the `encrypted_env_file` option. It will be automatically decrypted on Codeship.

```yaml
app:
  build: .
  encrypted_env_file: sshkey.env.encrypted
```

## Using The Key During The Build

Before running a command that needs SSH available make sure to run the following commands in that container. They will set up the SSH key so you can access external services.

```bash
mkdir -p "$HOME/.ssh"
echo -e $PRIVATE_SSH_KEY >> $HOME/.ssh/id_rsa
```

## Deploying Your Code

Once you've established your SSH connection, you will want to deploy your code. This is accomplished via your [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) file by using SSH deployment commands with your authenticated container.

```yaml
- service: ssh
  command: scp -rp . ssh_user@your.server.com:/path/on/server/
```
