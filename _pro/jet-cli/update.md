---
title: jet update
menus:
  pro/jet:
    title: jet update
    weight: 9
categories:
  - Jet CLI
tags:
  - jet
  - update
  - cli
  - pro
---

## Description
Download and install the latest version of Jet. 

_Note: This command is available if you are using version [2.2.0](https://documentation.codeship.com/pro/jet-cli/release-notes/#220---2018-01-23) or newer of the Jet CLI._

## Usage

```
jet update [flags]
```

## Flags
{% include jet_flag_table.html flags=site.data.jet.flags.update %}

## Extended description
With `jet update` you can update your locally installed version to the latest available version.

This command is handy if you installed the `jet` CLI by downloading the archive directly from Codeship, or via a package manager that doesn't support upgrades (e.g. Homebrew Cask).

## Examples

### Update Dry Run
```shell
$ jet update --dry-run
Dry run. Would have updated from $INSTALLED_VERSION to $NEW_VERSION.

# If you are on the latest version already
Up to date. Running version $INSTALLED_VERSION.
```
