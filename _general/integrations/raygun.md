---
title: Using Raygun To Track Errors And Deployments
shortTitle: Tracking Errors And Deployments With Raygun
menus:
  general/integrations:
    title: Using Raygun
    weight: 20
tags:
  - raygun
  - deployment
  - logging
  - analytics
  - reports
  - reporting
  - integrations
  - errors

---

* include a table of contents
{:toc}

## About Raygun

[Raygun](https://raygun.com) lets you collect and track errors and deployments for your applications.

By using Raygun you can keep track of error logs and deployment events easier.

[Their documentation](https://raygun.com/docs) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your API Key And Variables

You will need to add your Raygun API key and other requites variables to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Installing Raygun Dependency

Raygun maintains a list of modules that can be installed as dependencies for a wide variety of languages and frameworks. You will want to [visit their documentation](https://raygun.com/docs) and follow the instructions to use the dependency that is right for your application.

This dependency will need to be installed in the Dockerfile that you build via your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Deploying And Sending Data

Once you have your API key, other required variables and dependencies installed, you will either run deployment commands or send data via API calls that you can make in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

For example, here is an example using the [Raygun deployment commands](https://raygun.com/docs/deployments/bash):


```yaml
- name: raygun-deploy
  service: app
  command: raygun.sh
```

Notice that in this case we are calling a script named `raygun.sh`. Inside this script, we could have the Raygun deployment commands:

```bash
while getopts "t:a:v:n:e:g:h" opt; do
	case $opt in
	t)
		RAYGUN_AUTH_TOKEN=$OPTARG
		;;
	a)
		RAYGUN_API_KEY=$OPTARG
		;;
	v)
		DEPLOYMENT_VERSION=$OPTARG
		;;
	n)
		DEPLOYED_BY=$OPTARG
		;;
	e)
		EMAIL_ADDRESS=$OPTARG
		;;
    g)
		GIT_HASH=$OPTARG
		;;
    h)
        HELP=1
        ;;
	esac
done

shift $((OPTIND-1))

if [ $HELP -eq 1 ]
then
cat << EOF
usage: deployment.sh [-h] -v VERSION -t TOKEN -a API_KEY
                      -e EMAIL -n NAME [-g GIT_HASH] NOTES
  h:          show this help
  v VERSION:  version string for this deployment
  t TOKEN:    your Raygun External Auth Token
  a API_KEY:  the API Key for your Raygun Application
  n NAME:     the name of the person who created the deployment
  e EMAIL:    the email address of the person who created the deployment.
              Should be a Raygun users email
  g GIT_HASH: the git commit hash this deployment was built from
  NOTES:      the release notes for this deployment.
              Will be formatted using a Markdown parser
EOF
exit
fi

[ "$1" = "--" ] && shift

if [ "$1" != "" ]
then
    DEPLOYMENT_NOTES=$1
    DEPLOYMENT_NOTES=`echo $DEPLOYMENT_NOTES | sed s/\"/\\\\\\\\\"/g`
fi


url="https://app.raygun.com/deployments?authToken=$RAYGUN_AUTH_TOKEN"

read -d '' deployment <<- EOF
{
    apiKey: \"$RAYGUN_API_KEY\",
    version: \"$DEPLOYMENT_VERSION\",
    ownerName: \"$DEPLOYED_BY\",
    emailAddress: \"$EMAIL_ADDRESS\",
    scmIdentifier: \"$GIT_HASH\",
    comment: \"$DEPLOYMENT_NOTES\"
}
EOF

if ! curl -H "Content-Type: application/json" -d "$deployment" -f $url
then
  echo "Could not send deployment details to Raygun"
  exit 1
fi
```

**Note** that this example uses the [Raygun deployment commands](https://raygun.com/docs/deployments/bash) and requires additional environment variables to be set in the section above. We recommend visiting the Raygun documentation for more information.

You can also run API calls in the same way, simply running API calls rather than the deployment commands above.

## Codeship Basic

### Setting Your API Key And Variables

You will need to add your Raygun API key and other requites variables to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

### Installing Raygun Dependency

Raygun maintains a list of modules that can be installed as dependencies for a wide variety of languages and frameworks. You will want to [visit their documentation](https://raygun.com/docs) and follow the instructions to use the dependency that is right for your application.

This dependency will need to be installed via your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

### Deploying And Sending Data

Once you have your API key, other required variables and dependencies installed, you will either run deployment commands or send data via API calls that you can make in your [test or deployment commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

```bash
while getopts "t:a:v:n:e:g:h" opt; do
	case $opt in
	t)
		RAYGUN_AUTH_TOKEN=$OPTARG
		;;
	a)
		RAYGUN_API_KEY=$OPTARG
		;;
	v)
		DEPLOYMENT_VERSION=$OPTARG
		;;
	n)
		DEPLOYED_BY=$OPTARG
		;;
	e)
		EMAIL_ADDRESS=$OPTARG
		;;
    g)
		GIT_HASH=$OPTARG
		;;
    h)
        HELP=1
        ;;
	esac
done

shift $((OPTIND-1))

if [ $HELP -eq 1 ]
then
cat << EOF
usage: deployment.sh [-h] -v VERSION -t TOKEN -a API_KEY
                      -e EMAIL -n NAME [-g GIT_HASH] NOTES
  h:          show this help
  v VERSION:  version string for this deployment
  t TOKEN:    your Raygun External Auth Token
  a API_KEY:  the API Key for your Raygun Application
  n NAME:     the name of the person who created the deployment
  e EMAIL:    the email address of the person who created the deployment.
              Should be a Raygun users email
  g GIT_HASH: the git commit hash this deployment was built from
  NOTES:      the release notes for this deployment.
              Will be formatted using a Markdown parser
EOF
exit
fi

[ "$1" = "--" ] && shift

if [ "$1" != "" ]
then
    DEPLOYMENT_NOTES=$1
    DEPLOYMENT_NOTES=`echo $DEPLOYMENT_NOTES | sed s/\"/\\\\\\\\\"/g`
fi


url="https://app.raygun.com/deployments?authToken=$RAYGUN_AUTH_TOKEN"

read -d '' deployment <<- EOF
{
    apiKey: \"$RAYGUN_API_KEY\",
    version: \"$DEPLOYMENT_VERSION\",
    ownerName: \"$DEPLOYED_BY\",
    emailAddress: \"$EMAIL_ADDRESS\",
    scmIdentifier: \"$GIT_HASH\",
    comment: \"$DEPLOYMENT_NOTES\"
}
EOF

if ! curl -H "Content-Type: application/json" -d "$deployment" -f $url
then
  echo "Could not send deployment details to Raygun"
  exit 1
fi
```

**Note** that this example uses the [Raygun deployment commands](https://raygun.com/docs/deployments/bash) and requires additional environment variables to be set in the section above. We recommend visiting the Raygun documentation for more information.

You can also run API calls in the same way, simply running API calls rather than the deployment commands above.
