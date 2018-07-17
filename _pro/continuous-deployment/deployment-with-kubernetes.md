---
title: Continuous Deployment With Kubernetes
shortTitle: Deploying With Kubernetes
menus:
  pro/cd:
    title: Kubernetes
    weight: 13
categories:
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

## Issue kubectl commands to your k8s cluster from your Codeship Pro build

{% csnote info %}
The public repository for our `codeship/kubectl` Docker image can be found [here](https://github.com/codeship-library/kubectl).
{% endcsnote %}

### 1. Distill your current k8s configuration to a single file

With a configured k8s cluster context on your local machine, run the following command in your project directory:

```shell
kubectl config view --flatten > kubeconfigdata # add --minify flag to reduce info to current context
```

### 2. Copy contents of generated k8s config file to env var file

We have a Docker container built for taking the plaintext, flattened k8s config file and storing to a [Codeship Pro env file]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}). The `/root/.kube/config` path specifies exactly where we want the contents of the `kubeconfigdata` securely placed in the `codeship/kubectl` container during runtime.

```bash
docker run --rm -it -v $(pwd):/files codeship/env-var-helper cp kubeconfigdata:/root/.kube/config k8s-env
```

{% csnote info %}
Check out the [codeship/env-var-helper README](https://github.com/codeship-library/docker-utilities/tree/master/env-var-helper) for more information.
{% endcsnote %}

### 3. Encrypt the env file, remove plaintext and/or add to .gitignore

```shell
jet encrypt k8s-env k8s-env.encrypted
rm kubeconfigdata k8s-env
```

### 4. Configure your services and steps file with the following as guidance

```shell
## codeship-services.yml

kubectl:
  build:
    image: codeship/kubectl
    dockerfile: Dockerfile
  encrypted_env_file: k8s-env.encrypted
```

```shell
## codeship-steps.yml

- name: check response to kubectl config
  service: kubectl
  command: kubectl config view
```

{% csnote info %}
If you'd like to test the connection to your live k8s cluster, you can add a step command to `kubectl cluster-info`.
{% endcsnote %}
