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

Depending on your SCM, the process to fix this is a bit different.

### GitHub

Make sure the CodeShip Github App has been installed on your Github organization that owns the repository for your project. You also need to ensure that the CodeShip Github App has been allowed to access the repository. To install or update your CodeShip Github App, go to your Github _Organization Settings_ and select the _Installed Github Apps_ menu. If the CodeShip Github App is not installed it will not show up; if it is installed click the _Configure_ button to update the list of allowed repositories.

![Github Apps Configuration]({{ site.baseurl }}/images/general/github_apps_configuration.png)

### Gitlab

Make sure a webhook for Codeship is added under the _Webhooks_ section in the settings of your repository. The [Gitlab documentation](https://docs.gitlab.com/ce/user/project/integrations/webhooks.html) has more information.

### Bitbucket

Make sure a webhook for Codeship is added under the _Webhooks_ section in the settings of your repository. Please also check the the UUID in the hook URL matches the UUID from your project. The hook URL itself should match the following pattern.

```
https://lighthouse.codeship.io/bitbucket/YOUR_PROJECT_UUID
```

![BitBucket Webhooks Configuration]({{ site.baseurl }}/images/general/bitbucket_webhooks.jpg)
