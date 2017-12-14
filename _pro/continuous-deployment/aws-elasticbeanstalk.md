---
title: Continuous Delivery to AWS Elastic Beanstalk with Docker
shortTitle: Deploying To AWS Elastic Beanstalk
menus:
  pro/cd:
    title: AWS EB
    weight: 3
categories:
  - Continuous Deployment        
tags:
  - deployment
  - aws
  - docker
  - amazon
  - elastic beanstalk

---

<div class="info-block">
You can find a sample repo for deploying to AWS with Codeship Pro on Github [here](https://github.com/codeship-library/aws-utilities).
</div>

* include a table of contents
{:toc}

To make it easy for you to deploy your application to AWS Elastic Beanstalk, we've built a container that has the AWSCLI installed. We will set up a simple example showing you how to configure any deployment to AWS Elastic Beanstalk.

## Codeship AWS Deployment Container

Codeship Pro uses an AWS deployment container that we maintain to authenticate with your AWS account.

Please review our [AWS documentation]({% link _pro/continuous-deployment/aws.md %}) to learn how to set up and use this authentication container.

You will need the AWS service, as well as your application itself, defined via your [codeship-services.yml file]({% link _pro/builds-and-configuration/services.md %}) so that you can execute the necessary S3 commands in your [codeship-steps.yml file]({% link _pro/builds-and-configuration/steps.md %}).

It is also advised that you review AWS' [IAM documentation](http://docs.aws.amazon.com/IAM/latest/UserGuide/introduction_access-management.html) to find the correct policies for your account.

## Deploying to AWS Elastic Beanstalk

Deployment to Elastic Beanstalk uses a `codeship_aws eb_deploy` command in the `codeship/aws-deployment` container that we've defined, so that you can get started quickly.

The arguments you have to set are:

- The path to your deployable folder
- The Elastic Beanstalk application name
- The Elastic Beanstalk environment name
- The S3 bucket to which to upload the zipped artifact.

Add the following into your [codeship-steps.yml file]({% link _pro/builds-and-configuration/steps.md %}):

```yaml
- service: awsdeployment
  command: codeship_aws eb_deploy PATH_TO_FOLDER_TO_DEPLOY APPLICATION_NAME ENVIRONMENT_NAME S3_BUCKET_NAME
```

This command will zip up the content in the folder, upload it to S3, register a new version with Elastic Beanstalk and then deploy that new version. We're also validating that the environment is fine and that the new version was correctly deployed.

Note that the `awsdeployment` and the data from the volume are both discussed in more detail in our [AWS documentation]({% link _pro/continuous-deployment/aws.md %}), and that all EB-related commands will work the same way in lieu of the above example.

### Customizing The Deployment Script

If you want to customize the deployment you can also use the [existing script](https://github.com/codeship-library/aws-utilities/blob/master/deployment/scripts/codeship_aws_eb_deploy) from our open source AWS container and edit it so it fits exactly to your needs.

This script can be added to your repository and then called directly via your [codeship-steps.yml file]({% link _pro/builds-and-configuration/steps.md %}), as in the following example:

```yaml
- service: awsdeployment
  command: /deploy/scripts/deploy_to_eb
```

#### Elastic Beanstalk Permissions Policy

Please replace `[region]` and `[accountid]` with the respective values for your AWS account / Elastic Beanstalk application.

```json
{
  "Statement": [
    {
      "Action": [
        "elasticbeanstalk:CreateApplicationVersion",
        "elasticbeanstalk:DescribeEnvironments",
        "elasticbeanstalk:DeleteApplicationVersion",
        "elasticbeanstalk:UpdateEnvironment"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "sns:CreateTopic",
        "sns:GetTopicAttributes",
        "sns:ListSubscriptionsByTopic",
        "sns:Subscribe"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:sns:[region]:[accountid]:*"
    },
    {
      "Action": [
        "autoscaling:SuspendProcesses",
        "autoscaling:DescribeScalingActivities",
        "autoscaling:ResumeProcesses",
        "autoscaling:DescribeAutoScalingGroups"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "cloudformation:GetTemplate",
        "cloudformation:DescribeStackResource",
        "cloudformation:UpdateStack"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:cloudformation:[region]:[accountid]:*"
    },
    {
      "Action": [
        "ec2:DescribeImages",
        "ec2:DescribeKeyPairs"
      ],
      "Effect": "Allow",
      "Resource": "*"
   },
   {
    "Action": [
     "s3:PutObject",
     "s3:PutObjectAcl",
     "s3:GetObject",
     "s3:GetObjectAcl",
     "s3:ListBucket",
     "s3:DeleteObject",
     "s3:GetBucketPolicy"
   ],
   "Effect": "Allow",
   "Resource": [
    "arn:aws:s3:::Elastic Beanstalk-[region]-[accountid]",
    "arn:aws:s3:::Elastic Beanstalk-[region]-[accountid]/*"
   ]
  }
 ]
}
```

If you are using more than one instance for your application you need to add at least the following permissions as well.

```json
{
  "Action": [
    "elasticloadbalancing:DescribeInstanceHealth",
    "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
    "elasticloadbalancing:RegisterInstancesWithLoadBalancer"
  ],
  "Effect": "Allow",
  "Resource": "*"
}
```
