---
title: Access To Other Repositories in Codeship Basic
shortTitle: Access To Other Repositories
menus:
  basic/builds:
    title: Access To Other Repositories 
    weight: 11
tags:
  - build error
  - ssh key
  - github
  - bitbucket
  - gitlab
  - private repository
  - private repo
  - git
  - clone
  - cloning
  - machine user
categories:
  - Projects
redirect_from:
  - /faq/access-to-other-repositories-fails-during-build/
  - /general/projects/access-to-other-repositories-fails-during-build/
  - /general/projects/access-other-repositories/
---

* include a table of contents
{:toc}

Some projects have dependencies that require access to other private repositories during the build. There are several options for configuring your project to be able to access other private repositories.

## The Default Configuration

Codeship creates a SSH key pair for each project when you first configure it. This SSH key allows Codeship to clone that main private repository by default. It will also allow Codeship to clone other public repositories on the same SCM. For example if your private repository is on GitHub, Codeship can clone your private repository and any public repository on GitHub during your build.

On Codeship you can view the SSH public key under _Project Settings > General_. This key is automatically added as a deploy key to the repository on your SCM. For example on GitHub you can see this deploy key by going to your repository and navigating to _Settings > Deploy keys_.

If your project needs to access private repositories during the build you will get a [cloning error]({{ site.baseurl }}{% link _basic/builds-and-configuration/access-to-other-repositories.md %}#typical-error-messages) and will need to do additional configuration to enable access.

## The Machine User Solution

The recommended solution for accessing other private repositories is to configure a machine user on your SCM.

- Create a [machine user](https://developer.github.com/v3/guides/managing-deploy-keys/#machine-users) on your SCM
- Remove the Codeship deploy key from the SCM (on GitHub you will find this on your repository under _Settings > Deploy keys_)
- Now add the SSH public key from your Codeship project (under _Project Settings > General_) to the machine user (this is the key that was previously added as a deploy key)
- Grant the machine user access to the main repository and any private repositories it needs to access on the SCM
- Start a new build and your project should now be able to access the private repositories

Even though the above example references GitHub, the process should be similar for Bitbucket and GitLab.

## The Personal Account Solution

As an alternative you can also apply the same process above to a personal GitHub user account instead of a machine user. Keep in mind this will allow the Codeship project to access any repository that the personal account has access to. Also note that if the personal account has permissions revoked on the SCM (for example if an employee leaves the company) then all of the Codeship projects using that account's authorization will also break.

## Related Documentation

* [Git Submodules]({{ site.baseurl }}{% link _basic/continuous-integration/git-submodules.md %})
* [Using Multiple Repositories]({{ site.baseurl }}{% link _pro/builds-and-configuration/cloning-repos.md %})

## Typical Error Messages

If your project needs to access another private repository and has not been configured yet, you may see clone errors like these:

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
