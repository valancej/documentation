---
title: Continuous Delivery to AWS with Docker
shortTitle: Deploying To AWS
menus:
  pro/cd:
    title: AWS
    weight: 1
tags:
  - deployment
  - aws
  - docker
  - amazon
  - ecr
  - ecs

redirect_from:
  - /docker-integration/aws/
---

<div class="info-block">
You can find a sample repo for deploying to AWS with Codeship Pro on Github [here](https://github.com/codeship-library/aws-utilities).
</div>

* include a table of contents
{:toc}

To make it easy for you to deploy your application to AWS we've built a container that has the AWSCLI installed. We will set up a simple example showing you how to configure any deployment to AWS.

## Codeship AWS deployment container

The AWS deployment container lets you plugin your deployment tools without the need to include that in the testing or even production container. That keeps your containers small and focused on the specific task they need to accomplish in the build. By using the AWS deployment container you get the tools you need to deploy to any AWS service and still have the flexibility to adapt it to your needs.

The container configuration is open source and can be found in the [codeship-library/aws-deployment](https://github.com/codeship-library/aws-deployment) project on GitHub. It includes a working example that uses the AWSCLI as part of an integration test before we push a new container to the Docker Hub.

We will use the `codeship/aws-deployment` container throughout the documentation to interact with various AWS services.

### Using other tools

While the container we provide for interacting with AWS gives you an easy and straight forward way to run your deployments it is not the only way you can interact with AWS services. You can install your own dependencies, write your own deployment scripts, talk to the AWS API directly or bring 3rd party tools to do it for you. By installing those tools into a Docker container and running them you have a lot of flexibility in how to deploy to AWS.

## Authentication

Before setting up the `codeship-services.yml` and `codeship-steps.yml` file we're going to create an encrypted environment file that contains the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

Take a look at our [encrypted environment files documentation]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) and add a `aws-deployment.env.encrypted` file to your repository. The file needs to contain an encrypted version of the following file:

```bash
AWS_ACCESS_KEY_ID=your_access_key_id
AWS_SECRET_ACCESS_KEY=your_secret_access_key
```

You can get the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` from the IAM settings in your [AWS Console](https://console.aws.amazon.com/console/home). Do not use the admin keys provided to your main AWS account and make sure to limit the access to what is necessary for your deployment through IAM.

It is advised that you review AWS' [IAM documentation](http://docs.aws.amazon.com/IAM/latest/UserGuide/introduction_access-management.html) to find the correct policies for your account.

## Service Definition

Before reading through the documentation please take a look at the [Services]({% link _pro/builds-and-configuration/services.md %}) and [Steps]({% link _pro/builds-and-configuration/steps.md %}) documentation page so you have a good understanding how services and steps on Codeship work.

The `codeship-services.yml` file uses the `codeship/aws-deployment` container and sets the encrypted environment file. Additionally it sets the `AWS_DEFAULT_REGION` through the environment config setting. We set up a volume that shares `./` (the repository folder) to `/deploy`. This gives us access to all files in the repository in `/deploy/...` for the following steps.

```yaml
awsdeployment:
  image: codeship/aws-deployment
  encrypted_env_file: aws-deployment.env.encrypted
  environment:
    - AWS_DEFAULT_REGION=us-east-1
  volumes:
    - ./:/deploy
```

## Deployment Examples

Once you have used the above instructions to set up your AWS deployment service and authenticate with AWS, we provide specific documentation for deploying to the most popular AWS services.

- [S3]({% link _pro/continuous-deployment/aws-s3.md %})
- [Elastic Beanstalk]({% link _pro/continuous-deployment/aws-elasticbeanstalk.md %})
- [Elastic Container Service]({% link _pro/continuous-deployment/aws-ecs.md %})
- [Elastic Container Registry]({% link _pro/builds-and-configuration/image-registries.md %}#aws-ecr)
- [CodeDeploy]({% link _pro/continuous-deployment/aws-codedeploy.md %})

### Combining Various AWS Services In A Script

If you want to interact with multiple AWS services simultaneously, in a more complex deployment or orchestration chain, you can set up a deployment script to be called from your AWS deployment service.

Below is one example, which will upload files into S3 buckets and then trigger a redeployment on ECS. In the following example we're putting the script into `scripts/aws_deployment`.

```bash
#!/bin/bash

# Fail the build on any failed command
set -e

aws s3 sync /deploy/assets s3://my_assets_bucket
aws s3 sync /deploy/downloadable_resources s3://my_resources_bucket

# Register a new version of the task defined in tasks/backend.json and update
# the currently running instances
aws ecs register-task-definition --cli-input-json file:///deploy/tasks/backend.json
aws ecs update-service --service my-backend-service --task-definition backend

# Register a task to process a Queue
aws ecs register-task-definition --cli-input-json file:///deploy/tasks/process_queue.json
aws ecs run-task --cluster default --task-definition process_queue --count 5
```

And the corresponding `codeship-steps.yml`:

```yaml
- service: awsdeployment
  command: /deploy/scripts/aws_deployment
```

## See Also

+ [Latest `awscli` documentation](http://docs.aws.amazon.com/cli/latest/reference/)
+ [Latest Elastic Beanstalk documentation](http://docs.aws.amazon.com/Elastic Beanstalk/latest/dg/Welcome.html)
