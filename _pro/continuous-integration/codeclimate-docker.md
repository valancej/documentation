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

Once your Code Climate project ID is loaded via your environment variables, you will need to install Code Climate into one of your services via your Dockerfile by using the following command:

```bash
curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > "$/usr/local/bin/cc-test-reporter"
chmod +x "/usr/local/bin/cc-test-reporter"
```

Next, you will need to add a couple additional commands to your pipeline via your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

Before your test commands:

```bash
- name: codeclimate_pre
  service: YOURSERVICE
  command: cc-test-reporter before-build
```

After your final test commands:

```bash
- name: codeclimate_post
  service: YOURSERVICE
  command: cc-test-reporter after-build --exit-code $
```

### Parallel Test Coverage

Code Climate supports parallel test reports, as a new beta feature, by uploading the partial result to an external service, such as S3. In addition to the pre-test and post-test commands up, to use Code Climate with parallel reporting you will need to add another command after your individual tests, and after all tests have completed, in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

Here are [Code Climate's example](https://github.com/codeclimate/test-reporter#low-level-usage) scripts for doing so.

After each parallel test command you'll run a new script:

``````
- type: parallel
  steps:
    - service: YOURSERVICE
      command: tests1.sh
    - service: YOURSERVICE
      command: tests2.sh
```

Note that we're using script files to run our tests, so that we can execute the tests and export the coverage report as one command. This is because each step uses a new container, so the coverage report will not persist if the commands are separated. Inside the new `tests.sh` files, you will have:

```bash
# your test commands go here

./cc-test-reporter format-coverage --output "coverage/codeclimate.$N.json"
aws s3 sync coverage/ "s3://my-bucket/coverage/$CI_COMMIT_ID"
```

Note that you will need to modify the S3 path (or provide an alternative storage path), as well as set the `$N` value value by manually declaring separate pipeline IDs.

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

Note that you will need to manually `$PARTS` to reflect the number of parallel threads.

### Successful build, even though tests failed

Because of a bug with version 0.8.x of simplecov, tests are reported as successful, even though they actually failed. This is caused by simplecov overriding the exit code of the test framework.

According the the [issue report on GitHub](https://github.com/colszowka/simplecov/issues/281) this won't be fixed in the 0.8 release. Please either use versions prior to 0.8 or higher than 0.9.
