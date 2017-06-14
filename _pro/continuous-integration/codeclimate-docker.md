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

<div class="info-block">
**Note** that these instructions use the newest version of the Code Climate reporter, which is still in beta. Please view [their documentation](https://docs.codeclimate.com/v1.0/docs/configuring-test-coverage-older-versions) for instructions on using the older reporter. You will still need to add your API token via [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}), as seen below, but the test configuration will work differently.
</div>

* include a table of contents
{:toc}

## Setting Up Code Climate

### Setting Your Code Climate API Token

Starting with Code Climate and Codeship is easy. [Their documentation](http://docs.CodeClimate.com/article/219-setting-up-test-coverage) do a great job of guiding you, but the first step is to add your `CC_TEST_REPORTER_ID` to the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you define in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Application Configuration

Once your Code Climate project ID is loaded via your environment variables, you will need to add a couple additional commands to your pipeline via your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

Before your test commands:

```bash
- name: codeclimate_pre
  service: YOURSERVICE
  command: cc-test-reporter before-build
```

After your test commands:

```bash
- name: codeclimate_post
  service: YOURSERVICE
  command: cc-test-reporter after-build
```

### Parallel Test Coverage

Code Climate supports parallel test reports, as a new beta feature, by uploading the partial result to an external CDN. In addition to the pre-test and post-test commands up, to use Code Climate with parallel reporting you will need to add another command after your individual tests, and after all tests have completed, in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

Here are [Code Climate's example](https://github.com/codeclimate/test-reporter#low-level-usage) scripts for doing so.

After each parallel test command you'll run a new script:

```bash
- type: parallel
  steps:
  - type: serial
    steps:
    - service: YOURSERVICE
      command: test_commands
    - service: demo
      command: codeclimate-post.sh      
  - type: serial
    steps:
    - service: YOURSERVICE
      command: test_commands
    - service: demo
      command: codeclimate-post.sh  
```

Note that we're using serial step groups being run in parallel, s that we can run our script after each parallel test thread completes. Inside the new `codeclimate-post.sh` file, you will have:

```bash
./cc-test-reporter format-coverage --output "coverage/codeclimate.$N.json"
aws s3 sync coverage/ "s3://my-bucket/coverage/$SHA"
```

Note that you will need to modify the S3 path (or provide an alternative CDN), as well as the `$SHA` and the `$N` value.

Next, at the end of your build itself, as a new test command placed after your normal tests:

```bash
- name: codeclimate_assemble_results
  service: YOURSERVICE
  command: codeclimate-assemble.sh
```

Inside the `codeclimate-assemble.sh` file, you will have:

```bash
cc-test-reporter sum-coverage --output - --parts $PARTS coverage/codeclimate.*.json | \
```

Note that you will need `$PARTS` to reflect the number of parallel threads.

### Successful build, even though tests failed

Because of a bug with version 0.8.x of simplecov, tests are reported as successful, even though they actually failed. This is caused by simplecov overriding the exit code of the test framework.

According the the [issue report on GitHub](https://github.com/colszowka/simplecov/issues/281) this won't be fixed in the 0.8 release. Please either use versions prior to 0.8 or higher than 0.9.
