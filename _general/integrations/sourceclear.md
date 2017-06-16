---
title: Integrating Codeship With SourceClear for Security Analysis
shortTitle: Using SourceClear For Security Analysis
tags:
  - security
  - reports
  - reporting
  - coverage
  - integrations
menus:
  general/integrations:
    title: Using SourceClear
    weight: 4
redirect_from:
  - /basic/continuous-integration/sourceclear/
  - /pro/continuous-integration/sourceclear-docker/    
---

* include a table of contents
{:toc}

## About SourceClear

SourceClear is as service for automatically testing and reporting on your application's security vulnerabilities. [Their documentation](https://www.sourceclear.com/docs/) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your API Token

To start, you need to add your SourceClear API token to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you define in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Adding Commands

After adding the API token, you will need to add the following commands to a script, placed in your repository, that you will call from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):


```bash
curl -sSL https://download.sourceclear.com/ci.sh | bash
 ```

**Note** that if you are using [parallel test steps]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) then you likely only want to call this script once, as it's own step, rather than as part of your test steps themselves.

## Codeship Basic

### Setting Your API Token

To start, you need to add your SourceClear API token to your [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

### Adding Commands

After adding the API token, you'll just need to add the SourceClear command to your project's test commands. The command to add is:

```bash
curl -sSL https://download.sourceclear.com/ci.sh | bash
 ```

**Note** that if you are using [parallel test pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallelci.md %}) then you likely only want to add this command to a single pipeline, rather than multiple pipelines.
