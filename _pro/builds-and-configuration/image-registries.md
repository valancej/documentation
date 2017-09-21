---
title: Using Docker Image Registries With Your CI/CD Builds
shortTitle: Using Docker Image Registries
menus:
  pro/builds:
    title: Image Registries
    weight: 5
tags:
  - docker
  - tutorial
  - push
  - registry
  - registries
  - Docker Hub
  - Dockerhub
  - quay
  - ecr
  - gcr
  - images
  - image registry

redirect_from:
  - /docker/docker-push/
  - /pro/getting-started/docker-push/
  - /pro/getting-started/docker-pull/
  - /pro/getting-started/dockercfg-services/
  - /docker/docker-pull/
  - /docker/dockercfg-service/
  - /docker/getting-started/docker-push/
---

<div class="info-block">
To follow this tutorial on your own computer, please [install the `jet` CLI locally first]({{ site.baseurl }}{% link _pro/builds-and-configuration/cli.md %}).
</div>

* include a table of contents
{:toc}

## Registry Authentication

If you are using private images, you will need to authenticate with the image registries to pull and push from your account.

**Note** that on Docker Hub, you can use public images without any authentication being required.

### Encrypted Registry Account Credentials

The most common way authenticate with image registries is to provide your account credentials via an encrypted dockercfg file. This keeps your credentials secure while allowing you to push and pull from private registry accounts.

This encryption happens with our [local CLI tool]({{ site.baseurl }}{% link _pro/builds-and-configuration/cli.md %}), similar to using [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}). To encrypt your image registry credentials:

* First create an unencrypted dockercfg file using your account credentials. The dockercfg should look close to:

```shell
{
	"auths": {
		"https://index.docker.io/": {
			"auth": "your_auth_string",
			"email": "your_email"
		}
	}
}
```

* Get your AES encryption key from the _General_ settings page of your Codeship project and save it to your registry as `codeship.aes` (adding it to the `.gitignore` file is a good idea so that it does not end up in your repository).

* Run the `jet encrypt` command against your image registry `dockercfg` file. This typically looks like `jet encrypter dockercfg dockercfg.encrypted`. but you can name it whatever you'd like.

* The newly encrypted dockercfg file will be commited to your repo and used in your [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) and [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) files to authenticate with your registry on pull and push.

### Docker Credentials On Mac OSX

**Note that if you are using Mac OSX**, the newer versions of Docker have changed to store credentials in the OSX keychain rather than in a configuration file.

To get the appropriate authentication file on OSX, you will need to remove the `credsStore` line from Docker's `config.json` to disable Keychain storage, re-run `docker login` and then use the values it then generates in your updated `dockercfg` as shown above.

### Generating Credentials With A Service

Due to an increasing number of container registry vendors using different methods to generate Docker temporary credentials, we also have support for custom dockercfg credential generation at runtime. By using a custom service within your list of Codeship services, you can integrate with a standard dockercfg generation container for your desired provider.

Taking advantage of this feature is fairly simple. First off, add a service using the image for your desired registry provider to your [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) file. You can add any [links]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}), [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) or [volumes]({{ site.baseurl }}{% link _pro/builds-and-configuration/docker-volumes.md %}) you need, just like with a regular service.

```yaml
# codeship-services.yml
app:
  build:
    dockerfile: Dockerfile
    image: myservice/myuser/myapp

myservice_generator:
  image: codeship/myservice-dockercfg-generator
  encrypted_env: creds.encrypted
```

To use this generator service, simply reference it using the `dockercfg_service` field in lieu of an `encryped_dockercfg` in your steps or services file.

```yaml
# codeship-steps.yml
- type: push
  service: app
  registry: myservice.com
  image_name:  myservice.com/myuser/myapp
  dockercfg_service: myservice_generator
```

Codeship will run the service to generate a dockercfg as needed.

## Docker Hub

### Pushing To Docker Hub

After setting up your registry authentication using the encrypted dockercfg file method shown above, you will want to configure your [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

```yaml
app:
  build:
    image: username/repository_name
    dockerfile: Dockerfile
```

The image defined above will be tagged and pushed based on the `push` step in your [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) file:

```yaml
- service: app
  type: push
  image_name: username/repository_name
  encrypted_dockercfg_path: dockercfg.encrypted
```

### Pulling From Docker Hub

After setting up your registry authentication using the encrypted dockercfg file method shown above, you will want to configure your [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) or your Dockerfile to reference the image you are pulling:

```Dockerfile
FROM username/registry_name
# ...
```

You will also need to configure your [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) file to provide your account credentials via the encrypted dockercfg file on every step that uses an image from your Docker Hub account.

```yaml
- service: app
  command: /bin/true
  encrypted_dockercfg_path: dockercfg.encrypted
```

## Quay.io

### Pushing To Quay.io

To use the encrypted dockercfg file authentication method with Quay.io, you will first need to have create robot account with the requires permissions for your Quay repository. Please see the documentation on [Robot Accounts](http://docs.quay.io/glossary/robot-accounts.html) for Quay.io on how to set it up for your repository.

**Note** that permissions can be set per robot account, so if you are seeing authentication failures you should check that the individual robot account being used is configured with appropriate access.

Next, you will need to  download the `.dockercfg` file for this accoun  by heading over to the _Robots Account_ tab in your settings. From there, either credit a new robot account or click on an existing robot account. In the pop-up window, the _Docker Configuration_ tab will have an option to download an `auth.json` file.

Once you have encrypted this auth.json file using the encrypted dockercfg method, you will want to configure your [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

```yaml
app:
  build:
    image: quay.io/username/repository_name
    dockerfile: Dockerfile
  encrypted_dockercfg_path: dockercfg.encrypted
```

Next, you will need to configure your `codeship-steps.yml` file.

```yaml
- service: app
  type: push
  image_name: quay.io/username/repository_name
  registry: quay.io
  encrypted_dockercfg_path: dockercfg.encrypted
```

### Pulling From Quay.io

To pull images from private Quay.io accounts, you will need to configure your Quay robot account permissions and authentication via the encrypted dockercfg file as discussed in the above instructions regarding push steps.

After setting up your registry authentication, you will want to configure your [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) or your Dockerfile to reference the image you are pulling:

```Dockerfile
FROM quay.io/username/registry_name
# ...
```

You will also need to configure your `codeship-steps.yml` file to provide your account credentials on every step that using an image from your Quay.io registry.

```yaml
- service: app
  command: /bin/true
  encrypted_dockercfg_path: dockercfg.encrypted
```

## Custom / Self Hosted-Registry

### Pushing To A Custom / Self Hosted-Registry

Pushing to a custom or self-hosted registry is similar to using Dockerhub or Quay.io.

You will want to specify your regitry URL and provide your registry credentials in an encrypted dockercfg file on a [push step]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}#push-steps) in your [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

```yaml
- service: app
  type: push
  image_name: your_registry/your_image
  registry: your_registry_url
  encrypted_dockercfg_path: dockercfg.encrypted
```

### Pulling From A Custom / Self-Hosted Registry

You can  access images from privately or self-hosted registries with non-standard registry locations.

In your `Dockerfile`:

```Dockerfile
FROM your_registry_url/username/your_image
# ...
```

You will also need to configure your `codeship-steps.yml` file to provide your account credentials on every step that uses a private base image:

```yaml
- service: app
  command: /bin/true
  encrypted_dockercfg_path: dockercfg.encrypted
```

## Google GCR

### Pushing To GCR

To push to Google GCR in your builds, you will want to make use of our service generator method for registry authentication. This is because Google uses a token-based login system.

We maintain an image you can easily add to your push step to generate these credentials for you.

First, you will need to provide your Google credentials as [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) for your Google authentication service. Also note that our image name must include your GCR registry path for your push step to authenticate. Here is an example [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

```yaml
myapp:
  build:
    image: gcr.io/my_org/myapp
    dockerfile_path: Dockerfile.test

dockercfg_generator:
  image: codeship/gcr-dockercfg-generator
  add_docker: true
  encrypted_env_file: gcr.env.encrypted
```

Now, you will need a push step in your [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) with the `dockercfg_service` directive. This directive runs the service specified, when it is pushing, to generate the necessary authentication token.

Note that GCR requires the fully registry path in our image name, and the account you are authenticating with Google must have the necessary account permissions as well. Here is an example [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):

```yaml
- name: Push To GCR
  service: myapp
  type: push
  image_name: gcr.io/my_org/my_app
  registry: https://gcr.io
  dockercfg_service: dockercfg_service
```

Learn more about [using Google Cloud with Codeship Pro]({{ site.baseurl }}{% link _pro/continuous-deployment/google-cloud.md %}).

### Pulling From GCR

To pull images from Google GCR, you will need to provide the image, including the registry path, as well as use the service generator for authentication in your [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

For example:

```yaml
myapp:
  image: gcr.io/my_org/my_app
  dockercfg_service: dockercfg_generator

dockercfg_generator:
  image: codeship/gcr-dockercfg-generator
  add_docker: true
  encrypted_env_file: gcr.env.encrypted
```

This will use the  image we maintain for AWS authentication to generate credentials on image pull. Note that you will need to have your AWS credentials set via the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) for the generator service, and that the AWS account you are authenticating with will need appropriate IAM permissions.

Learn more about [using Google Cloud with Codeship Pro]({{ site.baseurl }}{% link _pro/continuous-deployment/google-cloud.md %}).

## AWS ECR

### Pushing To ECR

To push to AWS ECR in your builds, you will want to make use of our service generator method for registry authentication. This is because AWS uses a token-based login system.

We maintain an image you can easily add to your push step to generate these credentials for you.

First, you will need to provide your AWS credentials as [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) for your AWS authentication service. Also note that our image name must include your ECR registry path for your push step to authenticate. Here is an example [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

```yaml
myapp:
  build:
    image: 870119404647.dkr.ecr.us-east-1.amazonaws.com/myapp
    dockerfile_path: Dockerfile.test

dockercfg_generator:
  image: codeship/aws-ecr-dockercfg-generator
  add_docker: true
  encrypted_env_file: aws.env.encrypted
```

Now, you will need a push step in your [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) with the `dockercfg_service` directive. This directive runs the service specified, when it is pushing, to generate the necessary authentication token.

Note that ECR requires the fully registry path in our image name, and the account you are authenticating with AWS must have the necessary IAM permissions as well. Here is an example [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):

```yaml
- name: Push To ECR
  service: myapp
  type: push
  image_name: 870119404647.dkr.ecr.us-east-1.amazonaws.com/myapp
  registry: https://870119404647.dkr.ecr.us-east-1.amazonaws.com
  dockercfg_service: dockercfg_generator
```

Learn more about [using AWS with Codeship Pro]({{ site.baseurl }}{% link _pro/continuous-deployment/aws.md %}).

### Pulling From ECR

To pull images from ECR, you will need to provide the image, including the registry path, as well as use the service generator for authentication in your [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

For example:

```yaml
myapp:
  image: 870119404647.dkr.ecr.us-east-1.amazonaws.com/my_image
  dockercfg_service: dockercfg_generator

dockercfg_generator:
  image: codeship/aws-ecr-dockercfg-generator
  add_docker: true
  encrypted_env_file: aws.env.encrypted
```

This will use the  image we maintain for AWS authentication to generate credentials on image pull. Note that you will need to have your AWS credentials set via the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) for the generator service, and that the AWS account you are authenticating with will need appropriate IAM permissions.

Learn more about [using AWS with Codeship Pro]({{ site.baseurl }}{% link _pro/continuous-deployment/aws.md %}).

## IBM Bluemix Registry

### Pushing To Bluemix Registry

To push to IBM Bluemix in your builds, you will want to make use of our service generator method for registry authentication. This is because Bluemix uses a CLI-based login system.

[We maintain an image](https://github.com/codeship-library/ibm-bluemix-utilities) you can easily add to your push step to generate these credentials for you.

First, you will need to provide your IBM `BLUEMIX_API_KEY` credential as an [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) for your IBM authentication service. Also note that our image name must include your Bluemix registry path for your push step to authenticate. Here is an example [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

```yaml
app:
  build:
    image: your_org/your_image
    dockerfile_path: ./Dockerfile

bluemix_dockercfg:
  image: codeship/ibm-bluemix-dockercfg-generator
  add_docker: true
  encrypted_env_file: bluemix.env.encrypted
```

Now, you will need a push step in your [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) with the `dockercfg_service` directive. This directive runs the service specified, when it is pushing, to generate the necessary authentication token.

Note that Bluemix requires the fully registry path in our image name, and the account you are authenticating with must have at least one namespace configured with the IBM Bluemix Container Registry product:

```yaml
- name: Push To Bluemix
  service: app
  type: push
  image_name: registry.ng.bluemix.net/codeship/codeship-testing
  registry: registry.ng.bluemix.net
  dockercfg_service: bluemix_dockercfg
```

To see a full example of using IBM Bluemix Container Registry with Codeship Pro, [visit our example repository](https://github.com/codeship-library/ibm-bluemix-utilities).

### Pulling From Bluemix Registry

To pull images from Bluemix, you will need to provide the image, including the registry path, as well as use the service generator for authentication in your [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

For example:

```yaml
base:
  build:
    image: registry.ng.bluemix.net/your_namespace/image    
    path: ./base
    dockerfile_path: Dockerfile
  dockercfg_service: bluemix_dockercfg

bluemix_dockercfg:
  image: codeship/ibm-bluemix-dockercfg-generator
  add_docker: true
  encrypted_env_file: bluemix.env.encrypted
```

This will use the  image we maintain for IBM Bluemix authentication to generate credentials on image pull. Note that you will need to have your IBM `BLUEMIX_API_KEY` credential set via the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) for the generator service.

To see a full example of using IBM Bluemix Container Registry with Codeship Pro, [visit our example repository](https://github.com/codeship-library/ibm-bluemix-utilities).

## Common Questions

### Pushing To tags

Along with being able to push to private registries, you can also push to tags other than `latest`. To do so, simply add the tag as part of your push step using the `image_tag` declaration.

```yaml
- service: app
  type: push
  image_name: quay.io/username/repository_name
  image_tag: dev
  registry: quay.io
  encrypted_dockercfg_path: dockercfg.encrypted
```

This `image_tag` field can contain a simple string, or be part of a [Go template](http://golang.org/pkg/text/template/). You can compose your image tag from a variety of provided values. __Note__ that because we use Go for our Regex support, negative regexes and conditional regexes are  not supported.

* `ProjectID` (the Codeship defined project ID)
* `BuildID` (the Codeship defined build ID)
* `RepoName` (the name of the repository according to the SCM)
* `Branch` (the name of the current branch)
* `CommitID` (the commit hash or ID)
* `CommitMessage` (the commit message)
* `CommitDescription` (the commit description, see footnote)
* `CommitterName` (the name of the person who committed the change)
* `CommitterEmail` (the email of the person who committed the change)
* `CommitterUsername` (the username of the person who committed the change)
* `Time` (a golang [`Time` object](http://golang.org/pkg/time/#Time) of the build time)
* `Timestamp` (a unix timestamp of the build time)
* `StringTime` (a readable version of the build time)
* `StepName` (the user defined name for the `push` step)
* `ServiceName` (the user defined name for the service)
* `ImageName` (the user defined name for the image)
* `Ci` (defaults to `true`)
* `CiName` (defaults to `codeship`)

To tag your image based on the Commit ID, use the string `"{% raw %}{{ .CommitID }}{% endraw %}"`. You can template together multiple keys into a tag by simply concatenating the strings: `"{% raw %}{{ .CiName }}-{{ .Branch }}{% endraw %}"`. Be careful about using raw values, however, since the resulting string will be stripped of any invalid tag characters.

### Invalid character / Failed to parse dockercfg

You might see an error like this when pulling a private base image using your encrypted `dockercfg` file:

``Failed to parse dockercfg: invalid character '___' after top-level value``

This  means that either your `dockercfg` has a syntax problem or that it was encrypted with an incorrect or incomplete AES key, or an AES key from another project.

Try deleting your `dockercfg` and your AES key, then re-downloading the AES key and re-encrypting the `dockercfg` file.

### Error: "docker: no decryptor available"

This error means that the encrypted file was unable to be decrypted locally. This is because the AES key is missing.

See the instructions above for downloading your AES key locally to address this issue.

### Need a key regenerated

If you need a key regenerated, you can [submit a ticket to the help desk](https://helpdesk.codeship.com) from your account. Keep in mind that this will leave current encrypted credentials and environmental variables invalid for future builds on Codeship until they are re-encrypted using the new key.

### Only Pushing On Certain Branches

If you don't want to push the image for each build, add a `tag` entry to the below step and it will only be run on that specific branch or git tag.

[Learn more about tags here]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}#limiting-steps-to-specific-branches-or-tags).
