---
title: Integrating Codeship Pro With Code Climate for Code Coverage Reports
layout: page
tags:
  - analytics
  - code coverage
  - coverage
  - reports
  - reporting
menus:
  pro/ci:
    title: Using Code Climate
    weight: 6
---

* include a table of contents
{:toc}

## Setting Up Code Climate

### Setting Your Code Climate API Token

Starting with Code Climate and Codeship is easy. [Their documentation](http://docs.CodeClimate.com/article/219-setting-up-test-coverage) do a great job of guiding you, but the first step is to add your Code Climate API key to the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you define in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Application Configuration

Once your API key is loaded, you will want to configure Code Climate to run inside your application, during your test, as you would normally without any additional modification.

### Successful build, even though tests failed

Because of a bug with version 0.8.x of simplecov, tests are reported as successful, even though they actually failed. This is caused by simplecov overriding the exit code of the test framework.

According the the [issue report on GitHub](https://github.com/colszowka/simplecov/issues/281) this won't be fixed in the 0.8 release. Please either use versions prior to 0.8 or higher than 0.9.
