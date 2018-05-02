---
title: Deploy To Engine Yard
menus:
  basic/cd:
    title: Engine Yard
    weight: 12
tags:
  - deployment
  - engine yard
  - engineyard
categories:
  - Deployment 
---

* include a table of contents
{:toc}

## Deploy to Engine Yard

To setup an [Engine Yard](https://www.engineyard.com) deployment on Codeship, first create a new [custom script deployment]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}). From there you can call our [Engine Yard deployment script](https://github.com/codeship/scripts/blob/master/deployments/engine_yard.sh).

Set `EY_API_TOKEN` as an [environment variable]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}) in your Project Settings.

```
\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/deployments/engine_yard.sh | bash -s
```

## Custom Deploy to Engine Yard

To customize the deployment, first create a new [custom script deployment]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}). From there you can add any commands you need, including installing and calling the [Engine Yard CLI](https://support.cloud.engineyard.com/hc/en-us/articles/205406968-Deploy-from-the-CLI-Engine-Yard-CLI-User-Guide-).

Set `ENGINEYARD_API_TOKEN` as an [environment variable]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}) in your Project Settings.

```
gem install engineyard --no-ri --no-rdoc
ey deploy --api-token "${ENGINEYARD_API_TOKEN}"
```

Engine Yard has additional [CLI documentation](https://support.cloud.engineyard.com/hc/en-us/articles/205406968-Deploy-from-the-CLI-Engine-Yard-CLI-User-Guide-) if you need to further customize your deployment.

## Common Errors

### Engine Yard CLI is not installed by default

If you don't have Engine Yard in your `Gemfile` you need to install it first. Simply add the following command to a script based deployment.

```
gem install engineyard --no-ri --no-rdoc
```
