---
title: Codeship GDPR Compliance
shortTitle: GDPR Compliance
description: Technical documentation outlining Codeship's GDPR compliance
menus:
  general/about:
    title: GDPR Compliance
    weight: 6
tags:
  - privacy
  - gdpr
  - compliance
categories:
  - About Codeship
  - Security
---

* include a table of contents
{:toc}

## What is GDPR

GDPR (General Data Protection Regulation) is an EU regulation that provides consumers more control over their personal data and how it's used by companies. Part of GDPR focuses on the rights of the consumer and dictates specific rights, e.g right to be informed, right of access, right to erasure, etc. These rights concerns the consumer/user of a product or service, regardless of where that user's data is captured, processed, or stored.

When it comes to processing, storing, etc. there are two roles that a company can have under GDPR: controller and processor (also covers sub-processors). The controller decides what personal data is captured, while the processor handles personal data on behalf of a controller. Every entity that's involved in capturing or processing the personal data needs to be compliant.

As Codeship is both a controller and a processor, we will address each case separately.

## Codeship as a Processor

Although we do consider ourselves as a Processor in the context of GDPR, and take on the responsibilities that covers, we recommend you never use personal information about your customers as part of your CI/CD workflow.

### Your source code

For every build that is run on Codeship (Codeship Basic or Codeship Pro) we will connect to the repo and use your source code along with other artifacts as part of the build process. Once the build is complete, the build machine along with its content is destroyed and replaced with a new clean build.

We also  cache dependencies between builds, so if you include a custom package or save data in the cache folder, that will be persisted and stored on Codeship infrastructure. Since we cannot fully control what is cached, or easily access cached data, it will be up to you to ensure that no personal data, or other sensitive information, ends up being cached.

In some circumstances, as mentioned on the [Security page]({{ site.baseurl }}{% link _general/about/security.md %}), our support team can see the code that is checked out from your SCM, but are only allowed to access it for debug purposes and only with explicit consent from you.

### Your customers' data

Although Codeship processes data on your behalf, we don't expect you to include any personal information in the data that we store for you. If you use personal information for testing purposes (e.g. name, usernames, email addresses of actual people) you should ensure that this data is not persisted. As mentioned above, data written to the caching folder will be persisted, but you should also ensure logging output is free from personal information as these are also persisted.

The best approach to avoid any issues around Customer data, is to always use fake names, email addresses, etc. If you use a data-dump from a production system as test data input, make sure to fully anonymize it so that nothing can be traced back to a specific individual.

### Purging Data

Should you find that you have personal information in e.g. log output or cached data, please reach out via [support@codeship.com](mailto:support@codeship.com) so we can help you purge the data from our systems.

## Codeship as a Controller

As a controller in the context of GDPR, we are very cognizant of what data we store about our users and how we can best protect your privacy.

### Personal data we need to store

For us to be able to deliver a service, as well as live up to other regulator requirements such as SOC2, there are certain personal information that we will need to store and will not be able to later remove.

We will capture and store the following data that contain personal information:

* Commit Messages
  * these usually contain a username as well as email, and sometimes full name as well
* User Profile
  * when you sign up, we need to know your name, email, and git username(s) for you to make use of Codeship
* oAuth Access
  * in case you authenticate via Github, Bitbucket, or Gitlab, we will store the oauth token that is provided to us along with information like username etc.

Aside from the above, we will also store the results of your some of your actions, e.g. "John restarted build 345DG3AE" to be able to provide a record of who triggered certain events.

#### Deleting your account

In case you no longer want to use Codeship, you can delete your account via the Personal Settings page. This will not actually remove your information (we're obligated to keep it to be able to prove that the account existed) but we will delete any oauth token that we have on file, and make sure it will no longer be possible to authenticate as that user.

### Other data that we use

As part of running the Codeship infrastructure, we use a few monitoring and error capturing tools (rollbar, papertrail, newrelic, etc.). Errors may occasionally contain personal information, such as a username, name, or email, but will never contain anything more sensitive than that. We also have a 30 day data retention policy in place for the tools, so anything older than that will be deleted.

Another service that we use, which captures personal information on some users, is Profitwell. This is a service that monitors payments and credit cards, and will proactively reach out to users whose credit card is about to expire. It also provides the ability to update payment information without being a Codeship user, which is very convenient for Finance who pays the bills but have no need for an actual account.

### Optional Data capturing

When it comes to data that is not strictly necessary for us to provide you with a CI/CD service, we believe you should be in full control.

We would like to be able to capture how you use Codeship, what tech-stack you use, how much you use different parts of Codeship etc., to learn more about how Codeship is used and how we can improve it. But as this is not strictly needed, we will explicitly ask you for your consent before enabling any of the tools we use.

In the future, we would also like to be more proactive in helping you improve your own workflow, e.g. by providing you with help or updates that relate to how you’re using Codeship, instead of alerting you about every small update that may not be relevant. We would use the same behavioral data captured to improve Codeship, to help us help you.

When allowing us to capture how you use Codeship, we will enable the following services:

* Fullstory
* Appcues
* Segment (a data hub that sends data to our data warehouse)

If you do opt in, but change your mind, you can easily opt out again via your Personal Settings page. Likewise, you can easily opt in on the same page, and help us improve Codeship.

### Exercising your rights

Any Codeship user can request any of the following:

* **Right to Erasure**: have all personal information removed from Codeship and any 3rd party system or service where it may exist
  * Note: this applies only to data collected as part of the optional data capture, as we're legally obligated to keep records of who has used the system etc.
* **Right of Access**: receive a copy of the personal data captured by Codeship as well as a list of other data profiles that may exist (e.g. from having opted in to the optional data capturing)
* **Right of Rectification**: correct personal data that is incorrectly stored by Codeship or other services
* **Right to Restrict Processing**: disallow Codeship from using any optionally captured data for profiling or other analysis (data will still be captured)
* **Right to Portability**: receive a JSON version of the Right to Access document
  * Note: as Codeship isn't a personal service, project configuration etc. is not included here, but can be exported via the API
* **Right to Object**: if you're not satisfied with how we capture data, respond to your requests, or otherwise comply with GDPR you can object to any outcome
* **Right not to be subject to automated decision-making including profiling**: to avoid being included in profiling etc., do not opt in to the optional data capturing

In all cases, if you want to make a request, have questions, or objections please reach out via [support@codeship.com](mailto:support@codeship.com)

We don't limit this to just EU citizens, as we think everyone should have the same rights regardless of where they are.