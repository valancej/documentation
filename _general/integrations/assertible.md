---
title: Using Assertible and Codeship For API testing
shortTitle: Assertible API testing and monitoring
menus:
  general/integrations:
    title: Using Assertible
    weight: 14
tags:
- apis
- api testing
- service testing
- integration testing
- functional testing
- smoke testing
- integrations
- reporting
- monitoring
- notifications
categories:
  - Integrations
---

* include a table of contents
{:toc}

## About Assertible

[Assertible](https://assertible.com) is an API testing and monitoring tool that can be used with continuous integration and delivery services like [Codeship](https://codeship.com) to test and validate your web applications.

By using Assertible you can ship more reliable code for your teams and your customers.

The [Assertible documentation](https://assertible.com/docs) provides a great guide to getting started, and the instructions below have more information on integrating with [Codeship](https://codeship.com) to [run integration tests during CI](#triggering-tests-during-a-build) and [test your web app after a deployment](#running-tests-after-a-deployment).

## Codeship Pro

### Setting your API token

To run your Assertible API tests on Codeship, you will need to add two values to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

- `ASSERTIBLE_API_TOKEN`
- `ASSERTIBLE_SERVICE_ID`

You can get these values out of your Assertible dashboard after [setting up a new web service](https://assertible.com/docs/guide/web-services).

### Triggering tests during a build

To test your API or web app during your CI build, Assertible recommends building and running your app on Codeship, and then using an `ngrok` tunnel to trigger the test suite.

To do this, add the following script in your repository, that you will then call from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):

```yaml
- name: Assertible
  service: app
  command: assertible.sh
```

Inside of the `assertible.sh` file, use the following code:

```shell
# Start your application (NOTE: CUSTOMIZE THIS COMMAND)
node server.js &

# download and install ngrok
curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > ngrok.zip
unzip ngrok.zip
./ngrok http 5000 > /dev/null &
# sleep to allow ngrok to initialize
sleep 2

# Download JSON parser for determining ngrok tunnel
wget https://stedolan.github.io/jq/download/linux64/jq
chmod +x jq

# extract the ngrok url
NGROK_URL=$(curl -s localhost:4040/api/tunnels/command_line | jq --raw-output .public_url)

curl -s $TRIGGER_URL -d'{
  "environment": "'"$CI_BRANCH-$CI_COMMIT_ID"'",
  "url": "'"$NGROK_URL"'",
  "wait": true
}'
```

And that's it! Be sure to customize the command that starts your application. Now when your build runs, your application will be started and Assertible will run the [API tests](https://assertible.com/docs/guide/tests) you've configured.

### Running tests after a deployment

To run tests against your API or website _after_ a deployment, add the following command to a script placed in your repository, that you will then call from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):

```shell
# POST a new deployment to Assertible, and your tests will run against it
curl -u $ASSERTIBLE_API_TOKEN: -XPOST "https://assertible.com/deployments" -d'{\
    "service": "'"${ASSERTIBLE_SERVICE_ID}"'",\
    "environmentName": "staging",\
    "version": "'"${CI_COMMIT_ID}"'"\
}'
```

Call this script on all deployment-related branches by specifying the [tag]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}#limiting-steps-to-specific-branches-or-tags). Be sure to add this step **after** your deployment, so that the tests are run against the new version of your application. For example:

```yaml
- name: deploy
  service: app
  tag: master
  command: your deployment commands

- name: assertible
  service: app
  tag: master
  command: deploy-assertible.sh
```

## Codeship Basic

### Setting your API token

To run your API tests with Assertible, you will need to add two values to your Codeship project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}):

- `ASSERTIBLE_API_TOKEN`
- `ASSERTIBLE_SERVICE_ID`

You can get these values out of your Assertible dashboard after [setting up a new web service](https://assertible.com/docs/guide/web-services).

### Triggering tests during a build

To test your API or web app during your CI build, Assertible recommends building and running your app on Codeship, and then using an `ngrok` tunnel to trigger the test suite.

To do this, add the following code to a script in your repository and run it in your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

```shell
# Start your application (NOTE: CUSTOMIZE THIS COMMAND)
node server.js &

# download and install ngrok
curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > ngrok.zip
unzip ngrok.zip
./ngrok http 5000 > /dev/null &
# sleep to allow ngrok to initialize
sleep 2

# Download JSON parser for determining ngrok tunnel
wget https://stedolan.github.io/jq/download/linux64/jq
chmod +x jq

# extract the ngrok url
NGROK_URL=$(curl -s localhost:4040/api/tunnels/command_line | jq --raw-output .public_url)

curl -s $TRIGGER_URL -d'{
  "environment": "'"$CI_BRANCH-$CI_COMMIT_ID"'",
  "url": "'"$NGROK_URL"'",
  "wait": true
}'
```

And that's it! Be sure to customize the command that starts your application. Now when your build runs, your application will be started and Assertible will run the [API tests](https://assertible.com/docs/guide/tests) you've configured.

### Running tests after a deployment

To run tests against your API or website after a deployment, add a new custom-script step to your Codeship project's [deployment pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}).

The custom-script step will call the [Assertible Deployments API](https://assertible.com/docs/guide/deployments) to track the new release and run tests against the newly deployed version of your app by using the following command:

```shell
# POST a deployment release to Assertible, and your tests will run against it
curl -u $ASSERTIBLE_API_TOKEN: -XPOST "https://assertible.com/deployments" -d'{\
    "service": "'"${ASSERTIBLE_SERVICE_ID}"'",\
    "environmentName": "staging",\
    "version": "'"${CI_COMMIT_ID}"'"\
}'
```

For a more complete walk-through of setting this up read this Codeship blog post: [Add post-deploy smoke tests to any Codeship pipeline](https://blog.codeship.com/add-post-deploy-smoke-tests-to-any-codeship-pipeline/).
