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

* Account ID: *841076584876*
* Security Group ID: *sg-64c2870c*

In your EC2 Security Group, set the Source to Custom-IP and add the following snippet as the Source.

```shell
841076584876/sg-64c2870c
```

Be aware that Security Groups don't work across AWS regions, so for the above settings to be applicable to your account, you'd need to host your instances on `us-east-1` as well. Also, Security Groups won't work with instances hosted in a Virtual Private Cloud (VPC) at all.

## Access from RDS instances

Different to the settings mentioned above you need to provide the name of the Security Group instead of the ID. Please add the following access rules

* Account ID: *841076584876*
* Security Group name: *default*

Note, that this doesn't work with VPCs or across regions either.
