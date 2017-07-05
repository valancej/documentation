---
title: Using Meteor In CI/CD with Codeship Basic
shortTitle: Meteor
menus:
  basic/languages:
    title: Meteor
    weight: 9
tags:
  - meteor
  - npm
  - yarn
  - framework
---

* include a table of contents
{:toc}

## Setup

Meteor's default installer requires sudo on Linux. We use a script to change install location and make sudo unnecessary:

```shell
\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/meteor.sh | bash -s
```

### Custom Versions

This setup script will always pull for the most recent meteor tool. You can also call meteor commands with a specified release:

```shell
meteor create test --release 0.6.1
```

## Dependencies

You can use npm or yarn to install your dependencies.

### NPM

We set the `$PATH` to include the `node_modules/.bin` folder so all executables installed through npm can be run.

We also automatically cache the `$REPO_ROOT/node_modules` directory between builds to optimize build performance. You can [read this article to learn more]({{ site.baseurl }}{% link _basic/builds-and-configuration/dependency-cache.md %}).

### Yarn

You can also use [Yarn](https://yarnpkg.com/en) to install your dependencies as an alternative to npm. Yarn is pre-installed on the build VMs. We configure `yarn` to write into `$HOME/cache/yarn`, which is also cached.

```shell
meteor npm install -g yarn
meteor yarn
```

## Parallelization

In addition to parallelizing your tests explicitly [via parallel pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallelci.md %}), some customers have found using the [mocha-parallel-tests npm](https://www.npmjs.com/package/mocha-parallel-tests) is a great way to speed up your tests.

Note that we do not officially support or integrate with this module and that it is possible for this to cause resource and build failure issues, as well.

## Notes and Known Issues

### Deployment

#### Basic Deployment

```shell
meteor deploy METEOR_APP_URL
```

#### Deployment with Session Info

Add the following environment variables to your project configuration:

* METEOR_SESSION
* METEOR_USER_ID
* METEOR_TOKEN
* METEOR_APP_URL

And include the following command to your deployment pipeline:

```shell
\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/deployments/meteor.sh | bash -s
```

### Process Out of Memory

Sometimes Meteor commands will run into Node's default memory limit resulting in this error:

```
FATAL ERROR: CALL_AND_RETRY_LAST Allocation failed - process out of memory
Aborted (core dumped)
```

If this happens in your build you can increase the memory limit by setting this environment variable for the project:

* TOOL_NODE_FLAGS=--max-old-space-size=4096
