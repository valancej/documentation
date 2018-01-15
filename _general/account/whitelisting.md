---
title: Whitelisting Codeship & Build Machines
shortTitle: IP Whitelisting
tags:
  - administration
  - whitelisting
categories:
  - Account
menus:
  general/account:
    title: IP Whitelisting
    weight: 4
---

* include a table of contents
{:toc}

The IP Whitelisting feature is mainly useful if you have a [self-hosted git server]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) or if you deploy/push build artifacts to something that's hosted behind your own firewall.

If you're unsure if you need IP whitelisting or not, keep reading. If you know you need it, jump to [Setting up Whitelisting](#setting-up-whitelisting) to get started.

## BETA NOTICE

Note that IP whitelisting is currently in Beta and currently only works for Basic projects. Support for Pro projects is in the works and will be finished soon. We expect IP Whitelisting to be generally available before February 2018.

## When to use IP Whitelisting
There's no need for whitelisting if you're deploying to heroku, dreamhost and similar hosting services, as they generally allow connections from any public IP address.

If you use AWS, Google Cloud, or Azure you shouldn't need to use whitelisting, unless you have a VPC setup that does not allow access from public networks.

As a rule of thumb, you only need the whitelisting feature if you're looking to connect to a server/service that does not have a public IP address.

## How whitelisting works
Once the whitelisting feature has been enabled, all traffic from Codeship (incl. the build machine your build is running on) will originate from one of the eight IP addresses listed further below. 

This will allow you to open your firewall to allow access from just these IP addresses, instead of allowing access from the entire AWS us-east-1 network (or worse still, from any public IP address). Our whitelisting IP addresses also won't change, at least not without sufficient notice, which makes maintenance much easier.

Note though, that the whitelisting only applies to traffic originating from Codeship. If your organization limits outgoing traffic, you won't be able to rely on these eight IP addresses to limit outbound traffic to codeship. Please [get in touch](mailto:support@codeship.com) if you're in this situation and we'll see what we can do to help.

## Setting up Whitelisting

### Step 1

The first thing to do is to enable the Whitelisting feature on Codeship:

1. Navigate to the account that need the whitelisting feature
2. Select "Settings" from the top navigation.
3. Check the "Whitelisting" box and save the changes

### Step 2

Next step is to open your firewall to the IP addresses listed below. How to do this depends on your firewall, so we're not going to cover that here.

```
52.6.227.82
54.227.213.190
54.173.82.56
34.237.248.199
34.235.207.198
34.234.192.53
34.238.108.61
34.239.17.55
```

Generally you should only open access to the below listed IP addresses, on the ports that you expect requests to come in. 

See the documentation for [Self Hosted SCM]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}#exposing-ports)
for details on which ports to open to be able to connect to your internal CSM.