---
title: Deploy To anynines
tags:
  - deployment
  - anynines
menus:
  basic/cd:
    title: anynines
    weight: 17
categories:
  - Deployment       
redirect_from:
  - /continuous-deployment/deployment-to-anynines/
---

* include a table of contents
{:toc}

## What is anynines?

[anynines](https://www.anynines.com) is a PaaS built on top of CloudFoundry and OpenStack.

They have a great [Getting Started](https://support.anynines.com/hc/en-us/articles/115014344828-Getting-Started-with-anynines) guide which we definitely encourage you to check out. Also, see their [documentation](https://support.anynines.com/hc/en-us) for more information.

## Deploying

As for getting started with **anynines** on Codeship, start by getting your application to deploy from your local machine. Once this is done, you need to add the following environment variables to your project settings.

```
CF_USER
CF_PASSWORD
CF_ORG
CF_SPACE
CF_APPLICATION
```

Then create a new **script based** deployment and paste the following commands.

```shell
cf6 api https://api.de.a9s.eu
cf6 auth "${CF_USER}" "${CF_PASSWORD}"
cf6 target -o "${CF_ORG}" -s "${CF_SPACE}"
cf6 push "${CF_APPLICATION}"
```

This will deploy your application on each push to the specific branch you configured the deployment for.

If you have more thorough requirements, like _blue/green deployments_ see a great article written by the folks at _anynines_ about deploying to Codeship, which is  [available at their blog](https://blog.anynines.com/setup-continuous-deployment-anynines-codeship-com).
