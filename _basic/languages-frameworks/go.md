---
title: Using Go In CI/CD with Codeship Basic
shortTitle: Go
tags:
- go
- languages
menus:
  basic/languages:
    title: Go
    weight: 6
categories:
  - Languages And Frameworks    
redirect_from:
  - /languages/go/
---

* include a table of contents
{:toc}

## Versions And Setup

We have Go 1.4 installed by default in our virtual machine.
To change to another Go version, use this [script](https://github.com/codeship/scripts/blob/master/languages/go.sh) in your Setup Commands.

### Path

We set the `GOPATH` to `${HOME}` and checkout your code into

```shell
${HOME}/src/github.com/GITHUB_USER_NAME/GITHUB_REPOSITORY_NAME
```

### Building Your Project

You can build your Go project with

```shell
go build
```

## Dependencies

You can install dependencies with:

```shell
go get
```

To also install test dependencies, use the following command instead

```shell
go get -t -v ./...
```

### Dependency Cache

We do not cache Go dependencies between builds.

## Frameworks And Testing

We support all Go tools and test frameworks, sas long as they do not require root access for custom machine configuration. You can run your tests with a standard `go test -v` or by using test frameworks such as gocheck.

For example, using gocheck would look like:

```shell
go get launchpad.net/gocheck
go test -gocheck.v
```

## Parallel Testing

If you are running [parallel test pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallel-tests.md %}), you will want separate your tests into groups and call a group specifically in each pipeline. For instance:

**Pipeline 1:**
```shell
go test tests_1.go
```

**Pipeline 2:**
```shell
go test tests_2.go
```

### Parallelization Modules

In addition to parallelizing your tests explicitly [via parallel pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallel-tests.md %}), some customers have found using Go's built-in test parallelization is a good way to speed up your tests.

Note that aggressive parallelization can cause resource and build failure issues, as well.

## Notes And Known Issues

Due to Go version and build issues, you may find it helpful to tests your commands with different versions via an [SSH debug session]({{ site.baseurl }}{% link _basic/builds-and-configuration/ssh-access.md %}) if tests are running differently on Codeship compared to your local machine.
