---
title: Using RedLine13 and Codeship For Load testing
shortTitle: RedLine13 Load Testing
menus:
  general/integrations:
    title: Using RedLine13
    weight: 14
tags:
- apis
- api testing
- jmeter
- gatling
- load testing
- performance testing
- integrations
- reporting
categories:
  - Integrations
---

* include a table of contents
{:toc}

## About RedLine13

[RedLine13](https://www.redline13.com) is a (Almost Free) load testing and reporting tool that can be used with continuous integration and delivery services like [Codeship](https://codeship.com) to determine performance and throughput of your web applications and mobile apis.

By using RedLine13 you can ship more performant code for your teams and your customers.

The [RedLine13 documentation](https://www.redline13.com/blog/kb/) provides a starting point for running load tests, and the instructions below have more information on integrating with [Codeship](https://codeship.com) to [run load tests during CI](#starting-load-tests).

## Codeship Pro

### Setting your API token

To run your RedLine13 load tests on Codeship, you will need to add your API Key to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

- `REDLINE13_API_KEY`

You can get the API Key from your RedLine13 account after [registering for a RedLine13 account](https://www.redline13.com/Account/apikey).  

### Other Settings

The test runner provides for multiple configuration items which can be managed via environment variables. These variables can also be passed along as encrypted or stored in your codeship-services.yml file

- `TIMEOUT` # of seconds before test consider failure, default 900s
- `SUCCESS_RATE` % of test cases that must pass for success, default 0 - always pass
- `RESPONSE_TIME` response time must be less than this for success, default 10000ms

### Starting load tests

The simplest way is to include the redline13 service in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) file.
 - The volumes is set to pull your repo into /test on the docker container.  This simplifies finding required files such as a [Apache JMeter](http://jmeter.apache.org/) or [Gatling](https://github.com/gatling/gatling) test file.

```yaml
redline13:
  image: redline13/codeship:latest
  volumes:
    - ./:/test
  environment:
    TIMEOUT: 900
    SUCCESS_RATE: 80
    RESPONSE_TIME: 5000
  encrypted_env_file: env.encrypted
```

Using the service above you only need to include the curl command in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) to instruct the service to execute the load test, wait for test to complete, and check results.
```yaml
- name: run_my_load_test
  service: redline13
  command: >
    curl -s https://www.redline13.com/Api/LoadTest
    -H \"X-Redline-Auth: ${REDLINE_API_KEY}\"
    -F testType=jmeter-test
    -F name=\"CodeShipAndRedLine13\"
    -F version=3.1
    -F jvm_args=
    -F opts=
    -F numServers=2
    -F \"file=@/test/tests/Plexify.jmx\"
    -F storeOutput=true
    -F servers[0][location]=us-east-1
    -F servers[0][size]=m3.medium
    -F servers[0][num]=2
    -F servers[0][associatePublicIpAddress]=false
    -F servers[0][securityGroupIds]=
    -F servers[0][subnetId]=
    -F servers[0][onDemand]=true
    -F servers[0][volumeSize]=
    -F servers[0][usersPerServer]=1
```

The codeship-services.yml and codeship-steps.yml above will run an Apache JMeter test from our repo on 2 servers, wait for up to 15 minutes for test to complete, and ensure that  80% of tests are success and response time is less than 5 seconds.

To customize the API call via Curl you can read the [RedLine13 API documentation](https://www.redline13.com/ApiDoc) or export an existing load test.

When your build runs, your test will be started and RedLine13 will be tracking the results.  You can always see real time results on the [RedLine13 Dashboard](https://www.redline13.com/Service).

## Codeship Basic

### Setting your API token

To run your RedLine13 load tests on Codeship Basic, you will need to add your API Key to your Codeship project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %})

- `REDLINE13_API_KEY`

You can get the API Key from your RedLine13 account after [registering for a RedLine13 account](https://www.redline13.com/Account/apikey).  

### Other Settings

The test runner provides for multiple configuration items which can be managed via environment variables. These variables can also be configured in your Codeship project's environment variables.

- `TIMEOUT` # of seconds before test consider failure, default 900s
- `SUCCESS_RATE` % of test cases that must pass for success, default 0 - always pass
- `RESPONSE_TIME` response time must be less than this for success, default 10000ms

### Adding Setup Commands

After adding the API Key and other settings, you'll just need to add Setup and Test commands.

Add the following to your [project's setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}/#configuring-your-setup-commands) to install a script for executing tests on RedLine13 and checking results. The command to add is:

```bash
## Download script
curl -sSL https://raw.githubusercontent.com/redline13/codeship-redline13/master/codeship-basic.sh > codeship.sh

## Make it executable
chmod +x codeship.sh
```

### Adding Test Commands

Add the following to your [project's test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}/#configuring-your-test-commands) to run the load test.  The parameters here can be changed to execute any type of load test supported.  The command to add is:
```bash
## Execute Script and pass in CURL command to run test.
## Note the escaped quotes to properly pass in the command
./codeship.sh 'curl -s https://www.redline13.com/Api/LoadTest -H \"X-Redline-Auth: ${REDLINE_API_KEY}\" -F testType=jmeter-test -F name=CodeShipAndRedLine13 -F \"file=@`pwd`/tests/Plexify.jmx\" -F numServers=1 -F storeOutput=T -F servers[0][location]=us-east-1 -F servers[0][size]=m3.medium -F servers[0][num]=1 -F servers[0][onDemand]=T -F servers[0][usersPerServer]=1'
```

For a walk-through of setting up read this RedLine13 blog post: [Load Testing on Codeship with Redline13 – it just makes sense](https://www.redline13.com/blog/2018/02/codeship-integration/).
