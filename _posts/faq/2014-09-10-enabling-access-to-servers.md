---
title: How to enable access for Codeship on your Firewall
layout: page
tags:
  - faq
  - firewall
  - security group
  - ip addresses
  - iam
categories:
  - faq
---
## IP Addresses

Codeship is hosted on AWS EC2 us-east-1 region. Because of this, Codeship services do not have a static IP address. AWS publishes their most up-to-date [IP Address Ranges](http://docs.aws.amazon.com/general/latest/gr/aws-ip-ranges.html) in [JSON format](https://ip-ranges.amazonaws.com/ip-ranges.json).

You can enable access for those ranges on your own server's firewall settings. Alternatively, if you are an AWS customer yourself, you can add the following information to your EC2 Security Group.

## AWS Security Group and Account ID

### Attention: Our Infrastructure is Changing
Release date: **Thursday, November 3rd 2016**

On the 3rd November 2016 all instances used for running Codeship builds will be moving into an Amazon VPC. Previously, if you were situated within AWS `us-east-1` region, it was possible to limit access to your infrastructure via a single security group, owned by Codeship. However, this is now not possible.

**What does this mean for you?**

If you want to limit incoming traffic to your infrastructure, we recommend that you use the IP addresses approach shown above. All our instances will now move into a new security group, which is only accessible from within our VPC. This means that you cannot whitelist our security group in order to give Codeship instances access to your infrastructure. 

If you experience any issues regarding this change, please open a ticket at [helpdesk.codeship.com]()
