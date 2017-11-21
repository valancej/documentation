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
  - gitlab enterprise
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

Codeship supports self-hosted [Git](https://git-scm.com) repositories for the Github Enterprise, Gitlab Community Edition, Gitlab Enterprise and Bitbucket Server products.

This is a beta feature and you will need to [get in touch](mailto:solutions@codeship.com) to request access for free.

## Exposing Ports

To use your private Git server with Codeship, you will need a publicly reachable endpoint with ports 22 and 433 open to the internet.

We require port 22 for status and clone requests, and port 433 to clone your repository to run your builds.

**Note** that Bitbucket Server uses port 7999 rather than port 433.

## IP Whitelisting

We are currently planning a beta to make available a limited numbe of IPs for whitelisting and network access purposes.

For now, the above ports need to be made available to the public internet but please [get in touch](mailto:solutions@codeship.com) if you are interested in our upcoming IP whitelisting feature.

## SCM Feature Requests

We are continually evaluating our SCM integration support. If there is something you would like to see, please [get in touch](mailto:support@codeship.com) and let us know more details about your SCM needs.

## Security

To read more about our security setup, please [review our security documentation]({{ site.baseurl }}{% link _general/about/security.md %}) or [ask us a question](https://helpdesk.codeship.com).
