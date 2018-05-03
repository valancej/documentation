---
title: Using Apache Cassandra In CD/CD With Codeship Basic
shortTitle: Apache Cassandra
tags:
  - services
  - databases
  - db
  - cassandra
menus:
  basic/db:
    title: Apache Cassandra
    weight: 5
categories:
  - Databases
redirect_from:
  - /databases/cassandra/
  - /classic/getting-started/cassandra/
---

* include a table of contents
{:toc}

The latest version from the `2.0.x` release of [Apache Cassandra](http://cassandra.apache.org/) is installed on the build VMs, but not running by default.

To use the service during your builds, start the service via the following command:

{% csnote warning %}
Note, that this is the only command available via `sudo` and root access to run any other commands is not available on the build VMs.
{% endcsnote %}

```shell
sudo /etc/init.d/cassandra start
```

If you require a CLI tool to access or Cassandra server, we would recommend [cqlsh](https://pypi.python.org/pypi/cqlsh) available via pip.

```shell
pip install cqlsh
```
