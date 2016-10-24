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

Codeship services do not have a static IP. We are hosted in the US-East region of EC2 at AWS. You can find all the IP addresses allocated to EC2 at [AWS IP Address Ranges](http://docs.aws.amazon.com/general/latest/gr/aws-ip-ranges.html) or take a look at their [.json](https://ip-ranges.amazonaws.com/ip-ranges.json) file directly.

You can enable access for those ranges on your own server's firewall settings. Alternatively, if you are an AWS customer yourself, you can add the following information to your EC2 security group.

## AWS Security Group and Account ID

* Account ID: *841076584876*
* Security group ID: *sg-64c2870c*

In your EC2 security group, set the source to Custom-IP and add the following snippet as the source.

```shell
841076584876/sg-64c2870c
```

Be aware that security groups don't work across AWS regions, so for the above settings to be applicable to your account, you'd need to host your instances on `us-east-1` as well. Also, security groups won't work with instances hosted in a Virtual Private Cloud (VPC) at all.

## Access from RDS instances

Different to the settings mentioned above you need to provide the name of the security group instead of the ID. Please add the following access rules

* Account ID: *841076584876*
* Security group name: *default*

Note, that this doesn't work with VPCs or across regions either.
