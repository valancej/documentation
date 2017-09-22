---
title: Integrating Codeship With Firebase
shortTitle: Integrating Codeship With Firebase
tags:
  - integrations
  - db
  - databases
  - fire base
  - firebase
menus:
  general/integrations:
    title: Using Firebase
    weight: 19
---

* include a table of contents
{:toc}

## About Firebase

[Firebase](https://firebase.google.com/) is a cloud platform for handling operations and data for mobile and web applications.

By using Firebase you can streamline a variety of data and account operations for your cloud application.

The [Firebase documentation](https://firebase.google.com/docs/) provides a great guide to getting started, and the instructions below have more information on integrating with [Codeship Basic](https://codeship.com/features/basic) and [Codeship Pro](https://codeship.com/features/pro).

## Codeship Pro

### Installing Firebase

To use Firebase with Codeship Pro, you'll need to install the `firebase-tools` CLI.

This CLI is packaged with NPM, so you will need a service defined in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) with Node and NPM installed.

Inside the service with Node and NPM installed, you will next need to either add `firebase-tools` to your `package.json` and run `npm install` inside your Dockerfile, or add the following line directly to your Dockerfile:

```bash
RUN npm install firebase-tools
```

### Adding Firebase Token

After installing the Firebase Tools CLI into your service, you will need to add at least your `FIREBASE_TOKEN` via the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

Depending on how your app uses Firebase, or how you deploy to Firebase, you may want to set other environment variables as well. Some values you may need to set are:

- `apiKey`
- `authDomain`
- `databaseURL`
- `storageBucket`

What environment variables are required depends on which Firebase services and commands you are trying to use, and the [Firebase documentation](https://firebase.google.com/docs/) can provide more specific instructions.

### Using Firebase

If your main application uses Firebase as a database or for other services, simply installing the Firebase Tools CLI in the service the application runs in and setting the required environment variables via your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) should be all that is required.

However, if you need to pass the Firebase Tools CLI specific commands - such as deploying your static site to Firebase - you can simply add those commands as steps in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

For example:

```yaml
- name: Deploy To Firebase
  service: app
  command: bash -c "firebase deploy --token ${FIREBASE_TOKEN} --project ${PROJECT_NAME}"
```

**Note** that in this example `app` would be the service defined in the [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) with the Firebase Tools CLI installed.

## Codeship Basic

### Installing Firebase

To use Firebase with Codeship Basic, you'll need to install the `firebase-tools` CLI using `npm` in your project's [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

**Note** that you will also need to specify what version of Node you require using `nvm`, as the default Node version is older than the minimum required for the Firebase Tools CLI.

For example:

```bash
nvm install $VERSION
npm install -g firebase-tools
```

### Adding Firebase Token

After installing the Firebase Tools CLI, you will need to add your `FIREBASE_TOKEN` to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

Depending on how your app uses Firebase, or how you deploy to Firebase, you may want to set other environment variables as well. Some values you may need to set are:

- `apiKey`
- `authDomain`
- `databaseURL`
- `storageBucket`

What environment variables are required depends on which Firebase services and commands you are trying to use, and the [Firebase documentation](https://firebase.google.com/docs/) can provide more specific instructions.

### Using Firebase

If your main application uses Firebase as a database or for other services, simply installing the Firebase Tools CLI and setting the required environment variables via your [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}) should be all that is required.

However, if you need to pass the Firebase Tools CLI specific commands - such as deploying your static site to Firebase - you can simply add those commands to either your [setup, test or deployment commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

For example, you can add the `firebase deploy` command to a [custom-script deployment pipeline]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}):

```yaml
firebase deploy --token "$FIREBASE_TOKEN" --project "$PROJECT_NAME"
```
