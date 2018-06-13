---
title: Using Scripts In CI/CD with Codeship Basic
shortTitle: Using Scripts
menus:
  basic/builds:
    title: Using Scripts
    weight: 12
tags:
  - scripts
  - scripting
  - bash
  - shell
categories:
  - Builds and Configuration  
---

* include a table of contents
{:toc}

## Using Scripts

Using scripts on Codeship Basic is a great way to customize and further automate tasks in your builds. Scripts can be used in a variety of ways from build setup to [deployments]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}). We also have a [repository of scripts](https://github.com/codeship/scripts) that help with various package installations and deployments. These scripts are also great starting points for writing your own customizations.

## Storing and Calling Scripts

There are a couple options for where to store scripts used in your project.

### Your Repository

The most common option is to store them directly in your repository so that the scripts are under source control just like the rest of your project.

Once it is part of your repository there are a couple interchangeable ways to call the script in the build assuming you are doing some kind of Bash/shell scripting:

```shell
./path/to/script.sh

bash path/to/script.sh
```

If your script is exporting any environment variables that need to be available to other steps in your build you will need to source the script:

```shell
source path/to/script.sh
```

### Remote Server

Another option is for your scripts to reside in a remote location. This could be a private server, a different repository or even a simple [Gist](https://gist.github.com). The scripts in our [repository](https://github.com/codeship/scripts) also fall into this category.

You can call a remote script from your build using curl:

```shell
curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/firefox.sh | bash -s
```

Again, if the script is exporting any variables you need to source it:

```shell
source /dev/stdin <<< "$(curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/languages/go.sh)"
```

## Notes And Known Issues

### set -e

Using `set -e` in your scripts can have undesirable side effects on Codeship Basic if called incorrectly. You should only use `set -e` in a script you are calling directly. It should not be used in scripts that you are sourcing and it should also not be used directly on Codeship as a build step.

By default the shell doesn’t exit after a failed command, but continues to run other commands until the script finishes and then returns with the exit code of the last run command.

A script like the following will always return with an exit code of 0. Therefore if an error occurs earlier in the script, it may not be obvious in the build logs and the build will still pass.

```shell
#!/bin/sh

# Simulate two commands, one exits with a 0 exit code, the other does not
# Run them in a subshell via $(command) to simulate actually running an external command
$(exit 255)
$(exit 0)
```

In a shell script you can use `set -e` to exit after the first failing command. This option will exit immediately if a command exits with a non-zero status. A script like the following will exit with an exit code of 255.

```shell
#!/bin/sh
set -e

$(exit 255)
# Will never reach this line
$(exit 0)
```

It is safe and recommended to use `set -e` directly in your scripts, but again you cannot use `set -e` in sourced scripts or directly as a build step. This is because the option will cause the process that called the command to exit if there is an error in the script. In this case that is the SSH session which is used to control your build. From Codeship's view the build container has terminated and the build will fail.
