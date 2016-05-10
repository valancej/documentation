---
title: "Tutorial: Using private base images"
layout: page
weight: 45
tags:
  - docker
  - tutorial
  - pull
  - registry
categories:
  - docker
---

* include a table of contents
{:toc}

<div class="info-block">
To follow this tutorial on your own computer, please [install the `jet` CLI locally first]({{ site.baseurl }}{% post_url docker/jet/2015-05-25-installation %}).
</div>

## Using private images in your builds

`jet` does support using private Docker images as base images for your containers. Similar to [pushing images]({{ site.baseurl }}{% post_url docker/tutorials/2015-07-03-docker-push %}) you need to save your encrypted `.dockercfg` file in the repository and reference it for any step using private base images (or for groups of steps).

## Configuring a build with a private base image

* Get the AES encryption key from the _General_ settings page of your Codeship project and save it to your repository as `codeship.aes` (adding it to the `.gitignore` file is a good idea).

* For Docker Hub, login locally and mv the credentials file to your repository.

```bash
docker login
# follow the onscreen instructions
# ...
jet encrypt ${HOME}/.docker/config.json .dockercfg.encrypted
# or (depending if you are on an older version of Docker)
jet encrypt ${HOME}/.dockercfg .dockercfg.encrypted
```

* For Quay.io

    * First configure a [robot account](http://docs.quay.io/glossary/robot-accounts.html)
    * Once you have configured the robot account, download the `.dockercfg` file for this account, by heading over to the _Robots Account_ tab in your settings, clicking the gear icon, selecting _View Credentials_ and hitting the download button.
    * Save the file as `.dockercfg` in your repository, encrypt it and add the unencrypted version to `.gitignore`

```bash
echo ".dockercfg" >> .gitignore
jet encrypt .dockercfg .dockercfg.encrypted
```

* Commit `.dockercfg.encrypted` as well as the `.gitignore` file

```bash
git add .dockercfg.encrypted .gitignore
git commit -m "Adding encrypted credentials for docker push"
```

* Adapt your Dockerfile

```Dockerfile
FROM codeship/private_base
# ...
```

* Configure your `codeship-services.yml` file. It will probably look similar to the following:

```yaml
# Building a container based on a private base image
app:
  build:
    dockerfile_path: Dockerfile

# pulling a container from a private repository (without building it locally)
db:
  image: codeship/postgresql
```

* Configure your `codeship-steps.yml` file. Make sure to specify the encrypted Docker configuration for any step that requires access to a private image.

```yaml
- service: app
  command: /bin/true
  encrypted_.dockercfg_path: .dockercfg.encrypted
```

* Commit and push the changes to your remote repository, head over to [Codeship](https://codeship.com/) and watch your build pull the private image from the registry!

## Common problems

### Invalid character / Failed to parse .dockercfg

You might see an error like this when pulling a private base image using your encrypted ``.dockercfg`` file:

``Failed to parse .dockercfg: invalid character '___' after top-level value``

This  means that either your ``.dockercfg`` has a syntax problem or that it was encrypted with an incorrect or incomplete AES key, or an AES key from another project.

Try deleting your ``.dockercfg`` and your AES key, then re-downloading the AES key and re-encrypting the ``.dockercfg`` file.

### No key

Sometimes you might see this error the first time you go to encrypt your ``.dockercfg`` file:

``jet: no key``

This means your AES key is missing from your project directory and must be downloaded according to [the instructions above.]({{ site.baseurl }}/docker/docker-pull/#configuring-a-build-with-a-private-base-image)


### Need a key regenerated

If you need a key regenerated, you can submit a ticket to the help desk from your account. Keep in mind that this will leave current encrypted credentials and environmental variables invalid for future builds on Codeship until they are re-encrypted using the new key.


As always, feel free to contact [support@codeship.com](mailto:support@codeship.com) if you have any questions.
