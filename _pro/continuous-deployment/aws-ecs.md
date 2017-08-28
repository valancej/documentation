---
title: Continuous Delivery to AWS ECS with Docker
shortTitle: Deploying To AWS ECS
menus:
  pro/cd:
    title: AWS ECS
    weight: 4
tags:
  - deployment
  - aws
  - docker
  - amazon
  - ecr
  - ecs
  - elastic container service

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

### Pushing To ECR

Next, you may want to push your images to the AWS Elastic Container Registry.

To do so, you will need to reference the `dockercfg_generator` service from the above example using the `dockercfg_service` option in a [push step]({{ site.baseurl }}{% link _pro/builds-and-configuration/image-registries.md %}) to ECR in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) to generate the AWS authentication token GCR requires, as shown below.

You can read more in-depth instructions for pushing to an image registry, including ECR, on our [image registries documentation]({{ site.baseurl }}{% link _pro/builds-and-configuration/image-registries.md %}#aws-ecr).

```yaml
- name: ECR Push
  service: app
  type: push
  image_name: ecr-region-url/your-image
  registry: ecr-region-url
  dockercfg_service: dockercfg_generator
```

**Note** that `ecr-region-url` above shoudl be replaced with your region-specific ECR url.

## Deploying To AWS Elastic Container Service

To interact with ECS, you will simply use the corresponding AWS CLI commands via the `awsdeployment` service defined in your [codeship-services.yml file]({% link _pro/builds-and-configuration/steps.md %}).

You will pass this service commands via the [codeship-steps.yml file]({% link _pro/builds-and-configuration/steps.md %}), as seen in the example deployment below.

If you have more complex workflows for deploying your ECS tasks you can put those commands into a script and run the script as part of your workflow.

```yaml
- service: awsdeployment
  command: aws ecs register-task-definition --cli-input-json file:///deploy/tasks/backend.json
- service: awsdeployment
  command: aws ecs update-service --service my-backend-service --task-definition backend
- service: awsdeployment
  command: aws ecs register-task-definition --cli-input-json file:///deploy/tasks/process_queue.json
- service: awsdeployment
  command: aws ecs run-task --cluster default --task-definition process_queue --count 5
```
Note that we're using the task definitions from the [AWSCLI ECS docs](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_AWSCLI.html#AWSCLI_run_task)

Also note that the `awsdeployment` service is discussed in more detail in our [AWS documentation]({% link _pro/continuous-deployment/aws.md %}), and that all ECS-related commands will work the same way in lieu of the above example.
