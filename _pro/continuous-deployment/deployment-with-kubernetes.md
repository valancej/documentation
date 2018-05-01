---
title: Continuous Deployment With Kubernetes
shortTitle: Deploying With Kubernetes
menus:
  pro/cd:
    title: Kubernetes
    weight: 13
categories:
  - Continuous Deployment   
  - Deployment
  - Kubernetes     
tags:
  - kubernetes
  - notifications
  - deployment
  - k8s
  - k8
  - google
  - google cloud

redirect_from:
  - /general/account/guides/deployment-with-kubernetes/
---

* include a table of contents
{:toc}


## Integrating Codeship with Kubernetes

To use Kubernetes with Codeship Pro, you will need to define a deployment container in your [codeship-services.yml file]({% link _pro/builds-and-configuration/services.md %}) with the `kubectl` tool installed.

You can then use that service to run any `kubectl` commands you need via your [codeship-steps.yml file]({% link _pro/builds-and-configuration/steps.md %}), as well as to authenticate with your production service.

Since many Kubernetes users are using a managed platform, such as Google, AWS or Azure we also have deployment containers pre-built to simplify this process.

### Services

Inside your [codeship-services.yml file]({% link _pro/builds-and-configuration/services.md %}), you will need to define a new service with the `kubectl` tool installed. For example:

```yaml
app:
  build: ./
  links:
    - postgres
  environment:
    user: admin
  cached: true
```

This service will need a Dockerfile, or an existing base image, that installs the tool and authenticates you either via [environment variables]({% link _pro/builds-and-configuration/environment-variables.md %}) or via hardcoded login credentials. The Dockerfile would look something like this, as a simple example:

```bash
FROM alpine:3.6

# Install kubectl
# Note: Latest version may be found on:
# https://aur.archlinux.org/packages/kubectl-bin/
ADD https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubectl /usr/local/bin/kubectl

USER kubectl

ENTRYPOINT ["/usr/local/bin/kubectl"]
```

### Steps

Once you have your service defined, you will use your [codeship-steps.yml file]({% link _pro/builds-and-configuration/steps.md %}) to run the necessary `kubectl` commands. In this case, we will put those commands into a new script file named `kubernetes.sh`:

```yaml
- name: deploy
  service: app
  command: kubernetes.sh
```

Inside this script file can be any `kubectl` commands you would like, for instance invoking a new Kubernetes deployment from a configuration file:

```bash
kubectl apply -f ./deployment.yaml
```

Essentially, now that you have a container with the `kubectl` tool, you will script your deployments in any way you'd like to use that command line tool in the workflow you define.

### Managed Services

For managed services, we have prebuilt deployment containers to simplify then authentication and deployment process and to make use of each provider's individual CLI.

- [AWS](https://github.com/codeship-library/aws-utilities)
- [Azure](https://github.com/codeship-library/azure-utilities)
- [IBM Bluemix](https://github.com/codeship-library/ibm-bluemix-utilities)
- [Google](https://github.com/codeship/codeship-kubernetes-demo)
