---
title: Troubleshooting Issues With Builds Not Starting
shortTitle: Builds Not Starting
menus:
  general/projects:
    title: Builds Not Starting
    weight: 6
tags:
  - troubleshooting
  - build error
  - github
  - bitbucket
  - gitlab
  - git

redirect_from:
  - /troubleshooting/builds-are-not-triggered/
  - /faq/builds-are-not-triggered/
---

* include a table of contents
{:toc}

<div class="info-block">
If your builds are not getting triggered on Codeship, it could be that we (or a service we depend on) are experiencing a (parial) outage. In those cases, please check our [status page](http://codeshipstatus.com){:target="_blank"}. You can also follow the [@CodeshipStatus](https://twitter.com/codeship) account on Twitter.
</div>

Builds on Codeship are triggered via a webhook from your VCS. We add this hook to your repository when you configure the project on Codeship, but sometimes those settings get out of sync.

That's why we show the status of the webhook configuration on the _General_ page of your project settings.

![Hook Status and Project UUID]({{ site.baseurl }}/images/faq/hook_status_and_project_uuid.png)

## GitHub

Make sure the _Codeship_ service is added under the _Webhooks & Services_ section of your repository settings. Also check that the UUID configured for the repository matches the one shown on the _General_ page of your project settings on Codeship.

![GitHub Service Configuration]({{ site.baseurl }}/images/faq/service_github.png)

## Gitlab

Make sure a webhook for Codeship is added under the _Webhooks_ section in the settings of your repository. The [Gitlab documentation](https://docs.gitlab.com/ce/user/project/integrations/webhooks.html) has more information.

## Bitbucket

Make sure a webhook for Codeship is added under the _Webhooks_ section in the settings of your repository. Please also check the the UUID in the hook URL matches the UUID from your project. The hook URL itself should match the following pattern.

```
https://lighthouse.codeship.io/bitbucket/YOUR_PROJECT_UUID
```

![BitBucket Webhooks Configuration]({{ site.baseurl }}/images/general/bitbucket_webhooks.jpg)
