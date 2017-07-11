---
title: Migrating From Jenkins To Codeship - Notifications
menus:
  general/account:
    title: Jenkins To Codeship - Notifications
    weight: 7
tags:
  - jenkins
  - notifications
  - migrating

---

* include a table of contents
{:toc}

We often get questions regarding the differences and migration path from Jenkins to Codeship. Here, we’ll walk through the almost effortless ways to migrate your notifications from Jenkins to Codeship. For those that aren’t using Jenkins, this documentation will still convey ways that could be used to migrate from any number of privately managed, hosted, and maintained build servers.

Jenkins is a build server used by many developers, but as practices have matured and more streamlined tooling is needed, your development team may be dissatisfied with the granular treatment to the continuous integration and delivery process that Jenkins provides.

In just the last few years, software development has matured in a number of ways. With new agile practices and tooling to advance these practices and draw efficiencies where they didn’t exist before, effective steps forward have been made. With these strides forward we have needed to gain more insight, metrics, and information to make decisions on our respective development efforts.

It’s important to keep informed of your team’s work. You need to know when new builds are pushed and when they have succeeded or failed. In the following samples, we’ve detailed some of the notifications that can be used to help your team stay informed of their builds.

## Replicating the Jenkins Notification Setup on Codeship

Jenkins has a number of ways to notify you of build status, commit information, and a whole host of other points of information. To implement most of these, Jenkins requires you to use a plugin of some type and then configure that plugin.

Because of the number of options, Jenkins can become a time-consuming tool to manage. Each type of notification system—Slack, GitHub, etc.—requires individual, cumbersome plugin installation and management. For self-managed servers or hosted servers, the support experience also differs, with more than a few of the hosted Jenkins providers opting to disallow many plugins and only support or implement the authorized plugins.

Here’s a shortlist of notifications that are useful to maintain consistent visibility, with respective links to get them set up on Codeship:

- [GitHub Status API](https://github.com/blog/1227-commit-status-api)
- [Set up email notification](https://codeship.com/user/edit)
- [Chrome Notifications with Codeship’s Shipscope](https://chrome.google.com/webstore/detail/shipscope/jdedmgopefelimgjceagffkeeiknclhh)
- [Codeship Slack integration](https://blog.codeship.com/codeship-slack/)
- [Flowdock and Grove.io](https://blog.codeship.com/grove-and-flowdock/)

Of course among all of these notifications and pieces of information, the most common type is still the simple build failed or build succeeded notification.

## Setting Up Build Notifications on Codeship

Smart Notifications are a key feature of Codeship.

[Codeship Pro]({% link _pro/quickstart/getting-started.md %}) uses commands inside containers. Because of this, you can define your own notifications per the baked container images however the need arises. This also provides the advantage of being part of the actual application system versus being part of the build tooling. This removes the need for plugins and adds the advantage of being able to reuse notifications for monitoring within the deployed application.

[Codeship Basic](https://codeship.com/features/basic), too, provides a lot of granular build notification options, giving you good visibility into the health of your projects.

Migrating notifications from Jenkins to Codeship is pretty easy. What generally works best is to begin with a list of notification types that your team uses and then reimplement each of those specific to the teams that want the particular notification.

Following are a few ways to get notified of build status or related information with Codeship.

## The Codeship Slack Integration

Codeship’s Slack integration works with webhooks to deliver updates to builds and related information.

![Slack Screenshot]({{ site.baseurl }}/images/jenkins-guide/slack_screenshot.png)

You can implement this by going to your Slack team's "Apps & Integrations" settings, search for "Codeship" and click the app that shows up.
Once on the app, you can select to create a new configuration via the button on the left hand side, and you'll see the following screen:

![Slack Setup Screenshot]({{ site.baseurl }}/images/jenkins-guide/slack_screenshot_two.png)

Select the channel you want the notifications to be posted in and click "Add Codeship Integration". On the following screen you will find the webhook URL you need to configure Codeship notifications.

![Slack Setup Screenshot]({{ site.baseurl }}/images/jenkins-guide/slack_screenshot_three.png)

Copy the webhook and head to your the Codeship project you want to setup with notifications. In the project settings -> notifications tab, you will be able to add the Slack integration to one or more branches or branch matches.
To add a Slack notification, simply click either of the Add buttons (supply the branch if you're setting up a new rule), select Slack, paste in your webhook URL, and select which events you want the notification to trigger on:

![Slack Setup Screenshot]({{ site.baseurl }}/images/jenkins-guide/codeship_notifications.png)

If you want different branches to send notifications to the same channel, simply re-use the webhook you just created. If you want to have notifications to different channels, you will need to create multiple integrations on Slack and copy the respective webhook URLs to Codeship.

## The Codeship HipChat Integration

The HipChat plugin for Atlassian’s chat client provides notifications for builds and additional information and links back to commits. 

To setup this Codeship to send notifications to Hipchat, first go to your Hipchat team's integrations page and find the Codeship integration.

![Hipchat Setup Screenshot]({{ site.baseurl }}/images/jenkins-guide/hipchat_one.png)

![Hipchat Setup Screenshot]({{ site.baseurl }}/images/jenkins-guide/hipchat_two.png)

Once the integration have been added, you are given a token which you will need to setup Codeship. 

![Hipchat Setup Screenshot]({{ site.baseurl }}/images/jenkins-guide/hipchat_three.png)

Copy the token and go to your Codeship project you want to setup with notifications. In the project settings -> notifications tab, you will be able to add the Hipchat integration to one or more branches or branch matches.
To add a Hipchat notification, simply click either of the Add buttons (supply the branch if you're setting up a new rule), select Hipchat, paste in the token, supply a channel name and select which events you want the notification to trigger on:

![Hipchat Setup Screenshot]({{ site.baseurl }}/images/jenkins-guide/hipchat_codeship.png)

The token is good for any notification rule you want to create; just make sure to supply the right channel name so that notifications are sent to the right people. If you want notifications to be sent to multiple channels for the same branch, you will have to create multiple rules as each one only handles one channel name.

## Google Chrome Browser notifications with Codeship’s Shipscope

Codeship has a browser component called [Shipscope](https://chrome.google.com/webstore/detail/shipscope/jdedmgopefelimgjceagffkeeiknclhh) ([GitHub repo](https://github.com/codeship/shipscope)) that we [introduced in 2014](https://blog.codeship.com/codeship-notifications-desktop-shipscope/). It provides an immediate status of the builds for various projects, as shown here.

![Shipscope Screenshot]({{ site.baseurl }}/images/jenkins-guide/shipscope.png)

## Conclusion

After many conversations, we found that the management and upkeep of plugins on Jenkins over time weren’t working for a lot of development teams, as they might not for you. With Codeship, we aim to provide a more developer-friendly solution that focuses on transitioning from existing setups easily and quickly. Removing any maintenance of plugins or other components helps our users stay focused on their application code.

In this article, we’ve covered [Slack](https://slack.com), [HipChat](http://hipchat.com), and our [Google Chrome Shipscope App](https://github.com/codeship/shipscope). There are other options worth reviewing of course, such as GitHub and GitLab Pull Requests and more.  We hope it’s been useful for you to learn about the options for migrating notifications from Jenkins to Codeship.

Now that you know how to migrate your notifications from Jenkins to Codeship we suggest looking into our other walk-throughs:

- [Migrating your Tests from Jenkins to Codeship](https://documentation.codeship.com/general/account/guides/migrating-from-jenkins-testing/)
- [Migrating your Organizations, Users, and Permissions from Jenkins to Codeship](https://documentation.codeship.com/general/account/guides/migrating-from-jenkins-organizations/)

You also might be interested in downloading these migration guides as PDFs. You can do so here.

- [Migrating your Tests from Jenkins to Codeship (pdf)](https://resources.codeship.com/hubfs/Codeship_Migrating_from_Jenkins_to_Codeship-Testing.pdf)
- [Migrating your Organizations, Users, and Permissions from Jenkins to Codeship (pdf)](https://resources.codeship.com/hubfs/Codeship_Migrating_from_Jenkins_to_Codeship-Organizations_Roles_and_Users.pdf)
- [Migrating your Notifications from Jenkins to Codeship (pdf)](https://resources.codeship.com/hubfs/Codeship_Migrating_from_Jenkins_to_Codeship-Testing.pdf)
