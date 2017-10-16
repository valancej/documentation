---
title: Debugging Your Builds Via SSH Sessions
shortTitle: Debugging Builds Via SSH
menus:
  basic/builds:
    title: Debugging Builds
    weight: 3
tags:
  - testing
  - ssh
  - key
  - debug
  - troubleshooting
categories:
  - Builds and Configuration
redirect_from:
  - /continuous-integration/ssh-access/
  - /basic/getting-started/ssh-access/
---

* include a table of contents
{:toc}

## What Is An SSH Debug Session?

You may find yourself trying to figure out why a particular build is failing, especially if the build succeeds locally or succeeded in the past.

In order to effectively diagnose the issue, we provide command line access to a replicated instance of your failing build. This SSH debug session will include all configured environment variables from the original build run.

## Configuring SSH Access

To be able to open an SSH debug session, you will need to configure SSH access on your account. The first thing you will need to do is get your local machine's SSH key.

If you need to generate a new local key, you can do so by running:

```shell
ssh-keygen -b 8192
```

Or, if you need to fetch your existing local key, you can do so by running:

```shell
cat ~/.ssh/id_rsa.pub
```

Once you have your local key, you will need to add it to your Codeship *Account Settings*, which is accessible by clicking on your name in the top right of your screen. Once there, you will paste your local machine's key into the box labeled *Public SSH Key*.

![Public Key Setup]({{ site.baseurl }}/images/basic/public-key.png)

## Using SSH Debug Sessions

When you start a SSH Debug session from your build's dropdown menu, we will clone the repository and set up all environment variables that you defined and that we set by default.

**Note** that your setup commands have _not_ run yet on the debug machine. You usually want to start with those commands. Also note that you default directory is `$HOME`, and that your project will be found in `$HOME/clone`.

![Start A Debug Build]({{ site.baseurl }}/images/continuous-integration/ssh.png)

There are several key ways to use SSH sessions to solve your issues:

- You can try different versions of your tools and technologies combined with your tests to see if you can isolate any version issues.

- Consider manually trying different package versions, or removing packages, to see if modifying the packages installed impacts the behavior you're trying to solve.

- You can see the environment variables with a `printenv` command to check for configuration and availability.

- You can interact directly with the databases and other services, allowing you to workshop your setup commands before having to run live builds with them.

### Useful Commands

Inside the SSH session, you have access to default Codeship commands. It provides some convenient methods to debug your project. You can view the available methods by running:

```shell
cs help
```

You can view all your environment variables by running:

```shell
printenv
```

You can use `grep` to filter the Environment:

```shell
printenv | grep CI
```

You can clear the [Dependency Cache]({{ site.baseurl }}{% link _basic/builds-and-configuration/dependency-cache.md %}):

```shell
cs clear-cache
```

### Common issues

#### Prompted For Password

If you are being prompted for a password while connecting to your SSH debug session, you likely have a mismatch with the key you added to your Codeship account.

Try removing the key, verifying or regenerating the key locally and then re-adding it.

**Note** that after saving your key it will only apply to new builds, so you must trigger your builds _after_ you add your key to be able to connect.

#### SSH Debug Session Timeout

The debug build will shutdown itself after **60 minutes**

You can shutdown the debug build manually by using

```shell
cs exit
```

#### Branch No Longer Exists

If you restart a build, or trigger an SSH debug build for a branch that has since been removed from your source control repo you will see the build fail as it is unable to clone the branch it is keyed to.
