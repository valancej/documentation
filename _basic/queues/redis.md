---
title: Using Redis In CI/CD with Codeship Basic
shortTitle: Redis
tags:
  - services
  - queues
  - redis
menus:
  basic/queues:
    title: Redis
    weight: 1
categories:
  - Queues    
  - Configuration
redirect_from:
  - /queues/redis/
  - /classic/getting-started/redis/
---

* include a table of contents
{:toc}

[Redis](https://redis.io) `2.8.4` runs on the default port **6379** and doesn't require any credentials.

## Other Versions

If you need to install a different version or use a custom configuration, please see [this script](https://github.com/codeship/scripts/blob/master/packages/redis.sh).

For example if you want to install **4.0.2**, set that version as an [environment variable]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}) in your project or add this in the _Setup Commands_:

```
export REDIS_VERSION=4.0.2
```

Next, add [this command](https://github.com/codeship/scripts/blob/master/packages/redis.sh#L6) to your _Setup Commands_ and the script will automatically be called at build time. Note, this script will automatically start the Redis service on the default port.

```
\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/redis.sh | bash -s
```
