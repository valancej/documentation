---
title: Configure Your Avatar
layout: page
tags:
  - faq
  - avatar
  - gravatar
categories:
  - faq
---

To change the avatar shown on Codeship, please head over to [Gravatar.com](http://www.gravatar.com/) and setup an avatar for both the email address you configured in your Codeship [Account Settings](https://codeship.com/user/edit) as well as for any email addresses you use in your git configuration.

You can check the latter via running the following command in your local git checkout.

```shell
# global configuration
git config --get user.email

# project specific (local) configuration
git config --get user.email
```

Note that different projects can have different email addresses configured and that GitHub / Bitbucket can have other email addresses configured for the actions you take via their interfaces.
