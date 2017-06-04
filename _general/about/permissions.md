---
title: Repository Permissions and Access On Codeship
layout: page
weight: 27
tags:
  - security
  - permissions
  - github
  - gitlab
  - bitbucket
  - organizations
redirect_from:
  - /troubleshooting/github-3rd-party-restrictions/
  - /faq/github-3rd-party-restrictions/
  - /general/account/github-3rd-party-restrictions/
  - /general/account/permissions/
menus:
  general/about:
  title: Permissions & Access
  weight: 4
---

* include a table of contents
{:toc}

## How Permissions Work On Codeship

Let's take a look at how Codeship manages permissions around your source control, your builds and your team.

### What do we mean by permissions?

When we say permissions, we are  talking about access you give Codeship to your source control repo, or access you give to people on your team to your Codeship builds and account information.

#### Repository permissions vs. Access permisisons ####

In terms of access you give Codeship, there are two different types that are in play: repository level permissions and access level permissions.

For Codeship to configure your repo correctly, the account that connects a repo needs to have the necessary permissions to setup a webhook etc on the repository. For this, we expect that account to have `admin` permissions (or master or owner depending on your source control system).

As for access permissons, these influence what we're allowed to do on your behalf, on a per-build basis. We need access to clone your repo, as well as report back with the test results, but not full admin permissions.

The next section explains which specific permissions we ask for, depending on your source control system.

### What permissions are needed on my source control?

As mentioned above, Codeship requires both repository and access level permissions. Depending on the source control service being used, these are called something different:

#### Github

- For setting up a new project, we need the account to have `admin` permissions.
- For regular access, we require read/write permissions to your private repositoties so that we can clone the repos and report back status.
- Like all providers that integrate with Github, we'd love to request fewer permissions than we do, but as we're currently using GiHub's Oauth integration, we're limited to the [few options GitHub provides](https://developer.github.com/v3/oauth/#scopes) (we're asking for `repo` and `user:email` scopes). We are looking to move to the new [GitHub Integration](https://developer.github.com/early-access/integrations/integrations-vs-oauth-applications/) options, to offer you more granular control, in the near future.

#### Bitbucket

- For setting up a new project, we need the account to have `master` or `owner` permissions.
- For regular access, we currently ask for full access to everything in the repository, but will change this soon to only cover reading/writing to your repos and webhooks as well as reading your email addresses (more specifically `repository:write`, `email`, and `webhook`. You can see the full list of permission options available from BitBucket [here](https://developer.atlassian.com/bitbucket/concepts/bitbucket-rest-scopes.html).

#### Gitlab
- For setting up a new project, we need the account to have `admin` permissions.
- For regular access, GitLab only offers one option (the `api` scope), which unfortunately gives us access to everything on the repo. We wish it was different, but as of now, [GitLab only provides two options](https://docs.gitlab.com/ee/integration/oauth_provider.html#authorized-applications) where only one will allow us to access your repos.

### What permissions can I assign my team members?

You can learn more about organization management on Codeship [by clicking here]({% link _general/account/organizations.md %}), but in general there are four basic security levels for teams on Codeship:

- **Owners** have control over all aspects of an organization. From changing the subscription to managing organization projects and teams.

- **Managers** have control over team and project management of an organization. They can add and remove projects and manage the organization teams by adding new team members or assigning projects to teams. They have access to all projects and are able to change the project configuration.

- **Project Managers** can manage projects the team is assigned to. They can debug builds, update test settings, or manage deployments.

- **Contributors** have read-only access to their projects. This means that they can view the project dashboard and build details but are not allowed to change project settings or open debug builds.

### "3rd Party Access Restrictions" For Organizations

**Note this only applies to Github.**

If the repositories for a GitHub organization don't show up on Codeship, please head over to the settings for the [Codeship application on GitHub](https://github.com/settings/connections/applications/457423eb34859f8eb490) and in the section labeled **Organization access** either

* _Request access_ if you are not an administrator for the organization. (Your request will then have to be approved by an admin.)
* _Grant access_ if you are an administrator.

Once this is done and access has been granted, the organizations repositories will show up in the repository selector on Codeship again.

See GitHub's help article on [3rd party restrictions](https://help.github.com/articles/about-third-party-application-restrictions/) for more background information about this feature.

### What if I'm not an admin of the repo?

If you attempt to connect a repository to a new project, and you don't have `admin` permissions on that repository, there are two things you can do:

1. The simplest option is to get `admin` permissions to the repo, which can be given to the team you're in or specifically to your user
1. The second option is to have someone else, who have `admin` permissions, setup the project for you. The flow would look like this:
    1. User with `admin` permission creates the project and connects the repo (Codeship will create a webhook and register an SSH key)
    1. Same user changes the project settings (Project settings > General > Account used for authentication) and assigns the project to you or another user with limited permissons
    1. The project can now be used by Codeship, even without having admin permissions to the repo

## Security

You can learn more about security on Codeship [by clicking here]({% link _general/about/security.md %}).

### Can Codeship staff see my code or builds?

There are two Codeship services, and staff have different levels of access for each:

- On [Codeship Basic](https://codeship.com/features/basic), with your permission, our support team can open an SSH debug session into your build machine, which allows us to see your source code.

- On [Codeship Pro](https://codeship.com/features/pro), we have no direct access to your source control, but our support team can see your builds and build logs, as well as account information.
