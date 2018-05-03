---
title: Using Elasticsearch In CI/CD with Codeship Basic
shortTitle: Elasticsearch
tags:
  - services
  - elasticsearch
menus:
  basic/services:
    title: Elasticsearch
    weight: 1
redirect_from:
  - /services/elasticsearch/
  - /classic/getting-started/elasticsearch/
categories:
  - Services
---

* include a table of contents
{:toc}

[Elasticsearch](https://www.elastic.co) **1.2.2** is installed on the default port **9200** and doesn't require any credentials. However, it is not running by default. To use Elasticsearch during your builds, start the service with the following command:

{% csnote warning %}
This is one of the only commands available via `sudo` and root access to run any other commands is not available on the build VMs.
{% endcsnote %}

```shell
sudo /etc/init.d/elasticsearch start
```

## Other Versions

If you need to install a different version or use a custom configuration, please see [this script](https://github.com/codeship/scripts/blob/master/packages/elasticsearch.sh).

For example if you want to install **6.0.0**, set that version as an [environment variable]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}) in your project or add this in the _Setup Commands_:

```
export ELASTICSEARCH_VERSION=6.0.0
```

Next, set the [Java version]({{ site.baseurl }}{% link _basic/languages-frameworks/java-and-jvm-based-languages.md %}#oracle-jdk-8) in your _Setup Commands_. This is required for versions 5 and above.

```shell
jdk_switcher home oraclejdk8
jdk_switcher use oraclejdk8
```

Finally add [this command](https://github.com/codeship/scripts/blob/master/packages/elasticsearch.sh#L6) to your _Setup Commands_ and the script will automatically be called at build time. Note, this script will automatically start the Elasticsearch service, so you do not need to call the sudo command mentioned above.

```
\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/elasticsearch.sh | bash -s
```
