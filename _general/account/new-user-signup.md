---
title: Signing Up For A New Codeship Account
shortTitle: Signing Up For A New Account
menus:
  general/account:
    title: New User Signup
    weight: 1
tags:
- account
- scm
- svn
- badge
- avatar
- gravatar
- getting started
categories:
  - Account
  - Guide
redirect_from:
  - /general/about/other-scm/
  - /general/account/configure-your-avatar/
  - /faq/codeship-badge/
  - /general/about/codeship-badge/
  - /faq/configure-your-avatar/
  - /faq/other-scm/
weight: 1
---

* include a table of contents
{:toc}

## Setting Up A New Codeship Account

If you're looking to sign up and create a project on Codeship, this guide will walk you through the initial onboarding process.

### Signing Up

To **sign up**, [navigate to our signup page](https://app.codeship.com/registrations/new).  You can sign up either via your Source Code Management (SCM) or email address.  SCMs we currently support are: GitLab, Bitbucket, or GitHub.

Note that these oAuth login pages come directly from the SCM tools themselves and we do not have access to them or to the credentials you provide.

![SCM Choice]({{ site.baseurl }}/images/new-user-setup/scm-choice.png)

- **Via GitHub:**  After selecting GitHub, you are automatically navigated to a login page where you must enter your GitHub login credentials in order to give Codeship access to your account.

![Github Login]({{ site.baseurl }}/images/new-user-setup/gh-login.png)

- **Via Bitbucket:**  After selecting Bitbucket, you are automatically navigated to a login page where you must enter your bitbucket login credentials in order to give Codeship access to your account.

![Bitbucket Login]({{ site.baseurl }}/images/new-user-setup/bb-login.png)

- **Via GitLab:** After selecting GitLab, you are automatically navigated to a login page where you must enter your GitLab login credentials in order to give Codeship access to your account.

![GitLab Login]({{ site.baseurl }}/images/new-user-setup/gl-login.png)

- **Via Email:**   If you prefer to not sign up for Codeship via an SCM, you may also sign up via email.  You simply provide your: Name, Email Address, and create a Password, then hit ‘Sign up for free’.

![Email Login]({{ site.baseurl }}/images/new-user-setup/email-login.png)

*You can learn more about the permissions we ask when authenticating with SCM [here](https://documentation.codeship.com/general/account/permissions/).  Learn more about security at Codeship [here](https://documentation.codeship.com/general/about/security/).*

**Note**: When signing up using your email, we won't know what your git username is, which means that your personal dashboard (aka your home page) won't be populated with your builds. To get your builds to show up, head over to your [Connected Services](https://app.codeship.com/authentications) page and enter your git username(s) there.

### New Account Setup

Once you’ve signed up, unless you were invited by a team member to an existing organization, you will be asked to create your account / organization. Account names must be unique since, you will be able to access your account with a unique URL - `app.codeship.com/<your-account-name>`.

* Organization accounts are free to start and offer 100 free private builds per month and unlimited open source builds.
* Organization accounts offer [centralized team management and team permissions]({{ site.baseurl }}/general/account/organizations/).

![Account Creation Page]({{ site.baseurl }}/images/new-user-setup/organization-creation.png)

_In case you are expecting to be invited to an already existing organization, you will find the email you signed up with - sometimes less obvious for oauth signup - on the organization creation page._

### First Steps After Account Creation

Right after account creation, you can either create your first project right away or begin setting up your teams and inviting your colleagues.

#### Invite Relevant Team Members

If you need to invite your team members to help you set your first projects up, this can be done on the Teams page.

We recommend inviting people to the _Managers_ team if they will need to create or delete projects or manage additional team members. [Read more]({{ site.baseurl }}/general/account/organizations/#managing-teams-and-projects) about the team management and permissions.

#### Create Your First Project

**Authenticate SCM:**  If you signed up for Codeship via GitLab, Bitbucket, or Github, your SCM is already authenticated!  If you’ve signed up via email, you authenticate your SCM here:

![Email Login]({{ site.baseurl }}/images/new-user-setup/authenticate-scm.png)

Simply click on the SCM icon you would like to connect with and proceed to provide your login credentials in order to give Codeship access to your account (see step 1 for further information).

**Choose your repository:** Once you have authenticated with your SCM provider, you will need to specify the code repository for the project.  Simply paste your Git clone URL into the provided area and click ‘Connect’. Note that a repository can only be connected to one project, and a project can only have one repository.

_Examples_:
- git@gitlab.com:<username>/<repository_name>.git
- https://username@gitlab.com/<username>/<repository_name>.git
- https://gitlab.com/<username>/<repository_name>.git

![Bitbucket Repo]({{ site.baseurl }}/images/new-user-setup/bb-repo.png)

![Github Repo]({{ site.baseurl }}/images/new-user-setup/gh-repo.png)

![Gitlab Repo]({{ site.baseurl }}/images/new-user-setup/gl-repo.png)

Now that you’ve connected your repository, it’s time to select your infrastructure!  You can choose to set up your project with [Codeship's Basic Infrastructure.](https://codeship.com/features/basic) or [Codeship's Pro Infrastructure.](https://codeship.com/features/pro)


**Basic** is a good place to start if:

- You want out of the box configuration
- You can use common, pre-installed CI dependencies
- You would prefer easy, 1-click app integrations

**Pro** is a good place to start if:

- Native Docker support
- Fully customizable CI environment
- Local build runner for test consistency

Once you've decided on the infrastructure you’d like to use, simply click ‘Select Infrastructure’ on the corresponding project.

![Select Codeship Infrastructure]({{ site.baseurl }}/images/new-user-setup/select-infra.png)

## Supported Source Control Providers

Codeship currently supports [GitHub](https://github.com/), [GitLab](https://gitlab.com/), and [Bitbucket](https://bitbucket.org/) based repositories.

There are no plans to integrate with other SCM tools like Subversion.

## Adding Status Badges To Your Repo

If you want to add a badge showing your last builds status to your ReadMe, you can find the code in the **Notification** settings of your project.

![Codeship Status for codeship/documentation](https://codeship.com/projects/0bdb0440-3af5-0133-00ea-0ebda3a33bf6/status?branch=master)

The raw URL for the image looks like the this:

```
https://codeship.com/projects/YOUR_PROJECT_UUID/status?branch=master
```

The UUID for a specific project is available on the **General** tab in your project settings.

## Configuring Your Avatar

Git identifies people by your e-mail and Codeship uses your Gravatar settings for your profile picture. If you have not set up Gravatar yet and want to change the avatar shown on Codeship and in your commit messages, please head over to [Gravatar.com](http://www.gravatar.com/) and setup an avatar for both the email address you configured in your Codeship [Account Settings](https://app.codeship.com/user/edit) as well as for any email addresses you use in your git configuration.

You can check the latter via running the following command in your local git checkout.

```shell
# global configuration
git config --global --get user.email

# project specific (local) configuration
git config --get user.email
```

Note that different projects can have different email addresses configured and that your VCS can have other email addresses configured for the actions you take via their interfaces.

## Keyboard Shortcuts

To make it easier to navigate through your Codeship projects, we've provided several keyboard shortcuts for quickly jumping through the interface:

- `gp`, available from inside your projects, will return you to your projects overview page
- Escape key, available on your projects overview page, will return you to the previous page
- Arrow keys, available on your projects overview page, will navigate between your projects
- Enter key, available on your projects overview page, will select the highlighted project
