---
title: Deployment With AWS CLI
menus:
  basic/cd:
    title: AWS CLI
    weight: 8
tags:
  - deployment
  - aws
  - cli
  - amazon
categories:
  - Continuous Deployment    
redirect_from:
  - /continuous-deployment/deployment-with-awscli/
---

* include a table of contents
{:toc}

## AWS Deployments

Codeship Basic offers a variety of turnkey deployment integrations for AWS, including:

- [CodeDeploy]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-to-aws-codedeploy.md %})
- [Lambda]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-to-aws-lambda.md %})
- [Elastic Beanstalk]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-to-elastic-beanstalk.md %})
- [S3]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-to-aws-s3.md %})

These are the simplest ways to deploy to AWS via Codeship Basic.

## Using The CLI

If the deployment integrations do not work for you due to additional need for flexibility or need to use an undocumented AWS service, you can always install and use the AWS CLI directly onto a Codeship Basic build machine similar to how you might use the CLI locally.

You will need to install the CLI, configure your authentication via environment variables and then define the CLI commands you want to run as a [custom-script deployment pipeline]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}).

### Installing The CLI

The [AWS CLI](https://aws.amazon.com/cli) _does not_ come pre-installed on Codeship Basic build machines.

Please add the following command in the [Setup Commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}#configuring-your-setup-commands) section of your test settings to install the AWS CLI:

```shell
pip install awscli
```

### Configuring Authentication

Once the CLI is installed, you will need to run the appropriate AWS login commands in your project's [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}#configuring-your-setup-commands) or at the start of your [custom-script deployment pipeline]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}).

The easiest way to keep the authentication secure is to use [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}) to store the username and password, and to pass those to your AWS login commands.

### Deployment Scripting

You will need to create a new [custom-script deployment pipeline]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}) to run the AWS CLI commands you need for your deployment.

These commands will be run every time the branch the deployment pipeline is associated with is updated. They are not Codeship specific and will be standard AWS CLI input.

## AWS CLI Information

Read more about the [AWS CLI](https://aws.amazon.com/cli) for more information on using the CLI as well as complete documentation on what commands can be run with it.
