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

## Setting Up Code Climate

### Setting Your Code Climate API Token

[The Code Climate documentation](http://docs.CodeClimate.com/article/219-setting-up-test-coverage) does a great job of guiding you, but to get started all you need to do is add your `CC_TEST_REPORTER_ID` to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

### Application Configuration

Once your Code Climate project ID is loaded via your environment variables, you will need to add special Code Climate commands before and after your [test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

Before your tests:

```bash
cc-test-reporter before-build
```

After your tests:

```bash
cc-test-reporter after-build
```

### Parallel Test Coverage

Code Climate supports parallel test reports, as a new beta feature, by uploading the partial result to an external CDN. In addition to the pre-test and post-test commands up, to use Code Climate with parallel reporting you will need to add another command at the end of your [test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}), in each [parallel pipeline]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallelci.md %}) that you run tests in - as well as a new command at the end of your build.

Here are [Code Climate's example](https://github.com/codeclimate/test-reporter#low-level-usage) scripts for doing so.

At the end of each [parallel pipeline]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallelci.md %}):

```bash
./cc-test-reporter format-coverage --output "coverage/codeclimate.$N.json"
aws s3 sync coverage/ "s3://my-bucket/coverage/$SHA"
```

Note that you will need to modify the S3 path (or provide an alternative CDN), as well as the `$SHA` and the `$N` value.

At the end of your build itself, as a new test command placed after your normal tests:

```bash
cc-test-reporter sum-coverage --output - --parts $PARTS coverage/codeclimate.*.json | \
```

Note that you will need `$PARTS` to reflect the number of parallel threads.

All of these commands will work best when executed from script files.

### Successful build, even though tests failed

Because of a bug with version 0.8.x of simplecov, tests are reported as successful, even though they actually failed. This is caused by simplecov overriding the exit code of the test framework.

According the the [issue report on GitHub](https://github.com/colszowka/simplecov/issues/281) this won't be fixed in the 0.8 release. Please either use versions prior to 0.8 or higher than 0.9.
