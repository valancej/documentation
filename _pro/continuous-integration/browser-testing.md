---
title: Browser Testing During CI/CD With Codeship Pro
shortTitle: Browser Testing
menus:
  pro/ci:
    title: Browser Testing
    weight: 2
tags:
  - docker
  - jet
  - browsers
  - browser testing
  - visual testing
  - frontend
  - front-end
  - chrome
  - chromium
  - chromedriver
  - firefox
  - phantomjs
  - selenium

redirect_from:
  - /docker/browser-testing/
---

* include a table of contents
{:toc}

With Codeship Pro you have many different options to set up browser testing. The following sections describe how you can install different browsers. Please check the documentation for the language/framework you are using for specifics on how to test with your browser.

## Xvfb
Before going into the details of setting up various browsers make sure to include [Xvfb](https://en.wikipedia.org/wiki/Xvfb) in your build. Running Xvfb before your browser sets up a virtual display the GUI of the various browsers can use.

Add the following to your Dockerfile to make sure Xvfb is properly started. If you use a non-Debian based Linux distribution please install the Xvfb package through the available package manager.

```dockerfile
RUN apt-get install -y xvfb
```

```shell
# The server will listen for connections as server number 1 and screen 0 will be depth 16 1600x1200
Xvfb :1 -screen 0 1600x1200x16 &
export DISPLAY=:1.0
```

Now you can start any browser that needs a screen available.

## Chrome

To get the latest version of Google Chrome simply install it from their [Debian repository](https://www.ubuntuupdates.org/ppa/google_chrome) in your Dockerfile. Additionally you need to install [ChromeDriver](https://sites.google.com/a/chromium.org/chromedriver) if you want to use Selenium with Chrome.

```dockerfile
# Starting from Ubuntu Xenial
FROM ubuntu:xenial

# We need wget to set up the PPA, Xvfb to have a virtual screen and unzip to extract ChromeDriver
RUN apt-get update
RUN apt-get install -y wget xvfb unzip

# Set up the Chrome PPA
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Update the package list and install Chrome
RUN apt-get update
RUN apt-get install -y google-chrome-stable

# Set up ChromeDriver environment variables
ENV CHROMEDRIVER_VERSION 2.30
ENV CHROMEDRIVER_DIR /chromedriver

# Download and install ChromeDriver
RUN mkdir $CHROMEDRIVER_DIR
RUN wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
RUN unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR

# Put ChromeDriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH
```

Now Chrome is installed in your path and available to use for any of your browser tests.

### Headless Chrome
Beginning in Google Chrome 59, you can run Chrome in [headless mode](https://developers.google.com/web/updates/2017/04/headless-chrome). To take advantage of this be sure your Dockerfile is using ChromeDriver 2.30 or greater.  Your application will also need to pass the `headless` and `disable-gpu` flags to Chrome. You can also remove Xvfb as it is not needed for headless mode.

## Firefox

There are two ways to install Firefox in your Dockerfile. Either through the available package manager or by downloading it directly from Mozilla. At first we're going to install it through the available package manager. Add the following to your Dockerfile:

```dockerfile
# Starting from Ubuntu Xenial
FROM ubuntu:xenial

RUN apt-get update
RUN apt-get install -y xvfb firefox
```

Now the Firefox version installed from your package manager will be available. As this sometimes doesn't fit the exact version of Firefox you want to use you can instead download and install a specific version. We will still install Firefox through the package manager as this makes sure all necessary libraries are installed. We will set the PATH to use our specific version of Firefox though.

```dockerfile
# Starting from Ubuntu Xenial
FROM ubuntu:xenial

# We need wget to download the custom version of Firefox, Xvfb to have a virtual screen, bzip2 for extracting and Firefox so all necessary libraries are installed
RUN apt-get update
RUN apt-get install -y wget xvfb bzip2 firefox

# Set up Firefox environment variables
ENV FIREFOX_VERSION 50.0
ENV FIREFOX_DIR /firefox

# Download and install Firefox
RUN wget -q --continue -P $FIREFOX_DIR "https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/en-US/firefox-${FIREFOX_VERSION}.tar.bz2"
RUN tar -xaf $FIREFOX_DIR/firefox* --strip-components=1 --directory $FIREFOX_DIR

# Setting the PATH so the custom Firefox version will be used first
ENV PATH $FIREFOX_DIR:$PATH
```

Now Firefox is installed in your path and available to use for any of your browser tests.

## PhantomJS

PhantomJS is a headless browser, thus we don't need any Xvfb setup to run tests. Simply download it, unpack it and put it into the PATH.

```dockerfile
# Starting from Ubuntu Xenial
FROM ubuntu:xenial

# We need wget to download PhantomJS and several other dependency libraries
RUN apt-get update
RUN apt-get install -y wget bzip2 libfontconfig1 libfreetype6

# Set up PhantomJS environment variables
ENV PHANTOMJS_VERSION 2.1.1
ENV PHANTOMJS_DIR /phantomjs

# Download and install PhantomJS
RUN wget -q --continue -P $PHANTOMJS_DIR "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2"
RUN tar -xaf $PHANTOMJS_DIR/phantomjs* --strip-components=1 --directory $PHANTOMJS_DIR

# Put PhantomJS into the PATH
ENV PATH $PHANTOMJS_DIR/bin:$PATH
```

Now PhantomJS is installed in your path and available to use for any of your browser tests.

## Selenium Server

To use the standalone Selenium Server you need to download the Selenium jar file in your Dockerfile.

```dockerfile
# Starting from Ubuntu Xenial
FROM ubuntu:xenial

# We need wget to download Selenium Server and openjdk-8-jdk
RUN apt-get update
RUN apt-get install -y wget openjdk-8-jdk

# Set up Selenium environment variables
ENV SELENIUM_PORT 4444
ENV SELENIUM_WAIT_TIME 10

# Download Selenium Server
RUN wget -q --continue --output-document /selenium-server.jar "http://selenium-release.storage.googleapis.com/3.4/selenium-server-standalone-3.4.0.jar"
```

Then as part of your build script you simply start the Selenium Server with the jar file and wait a few seconds for it to properly load.

```shell
java -jar /selenium-server.jar -port "${SELENIUM_PORT}" ${SELENIUM_OPTIONS} 2>&1 &
sleep "${SELENIUM_WAIT_TIME}"
echo "Selenium is now ready to connect on port ${SELENIUM_PORT}"
```

## Notes And Known Issues

### Chrome Crashing
If you are seeing Chrome crashing during your tests you may want to try modifying `/dev/shm` in `codeship-services.yml`.  Try adding the following:

```yaml
volumes:
  - /dev/shm:/dev/shm
```

### Pro Resources
If you are seeing consistent unexplained crashes during your tests it could also be a resource issue. Pro comes in different instance sizes that can be configured for more CPU and memory resources. If you suspect this might be an issue, [get in touch with us](mailto:solutions@codeship.com) and we can check out the resource utilization for your build and can try out different instance configurations.
