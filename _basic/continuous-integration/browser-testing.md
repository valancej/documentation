---
title: Browser Testing During CI/CD With Codeship Basic
shortTitle: Browser Testing
menus:
  basic/ci:
    title: Browser Testing
    weight: 1
tags:
  - browsers
  - browser testing
  - visual testing
  - frontend
  - front-end
  - chrome
  - chromium
  - chromedriver
  - firefox
  - geckodriver
  - phantomjs
  - selenium
  - capybara
  - headless
  - screenshots
  - vnc
  - testing
categories:
  - Continuous Integration
  - Testing
  - Browsers
redirect_from:
  - /continuous-integration/browser-testing/
---

* include a table of contents
{:toc}

{% csnote info %}
This article is about running browser testing in your CI/CD pipeline with Codeship Basic.

If you'd like to learn more about Codeship Basic, we recommend the [getting started guide]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}) or [the features overview page](https://codeship.com/features/basic).
{% endcsnote %}

## Chrome

Current versions of Google Chrome and Chromium are installed by default.

Google Chrome is at version 68 and is located at `/usr/bin/google-chrome`.

Chromium is at version 65 and is located at `/usr/bin/chromium-browser`.

There is a `chrome` symlink in the PATH that defaults to calling Google Chrome. You can change it to point to Chromium by adding these commands to your build steps:

```shell
ln -sf /usr/bin/chromium-browser /home/rof/bin/chrome
ln -sf /usr/bin/chromium-browser /home/rof/bin/Chrome
```

### Headless Chrome

Beginning in Google Chrome 59, you can run Chrome in [headless mode](https://developers.google.com/web/updates/2017/04/headless-chrome). To take advantage of this be sure your build is targeting Google Chrome and using ChromeDriver 2.30 or greater. Your application will also need to pass the `--headless` flag to Chrome.

## ChromeDriver

[ChromeDriver](https://sites.google.com/a/chromium.org/chromedriver) 2.41 is installed by default and available in the PATH.

To install a [custom ChromeDriver version](https://github.com/codeship/scripts/blob/master/packages/chromedriver.sh) add the following commands to your build steps:

```shell
export CHROMEDRIVER_VERSION=YOUR_DESIRED_VERSION

\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/chromedriver.sh | bash -s
```

## Firefox

[Firefox](https://www.mozilla.org/en-US/firefox/releases) 61.0.1 is installed by default and available in the PATH.

To install a [custom Firefox version](https://github.com/codeship/scripts/blob/master/packages/firefox.sh) add the following commands to your build steps:

```shell
export FIREFOX_VERSION=YOUR_DESIRED_VERSION

\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/firefox.sh | bash -s
```

### Headless Firefox

Beginning in Firefox 55, you can run Firefox in [headless mode](https://developer.mozilla.org/en-US/Firefox/Headless_mode). To take advantage of this be sure your build is targeting Firefox and using a current geckodriver version. Your application will also need to pass the `-headless` flag to Firefox.

## geckodriver

[geckodriver](https://github.com/mozilla/geckodriver) 0.21.0 is installed by default and available in the PATH.

To install a [custom geckodriver version](https://github.com/codeship/scripts/blob/master/packages/geckodriver.sh) add the following commands to your build steps:

```shell
export GECKODRIVER_VERSION=YOUR_DESIRED_VERSION

\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/geckodriver.sh | bash -s
```

## Selenium

Chrome and Firefox both work with Selenium. To support Selenium with Chrome be sure to update ChromeDriver to the desired version for your application. Please provide your own Selenium driver in your application and keep it current.

### Selenium Standalone Server

If there are no packages available for your framework or you want to use the standalone version there is a [script](https://github.com/codeship/scripts/blob/master/packages/selenium_server.sh) available for installing a custom version.

## Sauce Labs

You can use [Sauce Connect](https://wiki.saucelabs.com/display/DOCS/Sauce+Connect+Proxy) to connect the Sauce Labs browser testing service with the application running in your Codeship build.

There is a [script](https://github.com/codeship/scripts/blob/master/packages/sauce_connect.sh) available for installing Sauce Connect in the build environment. Make sure you set the username and API key or other necessary variables in the [environment configuration]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}). You can run your tests exactly the same way as you would run them on your own development machine through Sauce Connect.

## PhantomJS

[PhantomJS](http://phantomjs.org) 2.1.1 is installed by default and available in the PATH.

To install a [custom PhantomJS version](https://github.com/codeship/scripts/blob/master/packages/phantomjs.sh) add the following commands to your build steps:

```shell
export PHANTOMJS_VERSION=YOUR_DESIRED_VERSION

\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/phantomjs.sh | bash -s
```

## SlimerJS

To install the latest [SlimerJS](https://slimerjs.org) version [install a compatible Firefox version]({{ site.baseurl }}{% link _basic/continuous-integration/browser-testing.md %}#firefox) (53.0 to 59.0) and add the following command to your build steps:

```
npm install slimerjs
```

## CasperJS

To install the latest [CasperJS](http://casperjs.org) version add the following command to your build steps:

```
npm install casperjs
```

## Screenshots

During your tests you may want to generate screenshots when tests fail. Codeship Basic starts a new build machine for each build and that machine gets terminated as soon as the build finishes. As a result there is not a simple way to save screenshots from failing builds.

However, you can use a [SSH debug session]({{ site.baseurl }}{% link _basic/builds-and-configuration/ssh-access.md %}) to manually run your failing build again which will generate new screenshots. Then from another terminal window you can use `scp` to copy any screenshot files from the debug machine to your local machine for viewing.

Here is an example command. Note that the `PORT` and `IP_ADDRESS` are the same as what you use to connect to the debug session and the file path will depend on where your tests place the screenshots.

```
scp -P PORT rof@IP_ADDRESS:/home/rof/clone/screenshots/my_screenshot.png .
```

## Viewing browser tests with VNC

If your tests are running full versions of Chrome or Firefox, rather than running them in headless mode, you may want to try debugging tests by watching them run live with VNC.

To begin, start a [SSH debug session]({{ site.baseurl }}{% link _basic/builds-and-configuration/ssh-access.md %}).

Then connect to the debug session, taking note to forward port 5900:

```
ssh rof@IP_ADDRESS -p PORT -L 5900:localhost:5900
```

Now in the debug session run the following commands which will install [TigerVNC](http://tigervnc.org) and start the VNC server:

```
# Install TigerVNC
\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/tigervnc.sh | bash -s

# Set a password for the VNC session
vncpasswd

Password:
Verify:
Would you like to enter a view-only password (y/n)? n

# Start the VNC server which will export the Xvfb display server that is already running
x0vncserver -display :99 -PasswordFile=$HOME/.vnc/passwd
```

Now your VNC server should be running and ready for connections. You can connect from your local machine with your VNC client of choice. If you are using macOS, you can connect with the built in VNC client called **Screen Sharing**.

From your VNC client, connect to `localhost:5900` and enter the password you set in the step above. It should connect and show you a blank, black screen. This is expected as there are no browser tests running yet.

Now in a separate terminal window, connect back to the debug session and begin running your test commands manually. Once you start running your browser tests you should see them appear in the VNC display.
