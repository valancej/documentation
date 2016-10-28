---
title: Steps Configuration
layout: page
weight: 55
tags:
  - docker
  - jet
  - configuration
  - steps
category: Getting Started
---

* include a table of contents
{:toc}

## What Is codeship-steps.yml?

`codeship-steps.yml` contains all the Steps for your CI/CD process. Steps are used for the `jet steps` command, which defines your continuous integration and delivery steps. By default, steps are expected to be in one of these 4 files:

* `jet-steps.yml`
* `jet-steps.json`
* `codeship-steps.yml`
* `codeship-steps.json`

_Jet_ will look for a steps file in this order. If you are running _Jet_ locally, you can override the filename with the `--steps-path` flag. Both YAML and JSON formats are accepted.

## Prerequisites
Your Steps file will require that you have [installed Jet locally]({{ site.baseurl }}{% link _docker/getting-started/cli.md %}) or [set up your project on Codeship.]({{ site.baseurl }}{% link _docker/getting-started/codeship-configuration.md %}). It will also require that you have configured your [codeship-services.yml file]({% link _docker/getting-started/services.md %}).

## Using codeship-steps.yml

Steps are specified in a list, such as:

```yml
- name: foo_step
  tag: master
  service: app
  command: echo foo
- name: bar_step
  service: app
  command: echo bar
```

Steps are executed in the order they are specified. All steps share two directives:

* `name` specifies the name of the step, outputted in the logs. This must be unique for all steps. **This field is optional** and will be auto-generated if not specified.
* `tag` this says to only execute this step for the given "tag". Within Codeship this will be the branch or tag name. You can specify this locally via the `--tag` flag. This field is optional.
* `encrypted_dockercfg_path` the path to your relevant dockercfg file, encrypted using `jet encrypt`. This is required for any steps using private base images or push steps. The dockercfg **must** contain an account for the registry being hit (e.g. _quay.io_ or _index.docker.io_)  with access to the repository being pulled.

## Limiting steps to specific branches / tags

As already mentioned you can specify a `tag` attribute for each step, which limits the step to only that branch or tag name. Jet supports two types of values for that attribute:

* A simple string will match the complete branch name and allows you to limit a command to a single matching branch. (This is the default mode if the value is a simple string.)

    * `tag: gh-pages` would, for example limit the step to the GitHub pages branch only.

* A regular expression for more advanced configurations. Please note, that you need to specify line matchers `^` or `$` to trigger regular expression matching for tags. __Note__ that because we use Go for our Regex support, negative regexes and conditional regexes are  not supported.

    * `tag: ^(master|staging)` would run a command on any of those branches: `master`, `staging` or `staging-codeship`

## Group Steps

There are two types of group steps:

* `parallel` run the sub-steps in parallel. Feel free to specify this recursively as much as you want, _Jet_ will just max out the number of available processors. If any sub-step fails, the parallel step fails as well.
* `serial` run the sub-steps serially. This is useful for grouping within parallel steps.

Group steps share the following four directives:

* `type` the step type, either `parallel` or `serial`.
* `steps` a list of sub-steps.
* `service` or `services` which specify a service or list of services for your steps to run on.

`service` is a single string, `services` is a list of strings. At most one of these can be specified. If you specify a service at the group level you cannot specify a service for an individual run step. If you specify a list of services, all sub-steps will be run in one of two ways.

* For parallel steps, the sub-steps will be run as if you specified a serial step containing the sub-steps for each service.
* For serial steps, the services will be run in parallel.

Since that's confusing, here's a logically equivalent example:

```yaml
# Example 1
- type: parallel
  steps:
  - type: serial
    steps:
      - service: foo
        command: echo one
      - service: foo
        command: echo two
  - type: serial
    steps:
      - service: bar
        command: echo one
      - service: bar
        command: echo two

# the same as the above
- type: parallel
  services:
  - foo
  - bar
  steps:
  - command: echo one
  - command: echo two

# Example 2
- service: foo
  command: echo one
- service: foo
  command: echo two
- service: bar
  command: echo one
- service: bar
  command: echo two

# the same as the above
- type: serial
  services:
  - foo
  - bar
  steps:
  - command: echo one
  - command: echo two
```

## Run steps

Run steps specify a command to run on a service. You must specify one or two directives:

* `command` the command to run. This is always required, and identifies a step as a run step. Note that quotes are respected to split up arguments, but special characters such as `&&`, `|` or `>` are not.
* `service` the service to run the command on. If you already specified a service at the group level you can not specify a service again, otherwise this directive is required.

## Push steps

<br />
<div class="info-block">
We implemented tagging via templates. See below for the available variables. Did we miss any important ones? Let us know at [support@codeship.com](mailto:support@codeship.com).
</div>

Push steps allow a generated container to be pushed to a remote docker registry. When running after a build, this allows a deployment based upon the successful build to occur. You must specify a number of directives:

* `type: push`
* `service` the service to run the command on. If the run step is a sub-step of a parallel step, `service` cannot be specified, otherwise it is required.
* `name` the name of this push step.
* `image_name` the name of the generated image as it exists in your service.yml/json file, in the format `[registry/][owner/][name]`.
* `image_tag` the tag the generated image should be pushed to. This can be either a hardcoded string (like `latest` ) or a golang [`Template` object](http://golang.org/pkg/text/template/) referencing any of the following variables. The resulting template will be stripped of any invalid characters. As an example, take the following configuration `{% raw %}"{{.ServiceName}}.{{.Branch}}"{% endraw %}` to get a tagged image like `sandbox-app.v0.2.6`.
    * `ProjectID` (the Codeship defined project ID)
    * `BuildID` (the Codeship defined build ID)
    * `RepoName` (the name of the repository according to the SCM)
    * `Branch` (the name of the current branch)
    * `CommitID` (the commit hash or ID)
    * `CommitMessage` (the commit message)
    * `CommitDescription` (the commit description, see footnote)
    * `CommitterName` (the name of the person who committed the change)
    * `CommitterEmail` (the email of the person who committed the change)
    * `CommitterUsername` (the username of the person who committed the change)
    * `Time` (a golang [`Time` object](http://golang.org/pkg/time/#Time) of the build time)
    * `Timestamp` (a unix timestamp of the build time)
    * `StringTime` (a readable version of the build time)
    * `StepName` (the user defined name for the `push` step)
    * `ServiceName` (the user defined name for the service)
    * `ImageName` (the user defined name for the image)
    * `Ci` (defaults to `true`)
    * `CiName` (defaults to `codeship`)
* `registry` the url of the registry being pushed to. For Dockerhub, use `https://index.docker.io/v1/`.
* `encrypted_dockercfg_path` the path to your relevant dockercfg file, encrypted using `jet encrypt`.
* `tag` a group tag associated with this build step (optional).

The commit description is the result of running `git describe --abbrev=1 --tags --always` for git, or `hg log -r . --template '{latesttag}-{latesttagdistance}-{node|short}\n'` for mercurial. This will be the current code deviation from the nearest tag.

When using a private repository, or a non-standard tag in the `image_name`, keep in mind your step directives _MUST_ match your service descriptions. In order to use a private registry, the `image_name` directive in your steps file needs to match the `image_name` from `codeship_services.yml`, and should look something like `myregistry.mydomain.com:5002/myuser/myrepo`.

As for the `encrypted_dockercfg_path` directive, we support both, the older `.dockercfg` as well as the newer `${HOME}/.docker/config.json` format. You can simply encrypt either of those files via `jet encrypt` and commit the encrypted files to the repository and the configuration will be picked up.

## Build Environment

For each step, the running container is provided with a set of environment variables from the CI process. These values can help your containers to make decisions based on your build pipeline.

* `CI_PROJECT_ID` (the Codeship defined project ID)
* `CI_BUILD_ID` (the Codeship defined build ID)
* `CI_REPO_NAME` (the name of the repository according to the SCM)
* `CI_BRANCH` (the name of the current branch)
* `CI_COMMIT_ID` (the commit hash or ID)
* `CI_COMMIT_MESSAGE` (the commit message)
* `CI_COMMIT_DESCRIPTION` (the commit description)
* `CI_COMMITTER_NAME` (the name of the person who committed the change)
* `CI_COMMITTER_EMAIL` (the email of the person who committed the change)
* `CI_COMMITTER_USERNAME` (the username of the person who committed the change)
* `CI_TIMESTAMP` (a unix timestamp of the build time)
* `CI_STRING_TIME` (a readable version of the build time)
* `CI` (defaults to `true`)
* `CI_NAME` (defaults to `codeship`)

Please see our [Docker Push Tutorial]({{ site.baseurl }}{% link _docker/getting-started/docker-push.md %}) for an example on how to push to [Quay.io](https://quay.io) or the Docker Hub.

## Questions
If you have any further questions, please create a post on the [Codeship Community](https://community.codeship.com) page.
