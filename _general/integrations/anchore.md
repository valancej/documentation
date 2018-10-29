---
title: Integrating Codeship With Anchore For Container Image Scanning
shortTitle: Using Anchore For Container Image Scanning
tags:
  - security
  - reports
  - reporting
  - integrations
menus:
  general/integrations:
    title: Using Anchore
    weight: 16
categories:
  - Integrations    
---

* include a table of contents
{:toc}

## About Anchore

[Anchore](https://anchore.com) is a service that analyzes Docker images and applies user-defined acceptance polices to allow automated container image validation and certification.

By using Anchore you can be sure that your container images are secure and compliant.

The [Anchore documentation](https://anchore.freshdesk.com/support/home) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting up Anchore Engine service

[Install Anchore Engine](https://anchore.freshdesk.com/support/solutions/articles/36000020728-overview)

A running Anchore Engine is required, this does not need to be run within the Codeship infrastructure as long as the HTTP(s) endpoint of the Anchore Engine is accessible.

**Note** that this CI/CD model implies the following:

1. Developers commit code into SCM
2. CI / CD platform builds container image
3. CI /CD platform pushes container image to staging registry
4. CI / CD calls Anchore to Analyze container image
5. Anchore Passes or Fails the image based on the policy mapped to the image
6. CI / CD performs automated tests
7. If the container passes automated tests and policy evaluation the container image is pushed to the production registry.

### Building Image

To use Anchore in your CI/CD process, you'll need to add an Docker image build to a service in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) for Anchore to analyze.

```
imagebuild:
  build:
    dockerfile: Dockerfile
  cached: true
```

and your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

```
- name: imagebuildstep
  service: imagebuild
  type: push
  image_name: jvalance/sampledockerfiles
  encrypted_dockercfg_path: dockercfg.encrypted
``` 

**Note** that this example implies we have a Dockerfile to reference and build an image from.

### Scanning image with Anchore

To scan an image with Anchore, add an Anchore scan service to your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) for Anchore to analyze.

```
anchorescan:
  image: anchore/engine-cli:latest
  encrypted_env_file: env.encrypted
```

and your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

```
- name: anchorestep
  service: anchorescan
  command: sh -c 'echo "Adding image to Anchore engine" && 
    anchore-cli image add $ANCHORE_IMAGE_SCAN &&
    echo "Waiting for image analysis to complete" &&
    counter=0 && while (! (anchore-cli image get $ANCHORE_IMAGE_SCAN | grep 'Status\:\ analyzed') ) ; do echo -n "." ; sleep 10 ; if [ $counter -eq $ANCHORE_RETRIES ] ; then echo " Timeout waiting for analysis" ; exit 1 ; fi ; counter=$(($counter+1)) ; done &&
    echo "Analysis complete" &&
    if [ "$ANCHORE_FAIL_ON_POLICY" == "true" ] ; then anchore-cli evaluate check $ANCHORE_IMAGE_SCAN  ; fi'
  encrypted_env_file: env.encrypted
```

The job will poll the Anchore Engine every 10 seconds to check if the image has been analyzed and will repeat this until the maximum number of retries specified has been reached.

**Note** that depending on the result of the Anchore policy evaluation and the `$ANCHORE_FAIL_ON_POLICY` environment variable, the build may or may not fail. 
