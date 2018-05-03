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
  - Account
  - Security
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

### Token Access Scopes

In order for Codeship to be allowed to setup the necessary hooks etc. the personal access tokens need to have the correct set of scopes. Below you'll find the necessary setting for each of the three self-hosted Git servers:

**GitHub Enterprise**

![GitHub Enterprise Access Scopes]({{ site.baseurl }}/images/general/github_ent_scopes.png)

**GitLab Community Edition**

![GitLab Community Edition Access Scopes]({{ site.baseurl }}/images/general/gitlab_ce_scopes.png)

**Bitbucket Server**

![Bitbucket Server Access Scopes]({{ site.baseurl }}/images/general/bitbucket_server_scopes.png)

### Usernames

When you're using a self-hosted git server, you will need to supply your username as well so that we can map up your builds with your Codeship account and show them on your personal dashboard. All users of self-hosted git servers will need to do this, for the personal dashboard to work, but are not required to supply access codes.
If you don't expect to be pushing code, and are mainly setting up Codeship for others, you can leave the username(s) blank.

**Note**: Users of cloud SCMs, who authenticate with oAuth, do not need to supply usernames as we get the username as part of the authentication workflow.



Note: Users who want to take advantage of the personal dashboard will need to supply their usernames, but don't necessarily need to supply access tokens.

## IP Whitelisting

We have an IP Whitelisting option, which allows you to provide access to your git server, from just eight specific IP addresses. See [IP Whitelisting]({{ site.baseurl }}{% link _general/account/whitelisting.md %}) documentation for more details.

## SCM Feature Requests

We are continually evaluating our SCM integration support. If there is something you would like to see, please [get in touch](mailto:support@codeship.com) and let us know more details about your SCM needs.

## Security

To read more about our security setup, please [review our security documentation]({{ site.baseurl }}{% link _general/about/security.md %}) or [ask us a question](https://helpdesk.codeship.com).
