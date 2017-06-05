---
title: Integrating Codeship Pro And Docker With Percy Visual Testing
layout: page
tags:
  - screenshots
  - visual testing
menus:
  pro/ci:
    title: Using Percy
    weight: 3
---

* include a table of contents
{:toc}

## What Is Percy?

Percy is a visual testing tool that lets you take screen shots, monitor visual changes and require team approval to these visual captures in an automated way as part of your CI/CD pipeline.

## Setting Up Percy

### Setting Your Percy Variables

You will need to add the two values Percy provides when you create a new project inside their application - `PERCY_TOKEN` and `PERCY_PROJECT` - to the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you define in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Static Sites

To use Percy with static sites inside Docker images on Codeship Pro, you will need to install the `percy-cli` gem inside your images, either as part of a Gemfile or by adding the following command to the Dockerfile:

```bash
RUN gem install percy-cli
```

**Note** that this will require you to be building an image that contains both Ruby and Rubygems. If the image does not contain both of these, you will be unable to install the necessary `percy-capybara` gem.

From there, you will need to add the following command a step or inside of a script in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):

```bash
- service: your_service
  command: percy snapshot directory_to_snapshot
```

Note that you can use multiple commands to take snapshots of multiple directories, and that the directories **must contain HTML files**.

### Ruby

To integrate Percy with Codeship Pro on a Ruby and Docker project, you will want to install the you will need to install the `percy-capybara` gem inside your images, either as part of a Gemfile or by adding the following command to the Dockerfile:

```bash
RUN gem install percy-capybara
```

**Note** that this will require you to be building an image that contains both Ruby and Rubygems. If the image does not contain both of these, you will be unable to install the necessary `percy-cli` gem.

From there, you will need to add specific hooks to your Rspec, Capybara, Minitest, or any other test specs you may have. You can find specific integration integration for calling Percy from your test specs [at the Percy documentation](https://percy.io/docs/clients/ruby/capybara-rails).

These test specs will be called via your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

### Ember

To integrate Percy with Codeship Pro on an Ember and Docker project, you will want to install the `ember-percy` package into your application, typically via your `package.json`.

From there, you will need to add specific hooks in to your project's test specs. You can find specific integration integration for calling Percy from your test specs [at the Percy documentation](https://percy.io/docs/clients/javascript/ember).

These test specs will be called via your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

## Percy Documentation

For more support, visit the [Percy documentation](https://percy.io/docs).
