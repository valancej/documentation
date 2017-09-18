---
title: Continuous Delivery with Terraform
shortTitle: CD with Terraform
menus:
  pro/cd:
    title: Terraform
    weight: 9
tags:
  - deployment
  - hashicorp
  - terraform
  - infrastructure
---

* include a table of contents
{:toc}

## Managing Infrastructure with Terraform and Codeship Pro

### Remote State and Locking

Since Terraform relies on a (or multiple) statefile(s) to map real world resources to your configuration and Codeship Pro build machines are ephemeral it is important to have [remote state](https://www.terraform.io/docs/state/remote.html) configured and working.

Otherwise you will end up recreating your infrastructure on each build run.

Similarly, if you are on a plan that allows you to run multiple builds concurrently, you want to use a Terraform backend that supports [state locking](https://www.terraform.io/docs/state/locking.html) to make sure concurrent runs don't result in corrupted state.

### Services Configuration

Hashicorp publishes up to date [Docker images for Terraform](https://hub.docker.com/r/hashicorp/terraform/) on Docker Hub. In most use cases it is easiest to start with those and mount your Terraform configuration via a volume.

```
version: 2
services:
  terraform:
    image: hashicorp/terraform:0.10.5
    volumes:
      - ./:/app
    encrypted_env_file: secrets.env.encrypted
```

This services file makes use of [encrypted environment variables]() to pass configuration values and secrets to Terraform. This way you don't have to store the credentials for any providers used in your configuration as plain text values in your repository. See the Terraform documentation article on [environment variables](https://www.terraform.io/docs/configuration/environment-variables.html) for additional information as well as which variables are available and how to use them.

A sample (unencrypted) version of the `secrets.env` file including credentials for AWS could, for example, look like the following snippet.

```
# AWS Credentials
TF_VAR_aws_access_key_id=YOUR_AWS_ACCESS_KEY
TF_VAR_aws_secret_access_key=YOUR_AWS_SECRET_ACCESS_KEY
```

### Steps Configuration

Once you have your Terraform service configured it's time to run the actual steps to plan and change your infrastructure. A sample `codeship-steps.yml` file initializing Terraform, linting your configuration and then planning require changes could look like the following snippet.

```
- name: version
  service: terraform
  command: version
- name: init
  service: terraform
  command: init --input=false
- name: validate
  service: terraform
  command: validate
- name: plan
  service: terraform
  command: plan --input=false --out=/app/codeship.tfplan
```

Most of the commands are very straightforward and the Terraform [documentation page on the CLI commands](https://www.terraform.io/docs/commands/index.html) does a good job at explaining the various available options.

Of note are the `--input=false` flag, which tells Terraform to not ask for user input and instead exit with an error code if any input is required.

The second option worth mentioning is the `--out` flag on the `plan` command. `plan` is used to create an execution plan, comparing the current state of your infrastructure with how it is defined in your configuration and determining any required changes. The `--out` flag allows you to save this execution plan to a file, which can be used in a later step to apply those changes. This is an important feature, as this makes sure that only those changes are applied later on and allows you to validate changes manually (e.g. a feature branch will print the planned changes, but not apply them).

### Applying Changes to your Infrastructure

Once you're happy with your setup and want to actually apply changes to infrastructure you can extend your `codeship-steps.yml` file to run `terraform apply` as part of your build.


```
# ...
- name: apply
  tag: master
  service: terraform
  command: apply --input=false /app/codeship.tfplan
```

This step uses the `tag` directive to limit execution to the `master` branch only. It further tells Terraform to use the execution plan created in the previous `plan` step and saved to the `/app/codeship.tfplan` file.

### Further information

Terraform includes an advanced guide on [running Terraform in automation](https://www.terraform.io/guides/running-terraform-in-automation.html) which provides additional information on this subject as well as advanced features not covered in this article.
