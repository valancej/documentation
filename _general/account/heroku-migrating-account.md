---
title: Migrating From A Heroku Account
shortTitle: Migrating From A Heroku Account
menus:
  general/account:
    title: Heroku Account
    weight: 7
tags:
- heroku
- account
categories:
  - Account
---

* include a table of contents
{:toc}

## Heroku Add-on Accounts

Codeship Basic plans are offered via Heroku add-ons directly via your Heroku account.

Accounts set up via Heroku add-ons *can not* add a Codeship Pro subscription and Codeship support has limited access to billing-related issues due to Heroku owning the underlying account.

If you are using an account set up via a Heroku add-on and wish to expand to using Codeship Pro, you will need to follow the migration instructions below.

## Migrating From A Heroku Account

To migrate from a Heroku add-on account, you will want to create a new organization. You can read our [organization's documentation]({{ site.baseurl }}/general/account/organizations/) for steps on doing so.

Once you have created a new organization, you will want to [transfer your existing projects]({{ site.baseurl }}/general/account/organizations/#transfer-a-project-to-an-organization) to the new organization. Then, you can add your billing info to the new organization and sign up for any generally available Codeship plan.

We also recommend you [contact our sales team](mailto:solutions@codeship.com) to let them know of the migration and to assist with the project transfer and billing change.
