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
  - bitbucket
  - gitlab
  - github enterprise
  - bitbucket stash
  - bitbucket server
  - gitlab enterprise edition
  - gitlab community edition
  - git
  - on premise
  - enterprise
categories:
  - About Codeship  
---

* include a table of contents
{:toc}

## Beta Access

Codeship supports self-hosted [Git](https://git-scm.com) repositories for the GitHub Enterprise, GitLab Community Edition, GitLab Enterprise Edition and Bitbucket Server products.

This is a beta feature and you will need to [contact us and request access](mailto:solutions@codeship.com).

## Exposing Ports

To use your private Git server with Codeship, you will need a publicly reachable endpoint with ports 22 and 433 open to the internet.

We require port 22 to clone your repository to run your builds and port 433 for status and clone requests.

**Note** that Bitbucket Server uses port 7999 rather than port 22.

## IP Whitelisting

We are currently planning a beta to make available a limited number of IPs for whitelisting and network access purposes.

For now, the above ports need to be made available to the public internet but please [contact us](mailto:solutions@codeship.com) if you are interested in our upcoming IP whitelisting feature.

## SCM Feature Requests

We are continually evaluating our SCM integration support. If there is something you would like to see, please [get in touch](mailto:support@codeship.com) and let us know more details about your SCM needs.

## Security

To read more about our security setup, please [review our security documentation]({{ site.baseurl }}{% link _general/about/security.md %}) or [ask us a question](https://helpdesk.codeship.com).
