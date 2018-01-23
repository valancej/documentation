---
title: Two-Factor Authentication
shortTitle: Two-Factor Authentication
description: Enabling and using Two-Factor Authentication (2FA) on Codeship
menus:
  general/about:
    title: Two-Factor Authentication
    weight: 5
tags:
  - security
  - 2fa
  - locked account
  - recovery codes
  - two factor
  - authentication
categories:
  - About Codeship
---

* include a table of contents
{:toc}

## What is Two-Factor (2FA) Authentication?

Two-Factor Authentication (more commenly refered to as 2FA) is a way to secure online accounts further by requiring more than just your username and password. There are different approaches to this, but in most cases 2FA relies on the user having a personal device (phone, tablet etc.) that the user is in full control over. If an online service is compromised and usernames + passwords are stolen, the hackers wouldn't be able to access account where 2FA is enabled as they wouldn't have access to the user's personal device.

### How does 2FA work?

There are a couple of different approaches to 2FA, some are purely app-based while others require you to have a special piece of hardware that can generate unique codes. 
In all cases you will be asked for a unique code as part of loggin in the online service, and the unique code is deliveres to/by your personal device.

For our implementation on Codeship, we have chosen to rely on mobile apps that can generate the unique codes. These apps will continuously generate one-time use codes that are only valid for a short period of time. The apps rely on a shared unique code between codeship and the specific app, to ensure that only the app on your personal device is able to generate the correct codes; it's impossible for someone to generate the same codes, at the same time, on their own device.

### Authenticator Apps

Depending on your mobile OS, you can get one of these apps: [Google Authenticator](https://support.google.com/accounts/answer/1066447) (iOS, Android, Blackberry) or [Authenticator](https://www.microsoft.com/en-us/store/p/authenticator/9wzdncrfj3rj) (Windows Phone). 
There are a lot of other authenticator apps available, so check your app store if you're looking for something else than what either of these two offer.

## Enabling 2FA

Once you have decided on an authenticator app, and have installed it on your device, you can go to your Personal Settings in codeship and enable 2FA.

When you enable 2FA we will display a unique QR code that you will need to scan with your authenticator app. This is how an (automatically generated) shares secret is agreed upon between codeship and your app.

Next, you will be asked to provide a valid code from your authenticator app. You will start to get codes generated once the app have scanned the QR code and have finished it's setup. The setup on Codeship will not be complete until you've entered a code, to make sure that everything works as it's supposed to.
If something goes wrong in setting up the app, simply cancel out of enabling 2FA and try again. As long as the we haven't been able to validate a code from your authenticator app, your setup will not change.

### Recovery Codes

Accidents happen, and you may end up in the situation where you've either lost your personal device, or for some reason it's no longer working and can no longer generate codes for you. In this case it's important that you have downloaded the recovery codes made available when you setup 2FA. 
Once the setup is complete a link will appear, which will allow you to download a set of recovery codes. These can be used in case your don't have your personal device, so make sure to keep them safe. If someone else should get hold of them (as well as your username and password) they would be able to get access to your account, without having the authenticator app on your personal device.

## Using Recovery Codes

If you've lost your personal device, or for other reasons can't generate codes, you can use one of your recovery codes to get access to your account and re-setup 2FA. 

When asked for a 2FA code, select to use a recovery code instead. This will take you to a different view where you can enter one of your recovery codes. Note that these codes are one-time use as well and will not work again later on. If you do use a recovery code, make sure you either turn off 2FA or setup another authenticator app to replace your old one. You shouldn't use recovery codes on a regular basis.

## Recovering Your Account

In the event that you have lost your device (or authenticator app) as well as your recovery codes, we're unfortunately unable to help you recover your account. To avoid hackers using "social engineering" (i.e. tricking us into thinking they're you) to gain access to your account, we don't have the ability to turn off 2FA on your account or otherwise reset it.
This is why it's important to remember to download your recovery codes before it's too late.

## Disabling 2FA

If you need to disable 2FA, simple access your account, navigate to your Personal Settings, and disable 2FA.