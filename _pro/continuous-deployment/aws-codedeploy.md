---
title: Continuous Delivery to AWS CodeDeploy with Docker
shortTitle: Deploying To AWS CodeDeploy
menus:
  pro/cd:
    title: AWS CodeDeploy
    weight: 5
tags:
  - deployment
  - aws
  - docker
  - amazon
  - codedeploy
  - code deploy

---

<div class="info-block">
You can find a sample repo for deploying to AWS with Codeship Pro on Github [here](https://github.com/codeship-library/aws-utilities).
</div>

* include a table of contents
{:toc}

To make it easy for you to deploy your application to AWS ECS, we've built a container that has the AWSCLI installed. We will set up a simple example showing you how to configure any deployment to AWS ECS.

## Codeship AWS Deployment Container

Codeship Pro uses an AWS deployment container that we maintain to authenticate with your AWS account.

Please review our [AWS documentation]({% link _pro/continuous-deployment/aws.md %}) to learn how to set up and use this authentication container.

You will need the AWS service, as well as your application itself, defined via your [codeship-services.yml file]({% link _pro/builds-and-configuration/services.md %}) so that you can execute the necessary S3 commands in your [codeship-steps.yml file]({% link _pro/builds-and-configuration/steps.md %}).

It is also advised that you review AWS' [IAM documentation](http://docs.aws.amazon.com/IAM/latest/UserGuide/introduction_access-management.html) to find the correct policies for your account.

## Deploying to CodeDeploy

Deployment to Elastic Beanstalk uses a `codeship_aws codedeploy_deploy` command in the `codeship/aws-deployment` container that we've defined, so that you can get started quickly.

Add the following into your [codeship-steps.yml file]({% link _pro/builds-and-configuration/steps.md %}):

```yaml
- service: awsdeployment
  command: codeship_aws codedeploy_deploy /PATH/TO/YOUR/CODE APPLICATION_NAME DEPLOYMENT_GROUP_NAME S3_BUCKET_NAME
```

This command will zip your application code, upload it to S3 and start a new deployment on CodeDeploy. You can take a look at the [full script](https://github.com/codeship-library/aws-deployment/blob/master/scripts/codeship_aws_codedeploy_deploy) if you would like to review or modify it.

Note that you will need to make sure that the IAM User used with Codeship has all necessary permissions to interact with CodeDeploy. Take a look at the [getting started](http://docs.aws.amazon.com/codedeploy/latest/userguide/getting-started-setup.html) documentation from AWS to get the full policy template.
