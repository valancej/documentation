---
title: My builds are not triggered anymore
layout: page
tags:
  - faq
  - build error
  - github
  - bitbucket
categories:
  - faq
---

Builds on Codeship are triggered via a webhook from GitHub or BitBucket. We add this hook to your repository when you configure the project on Codeship, but sometimes those settings get out of sync.

That's why we show the status of the webhook configuration on the _General_ page of your project settings.

![Hook Status and Project UUID]({{ site.baseurl }}/images/faq/hook_status_and_project_uuid.png)

## GitHub

Make sure the _Codeship_ service is added under the _Webhooks & Services_ section of your repository settings. Also check that the UUID configured for the repository matches the one shown on the _General_ page of your project settings on Codeship.

![GitHub Service Configuration]({{ site.baseurl }}/images/faq/service_github.png)

## BitBucket

<div class="info-block" style="margin-top: 1em;">
BitBucket recently released a new implementation for their webhooks, which we are currently evaluating and will switch to in the future!
</div>

Make sure a webhook for Codeship is added under the _Services_ section of your repository. Please also check the the UUID in the hook URL matches the UUID from your project. The hook URL itself should match the following pattern.

```
https://lighthouse.codeship.io/bitbucket/YOUR_PROJECT_UUID
```

![BitBucket Service Configuration]({{ site.baseurl }}/images/faq/webhook_bitbucket.png)

### Issues with BitBucket

There is a bug with BitBucket web hooks, which won't supply needed information for pushes which don't include new commits. (E.g. pushing a merge of two branches). The full bug report on this is available at the [BitBucket issue tracker](https://bitbucket.org/site/master/issue/7775/post-service-does-not-provide-useful).

As a workaround we recommend explicitly creating a merge commit when merging branches. On the command line simply include the `--no-ff` flag.

Please note, that in some cases even including the flag won't trigger a build on Codeship. See the above mentioned bug report for the full details.

## Issues with Codeship

It also might be possible that there are issues on Codeship. Please check our [Codeship Status Page](http://codeshipstatus.com){:target="_blank"} or follow us on [@Codeship](https://twitter.com/codeship) for further information.
