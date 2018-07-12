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
categories:
  - Projects
  - Configuration
  - Account
redirect_from:
  - /troubleshooting/builds-are-not-triggered/
  - /faq/builds-are-not-triggered/
---

* include a table of contents
{:toc}

{% csnote info %}
If your builds are not getting triggered on Codeship, it could be that we are experiencing a service interruption. Be sure to check our [status page](https://www.codeshipstatus.com) to monitor any potential issues. You can also follow the [@CodeshipStatus](https://twitter.com/codeship) account on Twitter.
{% endcsnote %}

## Webhooks

Builds on Codeship are triggered via a webhook from your source control repository. This webhook is added to your repository when you connect the project to Codeship, but sometimes those settings get out of sync.

You can find a status indicator for this webhook on the _General_ page of your project settings.

![Hook Status and Project UUID]({{ site.baseurl }}/images/faq/hook_status_and_project_uuid.png)

### GitHub

Make sure the _Codeship_ service is added under the _Webhooks & Services_ section of your repository settings. Also check that the UUID configured for the repository matches the one shown on the _General_ page of your project settings on Codeship.

![GitHub Service Configuration]({{ site.baseurl }}/images/faq/service_github.png)

### Gitlab

Make sure a webhook for Codeship is added under the _Webhooks_ section in the settings of your repository. The [Gitlab documentation](https://docs.gitlab.com/ce/user/project/integrations/webhooks.html) has more information.

### Bitbucket

Make sure a webhook for Codeship is added under the _Webhooks_ section in the settings of your repository. Please also check the the UUID in the hook URL matches the UUID from your project. The hook URL itself should match the following pattern.

```
https://lighthouse.codeship.io/bitbucket/YOUR_PROJECT_UUID
```

![BitBucket Webhooks Configuration]({{ site.baseurl }}/images/general/bitbucket_webhooks.jpg)
