---
title: AMI Packages
weight: 97
tags:
- AMI
- continuous integration
- packages
category: Getting Started
---
**current build: last edited on 2016/11/11**

* include a table of contents
{:toc}

In a best effort to list the packages that are installed on our AMI (Amazon Machine Image) within our hosted Codeship environment, we offer the following list of installed packages. It might be **partly incomplete**, but we hope it offers good value and transparency.

If you want to check a certain package or default version for yourself, you can use the SSH Debug session within your project and connect directly to our build machine.

![Open SSH Debug Session]({{ site.baseurl }}/images/basic/open_ssh.png)

Click on the link to open an SSH debug session. You will be provided with the username, server, and port which you can use to access the build machine. You will need an SSH key in your .ssh folder (default). For more information, please read our documentation on [SSH access]({{ site.baseurl }}{% link _basic/getting-started/ssh-access.md %}).

## nvm list
```
iojs-v1.8.4
iojs-v2.5.0
iojs-v3.3.1
    v0.8.28
    v0.9.12
->  v0.10.48
    v0.11.16
    v0.12.17
    v4.6.1
    v5.12.0
    v6.9.1
default -> 0.10 (-> v0.10.48)
node -> stable (-> v6.9.1) (default)
stable -> 6.9 (-> v6.9.1) (default)
unstable -> 0.11 (-> v0.11.16) (default)
iojs -> iojs-v3.3 (-> iojs-v3.3.1) (default)
```

## phpenv versions
```
system
  5.3
  5.3.29
  5.4
  5.4.45
* 5.5
  5.5.38
  5.6
  5.6.27
  7.0
  7.0.12
```

## rvm list
```
rvm rubies

   default [ x86_64 ]
   jruby-1.7.21 [ x86_64 ]
   jruby-1.7.22 [ x86_64 ]
   jruby-1.7.23 [ x86_64 ]
   jruby-1.7.24 [ x86_64 ]
   jruby-1.7.25 [ x86_64 ]
   jruby-9.0.4.0 [ x86_64 ]
   jruby-9.0.5.0 [ x86_64 ]
   ruby-1.8.7-p374 [ x86_64 ]
   ruby-1.9.2-p320 [ x86_64 ]
   ruby-1.9.3-p551 [ x86_64 ]
   ruby-2.0.0-p648 [ x86_64 ]
   ruby-2.1.0 [ x86_64 ]
   ruby-2.1.1 [ x86_64 ]
   ruby-2.1.2 [ x86_64 ]
   ruby-2.1.3 [ x86_64 ]
   ruby-2.1.4 [ x86_64 ]
   ruby-2.1.5 [ x86_64 ]
   ruby-2.1.6 [ x86_64 ]
=* ruby-2.1.7 [ x86_64 ]
   ruby-2.1.8 [ x86_64 ]
   ruby-2.1.9 [ x86_64 ]
   ruby-2.2.0 [ x86_64 ]
   ruby-2.2.1 [ x86_64 ]
   ruby-2.2.2 [ x86_64 ]
   ruby-2.2.3 [ x86_64 ]
   ruby-2.2.4 [ x86_64 ]
   ruby-2.2.5 [ x86_64 ]
   ruby-2.3.0 [ x86_64 ]
   ruby-2.3.1 [ x86_64 ]

# => - current
# =* - current && default
#  * - default
```

## Installed Packages
```
{% include ami/a1a8ded9-6829-4564-9737-0476c5a8228a_96757e2f2d95.md %}
```

```
ANT_VERSION:="1.9.2"
CHROMEDRIVER_VERSION:="2.24"
GECKODRIVER_VERSION:="0.11.1"
GAE_VERSION:="1.9.40"
GOLANG_VERSION:="1.4"
GRADLE_VERSION:="1.10"
LEININGEN_VERSION:="2.5.1"
LIBGEOS_VERSION:="3.4.2"
MAVEN_VERSION:="3.2.5"
NVM_VERSION:="0.26.1"
PARALLEL_VERSION:="20130922"
SNAPPY_VERSION:="1.1.2"
SNZIP_VERSION:="1.0.1"
THRIFT_VERSION:="0.9.2"
Mozilla Firefox 35.0.1
```
