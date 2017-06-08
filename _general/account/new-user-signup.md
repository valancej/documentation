---
title: Signing Up For A New Codeship Account
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

**Sign up** [Navigate to our signup page](https://codeship.com/registrations/new).  You can sign up either via your Source Code Management (SCM) or email address.  SCMs we currently support are: GitLab, Bitbucket, or GitHub.

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

### New User Setup

Once you’ve signed-up for Codeship you’ll be directed to a short form where we ask a few questions about your team size and type of product you’re looking for.  We ask these questions so that we can get a better sense of what you’d like to achieve with Codeship and so that we can direct you to the correct resources/help.

![Email Login]({{ site.baseurl }}/images/new-user-setup/new-user-form.png)

**Authenticate SCM:**  If you signed up for Codeship via GitLab, Bitbucket, or Github, your SCM is already authenticated!  If you’ve signed up via email, you authenticate your SCM here:

![Email Login]({{ site.baseurl }}/images/new-user-setup/authenticate-scm.png)

Simply click on the SCM icon you would like to connect with and proceed to provide your login credentials in order to give Codeship access to your account (see step 1 for further information).

**Choose your repository:** Once you have authenticated your SCM you have to select your repository.  To choose your repository, simply paste your Git clone URL into the provided area and click ‘Connect’.

_Examples_:
- git@gitlab.com:<username>/<repository_name>.git
- https://username@gitlab.com/<username>/<repository_name>.git
- https://gitlab.com/<username>/<respository_name>.git

![Bitbucket Repo]({{ site.baseurl }}/images/new-user-setup/bb-repo.png)

![Github Repo]({{ site.baseurl }}/images/new-user-setup/gh-repo.png)

![Gitlab Repo]({{ site.baseurl }}/images/new-user-setup/gl-repo.png)

Now that you’ve connected your repo, it’s time to select your infrastructure!  You simply have to decide if you want to set up your project with [Codeship's Basic Infrastructure.](https://codeship.com/features/basic) or [Codeship's Pro Infrastructure.](https://codeship.com/features/pro)


**Basic** is a good place to start if:

- You want out of the box configuration
- You can use common, pre-installed CI dependencies
- You would prefer easy, 1-click app integrations

**Pro** is a good place to start if:

- Native Docker support
- Fully customizable CI environment
- Local build runner for test consistency

Once you know which type of infrastructure you’d like to use, simply click ‘Select Infrastructure’ on the corresponding project.

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

Git identifies people by your e-mail and Codeship uses your Gravatar settings for your profile picture. If you have not set up Gravatar yet and want to change the avatar shown on Codeship and in your commit messages, please head over to [Gravatar.com](http://www.gravatar.com/) and setup an avatar for both the email address you configured in your Codeship [Account Settings](https://codeship.com/user/edit) as well as for any email addresses you use in your git configuration.

You can check the latter via running the following command in your local git checkout.

```shell
# global configuration
git config --global --get user.email

# project specific (local) configuration
git config --get user.email
```

Note that different projects can have different email addresses configured and that your VCS can have other email addresses configured for the actions you take via their interfaces.
