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

You can enable access for those ranges on your own server's firewall settings.


## AWS Security Group and Account ID (support ended November 3rd 2016)

### Attention: Our Infrastructure Changed
As of November 3, 2016, all instances used for running Codeship builds moved into an Amazon VPC. Previously, if your infrastructure was situated in the AWS `us-east-1` region, it was possible to whitelist Codeship access via a single AWS security group and account ID, owned by Codeship. This is no longer possible as of November 3, 2016.

**What does this mean for you?**

If you want to limit incoming traffic to your infrastructure, we recommend that you use the IP addresses approach shown above. All our instances will now move into a new security group, which is only accessible from within our VPC. This means that you cannot whitelist our security group in order to give Codeship instances access to your infrastructure. 

If you experience any issues regarding this change, please open a ticket at [helpdesk.codeship.com]()
