---
title: Using Ionic In CI/CD with Codeship Basic
shortTitle: Ionic
tags:
 - ionic
 - cordova
 - mobile
 - npm
 - framework
menus:
  basic/languages:
    title: Ionic
    weight: 11
categories:
  - Languages And Frameworks  
---

* include a table of contents
{:toc}

## Setup
If your app is built on the [Ionic framework](https://ionicframework.com) you can easily install the [Ionic CLI](https://ionicframework.com/docs/cli) in your build.

First, if your project is not already setting a current Node version you will need to [install]({{ site.baseurl }}{% link _basic/languages-frameworks/nodejs.md %}#versions-and-setup) at least Node 6:

```
nvm install 6
```

Next you can install Ionic with NPM:

```
npm install -g ionic@latest
```

You should now be able to use any `ionic` [commands](https://ionicframework.com/docs/cli/commands.html) you need.

## Dependencies

Any other dependencies for your project can be installed with [NPM or Yarn]({{ site.baseurl }}{% link _basic/languages-frameworks/nodejs.md %}#dependencies).

## Testing

There are a variety of different tools you might use to test your Ionic app. Ionic provides a [detailed example](https://github.com/ionic-team/ionic-unit-testing-example) that describes doing unit testing and end-to-end (e2e) testing with Karma and Jasmine.
