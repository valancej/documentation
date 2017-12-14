---
title: Using Git Submodules In CI/CD with Codeship Basic
shortTitle: Git Submodules
menus:
  basic/ci:
    title: Git Submodules
    weight: 3
tags:
  - git
  - submodules
categories:
  - Continuous Integration
redirect_from:
  - /continuous-integration/git-submodules/
---

* include a table of contents
{:toc}

If your repository includes a `.gitmodules` file, Codeship will automatically initialize and update the configured submodules. The following command is run after cloning your repository to do this.

```shell
git submodule update --recursive --init
```

<div class="info-block">
  Right now there is not a way to skip this command, but let us know if that creates a problem for your build.
</div>

## Submodule Permissions

Submodules that are hosted as public repositories should just work, but let us know if you see any issues.

If your submodule is a **private repository** you need to make sure Codeship can clone the repository.

1. Make sure the project's public SSH key (from the _General_ settings page) has access to the submodule repository. See [how to provide access to other repositories]({{ site.baseurl }}{% link _general/projects/access-to-other-repositories-fails-during-build.md %}) if you're not sure how to achieve this.
2. Make sure the submodule is referenced via a SSH based URL (e.g. `git@github.com:codeship/documentation.git`). If you reference the submodule via a HTTPS based URL (e.g. `https://github.com/codeship/documentation.git`), the git client will ask for authentication credentials during the build and run into a timeout (as you can't provide them).

See the git documentation on [Git Submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) for more information on working with submodules.

## Typical Error Messages

See [how to provide access to other repositories]({{ site.baseurl }}{% link _general/projects/access-to-other-repositories-fails-during-build.md %}) if you see an error like these.

```
remote: Repository not found
```

```
fatal: Could not read from remote repository
```

```
Permission denied (publickey).
```

```
Please make sure you have the correct access rights
and the repository exists.
Clone of 'git@bitbucket.com:username/reponame.git' into submodule path 'path' failed
```
