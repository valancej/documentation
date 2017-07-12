---
title: Integrating Codeship With Codacy for Code Coverage Reports
shortTitle: Using Codacy For Code Coverage
tags:
  - analytics
  - code-coverage
  - coverage
  - reports
  - reporting
  - continuous integration
  - integrations
menus:
  general/integrations:
    title: Using Codacy
    weight: 8
---

* include a table of contents
{:toc}

## About Codacy

[Codacy](https://www.codacy.com) is an automated code coverage service. Starting with Codacy and Codeship is fast and easy. [Their documentation](https://support.codacy.com/hc/en-us/articles/207993835-Add-coverage-to-your-repo) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Adding Project Token

To start, you need to add your `CODACY_PROJECT_TOKEN` to the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Project Configuration

Once your Codacy project ID is loaded via your environment variables, you will need to install the Codacy package into your Dockerfile via your prefered package manager.

You can find specific instructions per-language over at the [Codacy documentation](https://support.codacy.com/hc/en-us/articles/207993835-Add-coverage-to-your-repo).

The next step will vary by language. Some of the Codacy packages will automatically run whenever your tests run, while some will require separate commands added to your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

For instance the Rails gem will automatically update your coverage report and export it to Codacy and requires no additional steps, whereas the Python package will require an additional command placed either directly in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) or inside of a script:

```bash
- name: codacy
  service: app
  command: python-codacy-coverage -r coverage.xml
```

**Note** that the above command is only for Python. We recommend reviewing [their documentation]([Their documentation](https://support.codacy.com/hc/en-us/articles/207993835-Add-coverage-to-your-repo) for your specific language to be sure the necessary commands are run.

## Codeship Basic

### Adding Project Token

To start, you need to add your `CODACY_PROJECT_TOKEN` to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

### Project Configuration

Once your Codacy project ID is loaded via your environment variables, you will need to install the Codacy package via your preferred package manager in your project's [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

You can find specific instructions per-language over at the [Codacy documentation](https://support.codacy.com/hc/en-us/articles/207993835-Add-coverage-to-your-repo).

The next step will vary by language. Some of the Codacy packages will automatically run whenever your tests run, while some will require separate commands added to your project's [test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

For instance the Rails gem will automatically update your coverage report and export it to Codacy and requires no additional steps, whereas the Python package will require an additional command placed either directly in your [[test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}) or inside of a script:

```bash
python-codacy-coverage -r coverage.xml
```

**Note** that the above command is only for Python. We recommend reviewing [their documentation]([Their documentation](https://support.codacy.com/hc/en-us/articles/207993835-Add-coverage-to-your-repo) for your specific language to be sure the necessary commands are run.
