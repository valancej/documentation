---
title: Deploy With Cloud66
tags:
  - deployment
  - cloud66
menus:
  basic/cd:
    title: Cloud66
    weight: 14
categories:
  - Continuous Deployment       
redirect_from:
  - /continuous-deployment/deployment-with-cloud66/
---

* include a table of contents
{:toc}

Integrating [Cloud 66](http://www.cloud66.com/) with Codeship is as simple as copying and pasting a URL!

Once you've deployed your stack with _Cloud 66_, you'll see a **Redeployment Hook** URL on your **Stack Information** page. To trigger a new deployment via Codeship, simply add a **Script** deployment to the project and add the following command:

```shell
curl -X POST -d "" https://hooks.cloud66.com/stacks/redeploy/xxxx/yyyy
```

If you a have docker based microservice architecture and you want to (re)deploy only one service on your cluster, add the following command:

```shell
curl -X POST -d "" https://hooks.cloud66.com/stacks/redeploy/xxxx/yyyy?services=web
```

For multiple services in one go:

```shell
curl -X POST -d "" https://hooks.cloud66.com/stacks/redeploy/xxxx/yyyy?services=web,app
```
