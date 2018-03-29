---
title: SCM Support on Codeship
shortTitle: SCM Support
menus:
  general/about:
    title: SCM Support
    weight: 2
tags:
  - scm
  - vcs
  - github
  - bitbucket
  - gitlab
  - git
  - mercurial
  - on premise
  - enterprise
  - whitelisting
categories:
  - About Codeship  
---

* include a table of contents
{:toc}

Codeship supports [Git](https://git-scm.com) repositories hosted directly on [GitHub](https://github.com), [Bitbucket](https://bitbucket.org) and [GitLab](https://about.gitlab.com). There is support for [on-premise versions]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) of these SCM systems as well.

Integration between a repository and any forked repositories is not currently supported for any SCM. You can setup forked repositories as separate projects on Codeship, but any builds for the forked repository will not link back to the parent repository.

Get started by [creating a project]({{ site.baseurl }}{% link _general/projects/getting-started.md %}) on Codeship. If you are having trouble getting your SCM connected to Codeship, [check that the correct permissions are set]({{ site.baseurl }}{% link _general/about/permissions.md %}).

## GitHub

* Codeship can clone your GitHub repositories and report build statuses back via the [GitHub API](https://developer.github.com/v3/repos/statuses).

* Required [GitHub permissions]({{ site.baseurl }}{% link _general/about/permissions.md %}#github).

* There is [support]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) for [GitHub Enterprise](https://enterprise.github.com/home).

## Bitbucket

* Codeship can clone your Bitbucket repositories and report build statuses back via the [Bitbucket API](https://confluence.atlassian.com/bitbucket/buildstatus-resource-779295267.html).

* Required [Bitbucket permissions]({{ site.baseurl }}{% link _general/about/permissions.md %}#bitbucket).

* In addition to Git repositories, [Mercurial](https://www.mercurial-scm.org) repositories on Bitbucket are also supported.

* There is [support]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) for [Bitbucket Server](https://www.atlassian.com/software/bitbucket/server).

## GitLab

* Codeship can clone your GitLab repositories and report build statuses back via the [GitLab API](https://docs.gitlab.com/ce/api/commits.html#commit-status).

* Required [GitLab permissions]({{ site.baseurl }}{% link _general/about/permissions.md %}#gitlab).

* There is [support]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) for [GitLab Community Edition](https://gitlab.com/gitlab-org/gitlab-ce) and [GitLab Enterprise Edition](https://about.gitlab.com/gitlab-ee).

## Self-hosted Git Servers

There is support of GitHub Enterprise, GitLab Community Edition, GitLab Enterprise Edition and Bitbucket Server products.

You can read the [self-hosted Git documentation]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) to learn more.

If you use self-hosted git servers, we have an IP Whitelisting option, which allows you to provide access to your git server, from just eight specific IP addresses. See [IP Whitelisting]({{ site.baseurl }}{% link _general/account/whitelisting.md %}) documentation for more details.

## Managing Your Git Server Connections

If you want to see which services you're connected to, or perhaps ensure your username is registered so your builds show up on the personal dashboard, you can go to your [Connected Services](https://app.codeship.com/authentications) page. This allows you to add more connections or update/disable your existing connections.

**Note**: Before disconnecting a service, you should check to see if it's being used by a project to communicate with your git server. The account used to connect to the git server is shown on the project's `General` settings (Project -> Project Settings -> General)

## SCM Feature Requests

We are continually evaluating our SCM integration support. If there is something you would like to see, please [get in touch](mailto:support@codeship.com) and let us know more details about your SCM needs.
