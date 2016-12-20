---
title: Setting Timezone
layout: page
tags:
  - timezone
category: Getting Started
---
The default timezone on Codeship's test VMs is `UTC +00:00` or `Etc/UTC`. To configure your build environment to a different timezone, simply assign the environment variable [TZ](https://linux.die.net/man/8/tzselect) to a valid timezone value from the [tz database](https://en.wikipedia.org/wiki/Tz_database) used by Linux/Unix systems. You can see the [full list of valid TZ values here](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

You can set your TZ value in your project's [Environment page](http://manpages.ubuntu.com/manpages/trusty/en/man8/tzselect.8.html) or add it in the _Setup Commands_ portion of your test configuration like so:

```shell
export TZ = 'America/New_York'
```
