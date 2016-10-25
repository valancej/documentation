---
title: Skipping builds
weight: 70
tags:
  - testing
  - faq
  - builds
categories:
  - continuous-integration
---
You can add either of the following skip directives to the commit message of the last commit before you push and that push will be ignored:

* `--skip-ci`
* `--ci-skip`
* `[skip ci]`
* `[ci skip]`

## Ignore pull request merges

When you merge a pull request you can add one of the skip directives to the commit message as well.

## Can we limit the branches that are built?

We build all branches you push to your repository. In our opinion every push to your repository should be tested.

We don't have a feature to limit which branches can be built.
