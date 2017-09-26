---
title: Using Ghost Inspector And Codeship For UI And Browser Testing
shortTitle: Ghost Inspector Browser Testing
menus:
  general/integrations:
    title: Using Ghost Inspector
    weight: 7
tags:
- screenshots
- visual testing
- browsers
- browser testing
- integrations

---

* include a table of contents
{:toc}

## About Ghost Inspector

[Ghost Inspector](https://ghostinspector.com/docs/integration/codeship/) lets you write and run UI and browser tests as part of your builds without configuring local servers and managing your own browsers.

By using Ghost Inspector you can easily test your UI without complex browser testing overhead.

[Their documentation](https://ghostinspector.com/docs/) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your API Keys

You will need to add your Ghost Inspector API key and suite ID to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

###  Triggering The Suite

Next, you will need to add the following commands to a script, placed in your repository, that you will call from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):


```yaml
- name: Ghost Inspector
  service: app
  command: ghost-inspector.sh
```

Inside the script, you will need the following Ghost Inspector commands:

```shell
# Execute Ghost Inspector suite via API and store results in JSON file
curl "https://api.ghostinspector.com/v1/suites/$GHOST_SUITE_ID/execute/?apiKey=$GHOST_API_KEY" > ghostinspector.json

# Check JSON results for failing tests
if [ $(grep -c '"passing":false' ghostinspector.json) -ne 0 ]; then exit 1; else echo "Tests Passed"; fi
```

### Advanced Testing

For a more complex setup with more granular control, Ghost Inspector recommends setting up and using an `ngrok` tunnel to triggering the Ghost Inspector test suite.

To do this, you will want to change the script you run from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) to the following:

```shell
# Start our application (Command needs to be customized)
node server.js &

# Download ngrok and unzip
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
chmod +x ngrok

# Download JSON parser for determining ngrok tunnel
wget https://stedolan.github.io/jq/download/linux64/jq
chmod +x jq

# Intialize ngrok and open tunnel to our application (Port 3000 needs to be customized)
./ngrok authtoken $NGROK_TOKEN
./ngrok http 3000 > /dev/null &

# Execute Ghost Inspector suite via API using the ngrok tunnel and store results in JSON file
curl "https://api.ghostinspector.com/v1/suites/$GHOST_SUITE_ID/execute/?apiKey=$GHOST_API_KEY&startUrl=$(curl 'http://localhost:4040/api/tunnels' | ./jq -r '.tunnels[1].public_url')" > ghostinspector.json

# Check JSON results for failing tests
if [ $(grep -c '"passing":false' ghostinspector.json) -ne 0 ]; then exit 1; else echo "Tests Passed"; fi
 ```

## Codeship Basic

### Setting Your API Keys

You will need to add your Ghost Inspector API key and suite ID to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

###  Triggering The Suite

Once your Ghost Inspector credentials are loaded via your environment variables, you will want to run the following commands, directly or via a script, in your project's [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

```shell
# Execute Ghost Inspector suite via API and store results in JSON file
curl "https://api.ghostinspector.com/v1/suites/$GHOST_SUITE_ID/execute/?apiKey=$GHOST_API_KEY" > ghostinspector.json

# Check JSON results for failing tests
if [ $(grep -c '"passing":false' ghostinspector.json) -ne 0 ]; then exit 1; else echo "Tests Passed"; fi
```

### Advanced Testing

For a more complex setup with more granular control, Ghost Inspector recommends setting up and using an `ngrok` tunnel to triggering the Ghost Inspector test suite.

To do this, you will want to add the following code to a script in your repository that you run in your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

```shell
# Start our application (Command needs to be customized)
node server.js &

# Download ngrok and unzip
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
chmod +x ngrok

# Download JSON parser for determining ngrok tunnel
wget https://stedolan.github.io/jq/download/linux64/jq
chmod +x jq

# Intialize ngrok and open tunnel to our application (Port 3000 needs to be customized)
./ngrok authtoken $NGROK_TOKEN
./ngrok http 3000 > /dev/null &

# Execute Ghost Inspector suite via API using the ngrok tunnel and store results in JSON file
curl "https://api.ghostinspector.com/v1/suites/$GHOST_SUITE_ID/execute/?apiKey=$GHOST_API_KEY&startUrl=$(curl 'http://localhost:4040/api/tunnels' | ./jq -r '.tunnels[1].public_url')" > ghostinspector.json

# Check JSON results for failing tests
if [ $(grep -c '"passing":false' ghostinspector.json) -ne 0 ]; then exit 1; else echo "Tests Passed"; fi
 ```
