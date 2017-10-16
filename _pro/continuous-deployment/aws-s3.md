---
title: Continuous Delivery to AWS S3 with Docker
shortTitle: Deploying To AWS S3
menus:
  pro/cd:
    title: AWS S3
    weight: 2
categories:
  - Continous Deployment        
tags:
  - deployment
  - aws
  - docker
  - amazon
  - s3

---

<div class="info-block">
You can find a sample repo for deploying to AWS with Codeship Pro on Github [here](https://github.com/codeship-library/aws-utilities).
</div>

* include a table of contents
{:toc}

To make it easy for you to deploy your application to AWS S3, we've built a container that has the AWSCLI installed. We will set up a simple example showing you how to configure any deployment to AWS S3.

## Codeship AWS Deployment Container

Codeship Pro uses an AWS deployment container that we maintain to authenticate with your AWS account.

Please review our [AWS documentation]({% link _pro/continuous-deployment/aws.md %}) to learn how to set up and use this authentication container.

You will need the AWS service, as well as your application itself, defined via your [codeship-services.yml file]({% link _pro/builds-and-configuration/services.md %}) so that you can execute the necessary S3 commands in your [codeship-steps.yml file]({% link _pro/builds-and-configuration/steps.md %}).

It is also advised that you review AWS' [IAM documentation](http://docs.aws.amazon.com/IAM/latest/UserGuide/introduction_access-management.html) to find the correct policies for your account.

## Deploying To S3

In the following example we're uploading a file to S3 from the source repository which we access through the host volume at `/deploy`.

Add the following into your [codeship-steps.yml file]({% link _pro/builds-and-configuration/steps.md %}):

```yaml
- service: awsdeployment
  command: aws s3 cp /deploy/FILE_TO_DEPLOY s3://SOME_BUCKET
```

Note that the `awsdeployment` and the data from the volume are both discussed in more detail in our [AWS documentation]({% link _pro/continuous-deployment/aws.md %}), and that all S3-related commands will work the same way in lieu of the above example.

### S3 Permissions Policy

To upload new application versions to the S3 bucket specified in the deployment configuration, we need at least _Put_ access to the bucket (or a the _appname_ prefix). See the following snippet for an example.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::[s3-bucket]/*"
            ]
        }
    ]
}
```
