---
title: jet update
menus:
  pro/jet:
    title: jet update
    weight: 3
categories:
  - Jet CLI
tags:
  - jet
  - update
  - cli
  - pro
---

## Description
Download and install the latest version of Jet

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
