---
title: Setting an SSH Private Key
shortTitle: Setting an SSH Private Key
menus:
  pro/builds:
    title: Setting an SSH Private Key
    weight: 13
tags:
  - ssh
  - private
  - key
  - rsa
  - clone
  - git
  - ftp
  - sftp
  - deployment
  - rsync
  - encryption

categories:
  - Builds and Configuration

redirect_from:
  - /docker/ssh-key-authentication/
  - /pro/getting-started/ssh-key-authentication/
---

{% csnote info %}
This task requires the following:

- Local machine install of our [CLI tool]({{ site.baseurl }}{% link _pro/jet-cli/usage-overview.md %})
{% endcsnote %}

Many operations require the configuration of an SSH private key within your container(s) (e.g, git clone, rsync, ssh, etc).

While the task _seems_ as simple as copying a private key right into your Docker image, this is considered [highly inadvisable](https://medium.com/@mccode/dont-embed-configuration-or-secrets-in-docker-images-7b2e0f916fdd).

---
<br>
**The suggested practice is to:**

1. [Generate or select a private key that does not require the use of a passphrase](https://github.com/codeship-library/setting-ssh-private-key-in-pro#selecting-a-private-key)
2. Store the private key within the designated [encrypted environment variable file](https://github.com/codeship-library/setting-ssh-private-key-in-pro#prepare-the-environment-variables-file) and [encrypt the file accordingly](https://github.com/codeship-library/setting-ssh-private-key-in-pro#encrypt-the-environment-variables-file)
3. During container runtime, [echo out the private key variable](https://github.com/codeship-library/setting-ssh-private-key-in-pro/blob/master/codeship-steps.yml#L1-L3) to `${HOME}/.ssh/id_rsa`
4. [Modify the permissions on the `id_rsa` file](https://github.com/codeship-library/setting-ssh-private-key-in-pro/blob/master/codeship-steps.yml#L5-L7) so that it cannot be accessed by others
5. [Keyscan known hosts](https://github.com/codeship-library/setting-ssh-private-key-in-pro/blob/master/codeship-steps.yml#L9-L11) (the hosts that you will attempt to access for SSH based operations)
6. [Configure a volume to the `${HOME}/.ssh` directory](https://github.com/codeship-library/setting-ssh-private-key-in-pro/blob/master/codeship-services.yml#L5-L6) to ensure that SSH private key and known_hosts data will persist for subsequent command steps/containers.
7. Confirm that you have securely recorded [all sensitive files and directories](https://github.com/codeship-library/setting-ssh-private-key-in-pro/blob/master/.gitignore) with the `.gitignore` file.

{% csnote info %}
If you're still largely unfamiliar with the nuts and bolts of Codeship Pro, then check out our step-by-step, from the ground up walk-through on [setting up a private ssh key](https://github.com/codeship-library/setting-ssh-private-key-in-pro)
{% endcsnote %}
