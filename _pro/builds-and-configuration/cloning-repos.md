---
title: Using Multiple Repositories
menus:
  pro/builds:
    title: Multiple Repos
    weight: 11
tags:
  - docker
  - tutorial
  - ssh key
  - encryption
  - repo
  - git
  - ssh

categories:
  - Builds and Configuration
  - Configuration

redirect_from:
  - /pro/getting-started/cloning-repos/
---

{% csnote info %}
This task requires the following:

- Local machine install of our [CLI tool]({{ site.baseurl }}{% link _pro/jet-cli/usage-overview.md %})
{% endcsnote %}

* include a table of contents
{:toc}

## Multi-Repo Build Pipelines

When using microservices, you may have several repos you want to build together or in sequences. There are two primary setups to accomplish this, and for each setup there are a couple of methods you can use.

- You can create separate CI/CD projects for each repository, allowing them to deploy independently of one another. Then, you can either have each project bring in all of your individual component repos for full-stack testing, or you can create a separate, agnostic project just for the purposes of combining them for full-stack testing.

- You can create a single project that pulls from all of your repos, deploying all components together whenever the master project is updated.

Once you decide which workflow you like, there are two main ways to combine your repos for full-stack testing.

## Using Image Pushes

If you opt to create separate CI/CD projects for each individual component, you can have each component's pipeline end with an [image push]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) to an image registry.

Then, either with a separate project or as a part of the build process for each component, you can pull in the latest images for each component to build and test your combined application.

## Cloning Another Repository Into Your Docker Image

In addition to the above method using images in a registry, you can also clone the repos themselves during the build process - either with a separate project or as part of the build for each individual component.

### The OAuth Option

Before delving into the SSH approach, another option to cloning from GitHub is to use [OAuth instead of an SSH key]:

```
git clone https://<token>:x-oauth-basic@github.com/owner/repo.git
```

[Github](https://github.com/blog/1270-easier-builds-and-deployments-using-git-over-https-and-oauth) and [Bitbucket](https://confluence.atlassian.com/bitbucket/oauth-on-bitbucket-cloud-238027431.html#OAuthonBitbucketCloud-Cloningarepositorywithanaccesstoken) provide additional information on this.

### The SSH Key Option

The process for securely setting your private SSH key is already covered in our [setting SSH private key documentation]({{ site.baseurl }}{% link _pro/builds-and-configuration/setting-ssh-private-key.md %}). But the outlined approach has one drawback -- it does not allow for SSH based operations during the image build. That's a concern if you are trying to bake a cloned repo right into the image (and not wanting to pull the repo into a volume for every Codeship Pro build).

**The suggested deviation from the outlined approach is to:**

1. Designate the encrypted file in `codeship-services.yml` as the `encrypted_args_file`
2. Ensure that a `git clone` can be performed with the generated public key (either setting as a deploy key with one repo, or setting up a [machine user]({{ site.baseurl }}{% link _basic/builds-and-configuration/access-to-other-repositories.md %}) with access to multiple repos)
3. Configure your Dockerfile with the following guidance:

```dockerfile
FROM ubuntu:16.04
ARG PRIVATE_SSH_KEY

RUN apt-get update \
  && apt-get install -y --no-install-recommends\
    ca-certificates  \
    git-core \
    ssh

# Prevent the PRIVATE_SSH_KEY from persisting in an image layer by forcefully removing at end of multi-line command
RUN mkdir -p $HOME/.ssh \
  && echo -e $PRIVATE_SSH_KEY >> $HOME/.ssh/id_rsa \
  && chmod 600 $HOME/.ssh/id_rsa \
  && ssh-keyscan -H github.com >> $HOME/.ssh/known_hosts \
  && git clone repo:repo.git \
  && rm -rf $HOME/.ssh

COPY . ./
```

Note that this is a high-level, directional example and will require additional work to use in a live build.

## Building With Repos Via API

You can also use the API v2 to programmatically trigger builds that depend on each other, or potentially an external event or system.

To get more details on how to do this, head over to the [API Documentation]({{ site.baseurl }}{% link _general/integrations/api.md %}) page
