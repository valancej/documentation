---
title: Managing Your Account's Connected Services
shortTitle: Managing Connected Services
menus:
  general/account:
    title: Connected Services
    weight: 3
tags:
- account
- scm
- svn
- git
- connected services
- username
- github
- gitlab
- bitbucket
categories:
  - Account
---

* include a table of contents
{:toc}

## Managing Your Account's Connected Services

The connected services page is where you can see which services are connected to your account, but also where you can specify your git username for us to map your builds with your Codeship account.

Currently, you can only connect your account to one of the SCM providers, to authenticate and/or pull code, or Google Cloud, to deploy to Google App Engine.

![connected services screenshot]({{ site.baseurl }}/images/general/connected_services.png)

### Connecting to New Services

To connect a new service, simply click the block of the service you want to connect to expand it.

Depending on the service, you can either connect to the service via Oauth (SCM cloud-versions as well as Google) or provide the necessary credentials. Once you've saved everything, the service is ready to be used.

**Example of a cloud-SCM with Oauth available**

![cloud-scm option folded out]({{ site.baseurl }}/images/general/cloud-scm_option.png)

**Example of a self-hosted SCM that requires other credentials**

![self-hosted scm option folded out]({{ site.baseurl }}/images/general/self-hosted_scm_option.png)

Even if you don't plan on using your account to let a project pull code from your repository, you can still use the Oauth option to authenticate and we will map your git username to your account automatically.

If you'd rather not connect your account using Oauth, but still get use out of the personal dashboard, you can simply supply your git username and leave the connection at that. Once we know your username, we'll make sure to map each incoming build with that username to your account.

### Updating Existing Service

You can update existing services in different ways, depending on what you're looking to achieve.

To change the linked account (for SCM cloud-versions as well as Google) simply disconnect and re-connect to the service, using the account you want to switch to when re-connecting.

If you want to remove the service or temporarily disconnect it, be aware that disabling the service will remove your account from the projects that use it to pull code. If you just need to temporarily stop Codeship from building, a better approach is to disable to integration on the SCM side and leave the service configured as is. If we don't get a webhook notification from the SCM, we don't run any builds.

Naturally, you can also update the git username in case a typo sneaked in there.
