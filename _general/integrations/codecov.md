---
title: Integrating Codeship With Codecov for Code Coverage Reports
shortTitle: Using Codecov For Code Coverage
tags:
  - analytics
  - code-coverage
  - coverage
  - reports
  - reporting
  - continuous integration
  - integrations
  - codecov
menus:
  general/integrations:
    title: Using Codecov
    weight: 8
---

* include a table of contents
{:toc}

## About Codecov

Codecov is an automated code coverage service. Starting with Codecov and Codeship is fast and easy. [Their documentation](https://docs.codecov.io/docs/) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Adding Upload Token

To start, you need to add your `CODECOV_TOKEN` to the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Project Configuration

Once your Codecov upload token is loaded via your environment variables, you will need to add the Codecov reporting command as a new step in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

After running your test commands, you can add:

```bash
- name: codecov
  service: YOURSERVICE
  command: bash -c "curl -s https://codecov.io/bash"
```

**Note** that this uses their universal uploader. They also provide language and framework-specific packages that you can integrate directly into your test suite if you prefer. [View their language-specific documentation and examples](https://github.com/codecov/example-ruby) for more specific information.

## Codeship Basic

### Adding Upload Token

To start, you need to add your `CODECOV_TOKEN` to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

### Project Configuration

Once your Codecov upload token is loaded via your environment variables, you will need to add the Codecov reporting command in your [test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

```bash
bash <(curl -s https://codecov.io/bash)
```

**Note** that this uses their universal uploader. They also provide language and framework-specific packages that you can integrate directly into your test suite if you prefer. [View their language-specific documentation and examples](https://github.com/codecov/example-ruby) for more specific information.
