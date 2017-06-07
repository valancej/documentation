---
title: Integrating Codeship Basic With SourceClear for Security Analysis
layout: page
tags:
  - security
  - reports
menus:
  basic/ci:
    title: Using SourceClear
    weight: 9
---

* include a table of contents
{:toc}

## Setting Up SourceClear

### Setting Your Coveralls Variables

[The SourceClear documentation](https://www.sourceclear.com/docs/) does a great job of guiding you, but to get started all you need to do is add your SourceClear API token to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

### Adding Commands

After adding the API token, you'll just need to add the SourceClear command to your project's test commands. The command to add is:

```bash
curl -sSL https://download.sourceclear.com/ci.sh | bash
 ```

**Note** that if you are using [parallel test pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallelci.md %}) then you likely only want to add this command to a single pipeline, rather than multiple pipelines.
