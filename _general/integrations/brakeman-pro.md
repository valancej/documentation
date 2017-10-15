---
title: Integrating Codeship With Brakeman Pro for Rails Security Analysis
shortTitle: Using Brakeman Pro For Rails Security Analysis
tags:
  - security
  - reports
  - reporting
  - coverage
  - integrations
  - rails
  - ruby
menus:
  general/integrations:
    title: Using Brakeman Pro
    weight: 9
categories:
  - Integrations    
redirect_from:
  - /general/integrations/brakeman/
---

* include a table of contents
{:toc}

## About Brakeman Pro

Brakeman Pro is as service for automatically testing and reporting on your Rails application's security vulnerabilities.

By using Brakeman Pro you can be confident that your Rails application is secure and up to date.

[Their documentation](https://brakemanpro.com/docs) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your Credentials

To start, you need to add your `BRAKEMAN_PRO_USER` and `BRAKEMAN_PRO_PASSWORD` credentials to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Adding The Gem

After adding the credentials, you'll need to install the Brakeman Pro gem via your project's Dockerfile, which is built by your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

This can be done with the following command in your Dockerfile, or by adding the gem to your project's `Gemfile` (which requires `bundle install` in your Dockerfile instead):

```shell
RUN gem install brakeman-pro --source https://$BRAKEMAN_PRO_USER:$BRAKEMAN_PRO_PASSWORD@brakemanpro.com/gems/
```

### Running Reports

Next, you'll want to run the actual command to generate a Brakeman Pro report as a new step in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):

```yaml
- name: brakeman-pro
  service: your_service
  command: brakeman-pro --exit-on-warn --quiet -f plain
```

There are several specific options that Brakeman Pro recommends for modifying the report behavior:

- `--exit-on-warn`: This option is important because it will cause the build to fail if any warnings are found

- `--quiet`: Removes extraneous output. If --quiet is too quiet, --no-report-progress is recommended instead

- `--f plain`: Generates a nice, colored text report

## Codeship Basic

### Setting Your Credentials

To start, you need to add your `BRAKEMAN_PRO_USER` and `BRAKEMAN_PRO_PASSWORD` credentials to your [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

### Adding The Gem

After adding the credentials, you'll need to install the Brakeman Pro gem via your [project's setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}). This can be done with the following command, or by adding the gem to your project's `Gemfile` (which requires `bundle install` in your setup commands instead):

```shell
gem install brakeman-pro --source https://$BRAKEMAN_PRO_USER:$BRAKEMAN_PRO_PASSWORD@brakemanpro.com/gems/
```

### Running Reports

Next, you'll want to run the actual command to generate a Brakeman Pro report in your [project's test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

```shell
brakeman-pro --exit-on-warn --quiet -f plain
```

There are several specific options that Brakeman Pro recommends for modifying the report behavior:

- `--exit-on-warn`: This option is important because it will cause the build to fail if any warnings are found

- `--quiet`: Removes extraneous output. If --quiet is too quiet, --no-report-progress is recommended instead

- `--f plain`: Generates a nice, colored text report

**Note** that if you are using [parallel pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallel-tests.md %}) then you likely only want to add this command to a single pipeline, rather than multiple pipelines.
