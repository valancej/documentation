---
title: Using Runscope and Codeship For API testing
shortTitle: Runscope API Testing And Monitoring
menus:
  general/integrations:
    title: Using Runscope
    weight: 21
tags:
- apis
- api testing
- service testing
- integration testing
- functional testing
- smoke testing
- integrations
- reporting
- monitoring
- notifications
categories:
  - Integrations
---

* include a table of contents
{:toc}

## About Runscope

[Runscope](https://runscope.com) is an API testing and monitoring tool that can be used with continuous integration and delivery services like [Codeship](https://codeship.com) to test and validate your web applications.

By using Runscope you can ship more reliable code for your teams and your customers.

The [Runscope documentation](https://www.runscope.com/docs/api-testing/integrations) provides a great guide to getting started, and the instructions below have more information on integrating with Codeship.

## Codeship Pro

### Setting Your Access Token

To run your Runscope API tests on Codeship, you will need to add your Runscope Access Token to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

You can get your access token from your [Runscope settings](https://www.runscope.com/docs/api/authentication).

### Installing Runscope Dependencies And Script

After setting your personal access token, you will need to build a service in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) with the Runscope dependencies installed.

Runscope distributes these dependencies through pip, so you will need to be sure your service also has Python and Pip installed.

To install the dependencies you need, you can add the following to your Service's Dockerfile:

```bash
RUN pip install -r https://raw.githubusercontent.com/Runscope/python-trigger-sample/master/requirements.txt
```

Once you have the dependencies installed, you can add another line to your Service's Dockerfile to install the Runscope script itself:


```bash
RUN wget https://raw.githubusercontent.com/Runscope/python-trigger-sample/master/app.py
```

Note again that your service must be able to use wget for the above command to execute.

### Triggering Runscope During A Build

To run the Runscope script and execute your tests during your build, you can use the Runscope script you installed via your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) in a step called via your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):

```yaml
- name: Runscope
  service: app
  command: runscope.sh
```

Inside of the `runscope.sh` file, you can call the Runscope script with the following command:

```shell
python app.py https://api.runscope.com/radar/your_test_trigger_id/trigger?runscope_environment=your_runscope_environment_id
```

**Note** that you will need to change the URL to reflect the actual Trigger URL you have configured in Runscope.

## Codeship Basic

### Setting Your Access Token

To run your Runscope API tests on Codeship, you will need to add your Runscope Access Token to your Codeship project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}):

You can get your access token from your [Runscope settings](https://www.runscope.com/docs/api/authentication).

### Installing Runscope Dependencies And Script

After setting your personal access token, you will need to install the Runscope dependencies and the Runscope script in your project's [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

In your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}), add the following:

```bash
pip install -r https://raw.githubusercontent.com/Runscope/python-trigger-sample/master/requirements.txt
```

and

```bash
wget https://raw.githubusercontent.com/Runscope/python-trigger-sample/master/app.py
```

### Triggering Runscope During A Build

To run the Runscope script and execute your tests during your build, you can use the Runscope script you installed in your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}) by calling the script in your project's [test or deployment commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

Inside of your [test or deployment commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}), simply add the following:

```bash
python app.py https://api.runscope.com/radar/your_test_trigger_id/trigger?runscope_environment=your_runscope_environment_id
```

**Note** that you will need to change the URL to reflect the actual Trigger URL you have configured in Runscope.
