---
title: Continuous Delivery to AWS EKS with Docker
shortTitle: Deploying To AWS EKS
menus:
  pro/cd:
    title: AWS EKS
    weight: 5
categories:
  - Deployment
  - AWS   
tags:
  - deployment
  - aws
  - docker
  - amazon
  - EKS
  - k8s
  - kubernetes
  - elastic container service

---

{% csnote info %}
You can find a [sample repo for deploying to any Kubernetes instance with CodeShip Pro](https://github.com/CodeShip-library/kubectl-connection-demo) on Github.
{% endcsnote %}

* include a table of contents
{:toc}

To make it easy for you to deploy your application to AWS EKS, which is a managed Kubernetes cluster service on AWS, we've built a container to make authenticating with a remote Kubernetes cluster and using the `kubectl` CLI easy.

Because AWS provides [setup guide](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html) and a [starter blog post](https://aws.amazon.com/blogs/opensource/eksctl-eks-cluster-one-command/), we won’t cover the AWS side of your setup here. But, you will need an AWS user with the right IAM permissions and an EKS cluster to be prepared on the AWS side.

## CodeShip Kubernetes Deployment Container

CodeShip Pro uses a Kubernetes deployment container that we maintain to authenticate with your remote Kubernetes cluster, including your EKS cluster.

Please review our [Kubernetes documentation]({% link _pro/continuous-deployment/deployment-with-kubernetes.md %}) to learn how to set up and use this authentication container.

It is also advised that you review AWS' [IAM documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction_access-management.html) to find the correct policies for your AWS user.

### Deploying To EKS

The first thing you will need to do is to define your Kubernetes deployment service, using the [CodeShip Kubernetes deployment container]((https://github.com/CodeShip-library/kubectl-connection-demo). You will add the following to your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):


```yaml
kubernetes-deployment:
  encrypted_env_file: k8s-env.encrypted
  image: codeship/kubectl
```

With this service configured as per the [Kubernetes documentation]({% link _pro/continuous-deployment/deployment-with-kubernetes.md %}), you will next add your `kubectl` deployment commands to your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

In this example, we will run them via a script named kubernetes.sh (such a script would be run from the container [via Docker volumes]({{ site.baseurl }}{% link _pro/builds-and-configuration/docker-volumes.md %}):

```yaml
- name: deploy
  service: kubernetes-deployment
  command: ./kubernetes.sh
```

Inside this kubernetes.sh script, we can include any Kubernetes commands we like. As one example:

```
#!/bin/sh

kubectl apply -f ./deployment.yaml
```

From here, you can modify your EKS deployments to run any command you'd like in any context by inserting any commands, tags or behaviors you need.
