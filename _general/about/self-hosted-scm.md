---
title: Self-hosted SCMs on Codeship
shortTitle: Self-hosted SCM
menus:
  general/about:
    title: Self-hosted SCM
    weight: 8
tags:
  - scm
  - vcs
  - github
  - github enterprise
  - bitbucket
  - bitbucket stash
  - bitbucket server
  - gitlab
  - gitlab enterprise edition
  - gitlab community edition
  - gitlab ee
  - gitlab ce
  - git
  - on premise
  - enterprise
  - whitelisting
categories:
  - About Codeship  
---

* include a table of contents
{:toc}

## Enterprise Support

Codeship supports self-hosted [Git](https://git-scm.com) repositories for the [GitHub Enterprise](https://enterprise.github.com/home), [GitLab Community Edition](https://gitlab.com/gitlab-org/gitlab-ce), [GitLab Enterprise Edition](https://about.gitlab.com/gitlab-ee) and [Bitbucket Server](https://www.atlassian.com/software/bitbucket/server) products - in addition to our [standard cloud SCM support]({{ site.baseurl }}{% link _general/about/scm-support.md %}).

## Exposing Ports

To use your private Git server with Codeship, you will need a publicly reachable endpoint with ports 22 and 433 open to the internet.

We require port 22 to clone your repository to run your builds and port 433 for status and clone requests.

**Note** that Bitbucket Server uses port 7999 rather than port 22.

## Personal Access Tokens

To connect to your self-hosted Git instance, you will need to retrieve your personal access token and add it to your [Connected Services](https://app.codeship.com/authentications) page.

To fetch your token, follow these instructions:

- [GitHub Enterprise](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)
- [GitLab Community Edition](https://docs.gitlab.com/ce/user/profile/personal_access_tokens.html) or [Enterprise Edition](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
- [Bitbucket Server](https://confluence.atlassian.com/bitbucketserver/personal-access-tokens-939515499.html)

**Note** that Codeship requires Bitbucket Server 5.5 due to prior versions not providing personal access tokens.

## IP Whitelisting

We have an IP Whitelisting option, which allows you to provide access to your git server, from just eight specific IP addresses. See [IP Whitelisting]({{ site.baseurl }}{% link _general/account/whitelisting.md %}) documentation for more details.

## SCM Feature Requests

We are continually evaluating our SCM integration support. If there is something you would like to see, please [get in touch](mailto:support@codeship.com) and let us know more details about your SCM needs.

## Security

To read more about our security setup, please [review our security documentation]({{ site.baseurl }}{% link _general/about/security.md %}) or [ask us a question](https://helpdesk.codeship.com).
