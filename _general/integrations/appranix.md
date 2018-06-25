---
title: Integrating Codeship With Appranix
shortTitle: Integrating Codeship With Appranix
tags:
  - integrations
  - operations
  - management
  - devops
menus:
  general/integrations:
    title: Using Appranix
    weight: 15
categories:
  - Integrations
---

* include a table of contents
{:toc}

## About Appranix

[Appranix](https://www.appranix.com/) simplifies and automates application operations on cloud platforms.

By using Appranix you can reduce the amount of time it takes to run and monitor cloud operations.

The [Appranix documentation](https://app.appranix.net/docs/) provides a great guide to getting started, and the instructions below have more information on integrating with [Codeship Basic](https://codeship.com/features/basic) and [Codeship Pro](https://codeship.com/features/pro).

## Codeship Pro

### Appranix.sh

Integrating Appranix with Codeship requires that you include the [appranix.sh](https://github.com/RushinthJohn/documentation/blob/master/_data/appranix.sh) script file in your project repository.

Inside this script, you will have the following:

```shell
echo "Installing Appranix CLI"
gem install prana

echo "Setting Appranix URL"
prana config set site=http://app.appranix.net/web -g

echo "Logging into Appranix"
prana auth login --username=${USER} --password=${PASSWORD} --account=${ORG}

echo "Setting Organization as ${SUBORG}"
prana config set organization=${SUBORG}

echo "Setting Assembly as ${ASSEMBLY}"
prana config set assembly=${ASSEMBLY} -g

echo "Updating latest build number"
prana design variable update -a ${ASSEMBLY} --platform=${PLATFORM} appVersion=${CI_BUILD_NUMBER}

echo "Commiting design"
prana design commit design-commit

echo "Pulling design to ${AppSpace} AppSpace"
prana configure pull -e ${AppSpace}

echo "Commiting AppSpace changes"
prana configure commit appspace-commit -e ${AppSpace}

echo "Starting AppSpace deployment"
prana transition deployment create -e ${AppSpace}
```

### Adding Appranix Credentials

To start, you need to add the following environment variables to the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

- `USER` - Username of your Appranix account
- `PASSWORD` - Password of your Appranix account
- `ORG` - Organization in your Appranix account
- `SUBORG` - Sub-organization where assembly is located
- `ASSEMBLY` - Name of the assembly where the AppSpace is located
- `PLATFORM` - Name of the platform where the artifact component is located
- `ARTIFACT` - Specific name of the artifact component which will deploy the latest build
- `AppSpace` - Name of the AppSpace where the artifact component is located

### Configuring Deployments

To use Appranix, you will need to call your `appranix.sh` script from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) after the step where your deployment takes place.

```yaml
- name: Appranix deployment
  tag: master
  service: app
  command: sh appranix.sh
```

{% csnote info %}
The container must have [Ruby version 2.3.3]({{ site.baseurl }}{% link _pro/languages-frameworks/ruby.md %}) or higher for the `appranix.sh` file to execute the required gem install.
{% endcsnote %}

## Codeship Basic

### Appranix.sh

Integrating Appranix with Codeship requires that you include the [appranix.sh](https://github.com/RushinthJohn/documentation/blob/master/_data/appranix.sh) script file in your project repository.

```shell
echo "Installing Appranix CLI"
gem install prana

echo "Setting Appranix URL"
prana config set site=http://app.appranix.net/web -g

echo "Logging into Appranix"
prana auth login --username=${USER} --password=${PASSWORD} --account=${ORG}

echo "Setting Organization as ${SUBORG}"
prana config set organization=${SUBORG}

echo "Setting Assembly as ${ASSEMBLY}"
prana config set assembly=${ASSEMBLY} -g

echo "Updating latest build number"
prana design variable update -a ${ASSEMBLY} --platform=${PLATFORM} appVersion=${CI_BUILD_NUMBER}

echo "Commiting design"
prana design commit design-commit

echo "Pulling design to ${AppSpace} AppSpace"
prana configure pull -e ${AppSpace}

echo "Commiting AppSpace changes"
prana configure commit appspace-commit -e ${AppSpace}

echo "Starting AppSpace deployment"
prana transition deployment create -e ${AppSpace}
```

### Adding Appranix Credentials

To start, you need to add the following environment variables to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

- `USER` - Username of your Appranix account
- `PASSWORD` - Password of your Appranix account
- `ORG` - Organization in your Appranix account
- `SUBORG` - Sub-organization where assembly is located
- `ASSEMBLY` - Name of the assembly where the AppSpace is located
- `PLATFORM` - Name of the platform where the artifact component is located
- `ARTIFACT` - Specific name of the artifact component which will deploy the latest build
- `AppSpace` - Name of the AppSpace where the artifact component is located

### Configuring Deployments

To use Appranix, you will need to call your `appranix.sh` script from your [deployment pipelines]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

After that add `sh appranix.sh` at the end. The script file will connect to Appranix and trigger deployment for the new build.

{% csnote info %}
Make sure you have selected [Ruby version 2.3.3]({{ site.baseurl }}{% link _basic/languages-frameworks/ruby.md %}). or higher.
{% endcsnote %}
