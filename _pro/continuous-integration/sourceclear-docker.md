---
title: Integrating Codeship Pro With SourceClear for Security Analysis
shortTitle: Using SourceClear For Security Analysis
tags:
  - security
  - reports
  - reporting
  - coverage
menus:
  pro/ci:
    title: Using SourceClear
    weight: 5
---

* include a table of contents
{:toc}

## Setting Up SourceClear

### Setting Your SourceClear Variables

[The SourceClear documentation](https://www.sourceclear.com/docs/) does a great job of guiding you, but to get started all need to do is to add your SourceClear API token to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you define in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).


### Adding Commands

After adding the API token, you will need to add the following commands to a script, placed in your repository, that you will call from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):


```bash
curl -sSL https://download.sourceclear.com/ci.sh | bash
 ```

**Note** that if you are using [parallel test steps]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) then you likely only want to call this script once, as it's own step, rather than as part of your test steps themselves.
