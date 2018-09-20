---
title: Repository Permissions and Access On Codeship
shortTitle: Repository Permissions and Access
menus:
  general/about:
    title: Required Permissions for Remote SCMs
    weight: 3
tags:
  - security
  - permissions
  - github
  - gitlab
  - bitbucket
  - organizations
  - git
categories:
  - About Codeship
  - Security
  - Account 
redirect_from:
  - /troubleshooting/github-3rd-party-restrictions/
  - /faq/github-3rd-party-restrictions/
  - /general/account/github-3rd-party-restrictions/
  - /general/account/permissions/
---

* include a table of contents
{:toc}

## How Permissions Work On Codeship

Let's take a look at how Codeship manages permissions around your source control, your builds and your team.

### What do we mean by permissions?

When we say permissions, we are  talking about access you give Codeship to your source control repo, or access you give to people on your team to your Codeship builds and account information.

#### Repository permissions vs. Access permissions ####

In terms of access you give Codeship, there are two different types that are in play: repository level permissions and access level permissions.

For Codeship to configure your Bitbucket or Gitlab repository correctly, the account that connects a repository needs to have the necessary permissions to setup a webhook etc. For this, we expect that account to have `admin` permissions (or `master` or `owner` depending on your source control system). As for access permissions, these influence what we're allowed to do on your behalf, on a per-build basis. We need access to clone your repo, as well as report back with the test results, but not full admin permissions.

Github works slightly different, as we require you to install the CodeShip Github App and allow the app access to the repositories you want to use on CodeShip. We expect you to have permission to install the app and configure it. Once the app has been installed, users who with to setup new projects mainly need to have access to the repository (and the app also need to have access).

The next section explains which specific permissions we ask for, depending on your source control system.

### What permissions are needed on my source control?

As mentioned above, Codeship requires both repository and access level permissions. Depending on the source control service being used, these are called something different:

#### Github

- For setting up a new project, we need the CodeShip Github App installed on your Github organization, and access to the necessary repositories via that app. We'll help you set things up when you create your first project, and once the app is installed you only need to make sure it has access to the repository you want to use in your new project.
- The CodeShip Github App will ask for permissions to:
  - Read your code
  - Read metadata for your organization (default permission [set by Github](https://developer.github.com/apps/building-github-apps/setting-permissions-for-github-apps/))
  - Read and Write access to administer your project and set commit status (this is a combined permission, without it we can't update commit status)
- For regular user access, aside from the default access, we only ask to read your email, in case we need to get in contact with you
  - The default permissions mainly allows us to see what resources you have access to (e.g. which organizations you're connected to, and if they have the CodeShip app installed). We cannot change these permissions as they're controlled by Github

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

If you attempt to connect a repository to a new project, and you don't have `admin` permissions on that repository (or, for Github don't have permission to install the CodeShip Github App), there are two things you can do:

1. The simplest option is to get `admin` permissions to the repo, which can be given to the team you're in or specifically to your user
1. (Non Github): The second option is to have someone else, who have `admin` permissions, setup the project for you. The flow would look like this:
    1. User with `admin` permission creates the project and connects the repo (Codeship will create a webhook and register an SSH key)
    1. Same user changes the project settings (Project settings > General > Account used for authentication) and assigns the project to you or another user with limited permissions
    1. The project can now be used by Codeship, even without having admin permissions to the repo
1. (Github Only): you can get a user with sufficient rights to install the CodeShip Github App and provide it access to the repositories you need, and then proceed to setup the new projects. During the setup the app will retrieve the repositories available to it and you can select the one you want for your new project

## Security

You can learn more about security on Codeship [by clicking here]({% link _general/about/security.md %}).

### Can Codeship staff see my code or builds?

There are two Codeship services, and staff have different levels of access for each:

- On [Codeship Basic](https://codeship.com/features/basic), with your permission, our support team can open an SSH debug session into your build machine, which allows us to see your source code.

- On [Codeship Pro](https://codeship.com/features/pro), we have no direct access to your source control, but our support team can see your builds and build logs, as well as account information.
