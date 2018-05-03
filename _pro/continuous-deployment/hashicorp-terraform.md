---
title: Continuous Delivery with Terraform
shortTitle: CD with Terraform
menus:
  pro/cd:
    title: Terraform
    weight: 13
categories:
  - Deployment  
tags:
  - deployment
  - hashicorp
  - terraform
  - infrastructure
---

* include a table of contents
{:toc}

## Managing Infrastructure with Terraform and Codeship Pro

Using Terraform to manage your infrastructure via Codeship Pro is as simple as setting up a service with the Terraform CLI and passing that service the commands you need. Below you will find detailed setup instructions including example configurations.

It is recommended that you be familiar with Codeship Pro and Docker basics before proceeding. If you are unfamiliar with either, you can reference our [Codeship Pro Getting Started Guide]({{ site.baseurl }}{% link _pro/quickstart/getting-started.md %}) and the [Docker 101]({{ site.baseurl }}{% link _pro/quickstart/docker-101.md %}) article for more information first.

### Services Setup

To integrate Terraform with your Codeship Pro CI/CD pipeline, you will want to add a new service definition to your [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) file.

This service can use any container you define or pull that contains the Terraform CLI, but we recommend using the [official Terraform Docker image](https://hub.docker.com/r/hashicorp/terraform/) that Hashicorp publishes on Docker Hub and keeps updated with the latest releases.

In this example, we'll use the official image as a base image for our custom Docker image using the `Dockerfile` below:

```dockerfile
FROM hashicorp/terraform:0.10.5
LABEL maintainer="Your Name, you@org.com"

RUN mkdir -p /terraform
WORKDIR /terraform

COPY . ./
```

Note here that we are creating a working directory and switching to that directory, via the `WORKDIR` directive. This will allow us to simplify our configuration a bit and avoid some pitfalls later on.

Next, we'll make use of the above `Dockerfile` in a service definition, via our [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) file. The below example covers just the Terraform service, but your [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) file can have any other required services defined as well.

```yaml
version: '2'
services:
  terraform:
    build:
      dockerfile: Dockerfile
    volumes:
      - ./:/terraform
    encrypted_env_file: secrets.env.encrypted
```

### Configuration Via Environment Variables

Note that in the above [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) example we are using [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) to pass configuration values and secrets to Terraform to avoid storing any configuration in plain text. See the [Terraform documentation article on environment variables](https://www.terraform.io/docs/configuration/environment-variables.html) for more information on the available values and configurations.

In this case, the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) will contain at least the following values:

- **TF_VAR_aws_access_key_id** = YOUR_AWS_ACCESS_KEY
- **TF_VAR_aws_secret_access_key** = YOUR_AWS_SECRET_ACCESS_KEY

Depending on your exact Terraform configuration you will need additional environment variables, either for configuring various Terraform providers as well as configuring Terraform (remote state) itself.

### Steps Configuration

Once you have your Terraform service configured, you will use this service to run the Terraform commands you need via your [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) file.

The below example of a [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) file will initialize Terraform, lint your configuration and then plan the required changes to bring your infrastructure in line with the specified Terraform configuration. It will however not apply those changes (yet).

```yaml
- name: version
  service: terraform
  command: version
- name: init
  service: terraform
  command: init --input=false ./
- name: validate
  service: terraform
  command: validate ./
- name: plan
  service: terraform
  command: plan --input=false --out=./codeship.tfplan
```

As you can see, once our service is defined we can run any Terraform commands we need to just as you would do locally using the CLI. [See the Terraform documentation page on the CLI commands](https://www.terraform.io/docs/commands/index.html) for a full list of available Terraform commands and options.

### --Input And --Out Flags

In the above example, it is important to note the `--input=false` flag. This instructs Terraform not to ask for any user input, and to instead exit with an error code if input is required. This is important to avoid having your builds hang indefinitely if input is requested.

Also note the `--out` flag on the `plan` command. The `plan` command is used to create an execution plan, which compares the current state of your infrastructure to your defined configuration so that it can determine required changes.

The `--out` flag instructs Terraform to save this execution plan to a file that can be used in a later step to actually apply those changes. This is important, as it guarantees that _only those changes_ are applied. This also lets you validate changes manually (e.g. a feature branch will print the planned changes, but not apply them).

### Automate Changes Via Apply Command

To configure the actual application of infrastructure changes in your CI/CD pipeline, we will add a new step to our [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) file example:


```yaml
# append this to the end of your codeship-steps.yml file
- name: apply
  tag: master
  service: terraform
  command: apply --input=false ./codeship.tfplan
```

The `apply` command instructs Terraform to apply the prepared changes to your infrastructure.

To avoid this happening when you don't intend, in this example we are using the [tag directive]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}#limiting-steps-to-specific-branches-or-tags)  in the `codeship-steps.yml` file to limit the step to only run on a certain branch - in this case the `master` branch.

This example further configures Terraform to use the execution plan created and saved to `/app/codeship.tfplan`, as instructed via the `--out` command in the section above.

### Remote State and Locking

Since Terraform relies on one or more statefiles to map real world resources to your configuration, to use Terraform with Codeship Pro it is important to have [remote state](https://www.terraform.io/docs/state/remote.html) configured and working. This is because Codeship Pro build machines are ephemeral and do not share any state or data in between builds. Otherwise, you might end up recreating your infrastructure on each build run.

Additionally, because Codeship Pro often runs concurrent builds, you may want to use a Terraform backend that supports [state locking](https://www.terraform.io/docs/state/locking.html) to make sure that these concurrent runs don't result in corrupted infrastructure state.

## Further information

Terraform includes an advanced guide on [running Terraform in automation](https://www.terraform.io/guides/running-terraform-in-automation.html) which provides additional information on this subject as well as advanced features not covered in this article.
