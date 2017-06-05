---
title: Integrating Codeship Basic With Percy Visual Testing
layout: page
tags:
  - screenshots
  - visual testing
weight: 5
---

* include a table of contents
{:toc}

## What Is Percy?

Percy is a visual testing tool that lets you take screen shots, monitor visual changes and require team approval to these visual captures in an automated way as part of your CI/CD pipeline.

## Setting Up Percy

### Setting Your Percy Variables

You will need to add the two values Percy provides when you create a new project inside their application - `PERCY_TOKEN` and `PERCY_PROJECT` - to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

![Configuration of Percy env vars]({{ site.baseurl }}/images/continuous-integration/percy-env-vars.png)


### Static Sites

To use Percy with static sites on Codeship Basic, you will need to install the `percy-cli` gem, either in your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}) or in your `Gemfile` itself. You can install the gem with the command:

```bash
gem install percy-cli
```

From there, you will need to add the following command to your [test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

```bash
percy snapshot directory_to_snapshot
```

Note that you can use multiple commands to take snapshots of multiple directories, and that the directories **must contain HTML files**.

### Ruby

To integrate Percy with Codeship Basic on a Ruby project, you will want to install the `percy-capybara` gem in either your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}) or your Gemfile. You can install the gem with the command:

```bash
gem install percy-capybara
```

From there, you will need to add specific hooks to your Rspec, Capybara, Minitest, or any other test specs you may have. You can find specific integration integration for calling Percy from your test specs [at the Percy documentation](https://percy.io/docs/clients/ruby/capybara-rails).

### Ember

To integrate Percy with Codeship Basic on an Ember project, you will want to install the `ember-percy` package by adding the following to your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

```bash
ember install ember-percy
```

From there, you will need to add specific hooks in to your test specs. You can find specific integration integration for calling Percy from your test specs [at the Percy documentation](https://percy.io/docs/clients/javascript/ember).

## Percy Documentation

For more support, visit the [Percy documentation](https://percy.io/docs).
