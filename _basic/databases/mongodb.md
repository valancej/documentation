---
title: Using MongoDB In CI/CD with Codeship Basic
shortTitle: MongoDB
tags:
  - services
  - databases
  - mongodb
  - mongo
  - db
menus:
  basic/db:
    title: MongoDB
    weight: 3
redirect_from:
  - /databases/mongodb/
  - /classic/getting-started/mongodb/
categories:
  - Databases  
---

* include a table of contents
{:toc}

[MongoDB](https://www.mongodb.com) `2.6.4` runs on the default port **27017** and doesn't require any credentials.

## Other Versions

If you need to install a different version or use a custom configuration, please see [this script](https://github.com/codeship/scripts/blob/master/packages/mongodb.sh).

For example if you want to install **3.6.0**, set that version as an [environment variable]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}) in your project or add this in the _Setup Commands_:

```
export MONGODB_VERSION=3.6.0
```

Next, add [this command](https://github.com/codeship/scripts/blob/master/packages/mongodb.sh#L10) to your _Setup Commands_ and the script will automatically be called at build time. Note, this script will automatically start MongoDB on port **27018** as the default port is taken by the default MongoDB version above. Your application will need to point to the updated port number.

```
\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/mongodb.sh | bash -s
```
