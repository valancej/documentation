---
title: Integrating Codeship Basic With Code Climate for Code Coverage Reports
layout: page
tags:
  - analytics
  - reports
  - reporting
  - code coverage
  - coverage
menus:
  basic/ci:
    title: Using Code Climate
    weight: 8
redirect_from:
  - /analytics/code-climate/
  - /classic/getting-started/code-climate/
  - /basic/analytics/code-climate/
---

* include a table of contents
{:toc}

## Setup

[The Code Climate documentation](http://docs.CodeClimate.com/article/219-setting-up-test-coverage) does a great job of guiding you, but to get started all you need to do is add your Code Climate API token to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

### Application Configuration

Once your API key is loaded, you will want to configure Code Climate to run inside your application, during your test, as you would normally without any additional modification.

### Successful build, even though tests failed

Because of a bug with version 0.8.x of simplecov, tests are reported as successful, even though they actually failed. This is caused by simplecov overriding the exit code of the test framework.

According the the [issue report on GitHub](https://github.com/colszowka/simplecov/issues/281) this won't be fixed in the 0.8 release. Please either use versions prior to 0.8 or higher than 0.9.
