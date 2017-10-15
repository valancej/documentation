---
title: Custom DNS Resolution
menus:
  basic/ci:
    title: Custom DNS
    weight: 4
tags:
  - subdomain
  - testing
  - dns
  - domain
  - lvh.me
  - xip.io
  - nip.io
categories:
  - Continous Integration    
redirect_from:
  - /continuous-integration/using-subdomains/
---

* include a table of contents
{:toc}

Sometimes you need to access your application at a specific URL during the build.

As it is not possible to modify the `/etc/hosts` file or run your own DNS server on the build VMs, we recommend you use a wildcard DNS service instead.

There are several different services available for you to use. We recommend `lvh.me`, [xip.io](http://xip.io) and [nip.io](http://nip.io).

## lvh.me

This service is very straight forward. Any request to a subdomain of `lvh.me` will resolve to `127.0.0.1`.

```shell
$ nslookup myapp.lvh.me
Server:		10.0.3.1
Address:	10.0.3.1#53

Non-authoritative answer:
Name:	myapp.lvh.me
Address: 127.0.0.1
```

## xip.io

If you need more flexibility with regards to the resolved IP address try [xip.io](http://xip.io).

You can configure the IP address as part of the domain name. A name like `myapp.127.0.0.1.xip.io` will resolve to `127.0.0.1`.

```shell
$ nslookup myapp.127.0.0.1.xip.io
Server:		10.0.3.1
Address:	10.0.3.1#53

Non-authoritative answer:
Name:	myapp.127.0.0.1.xip.io
Address: 127.0.0.1
```

In most cases this additional flexibility is not required, as you can't modify the IPs of the build VMs. You can however make use of this with other [loopback IP addresses](https://en.wikipedia.org/wiki/Localhost).

## nip.io

As an alternative to xip.io there is [nip.io](http://nip.io). It works the same way.

```shell
$ nslookup myapp.127.0.0.1.nip.io
Server:		10.0.3.1
Address:	10.0.3.1#53

Non-authoritative answer:
Name:	myapp.127.0.0.1.nip.io
Address: 127.0.0.1
```
