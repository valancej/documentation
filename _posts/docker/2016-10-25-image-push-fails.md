---
title: Image Push Failing
layout: page
tags:
  - faq
  - builds
  - docker
categories:
  - docker
---

The **image** in `codeship-services.yml` has to match the **image_name** in `codeship-steps.yml`, like in the following example:

```yaml
- type: parallel
  steps:
    - name: checkrb
      service: demo
      command: bundle exec ruby check.rb
    - name: test
      service: demo
      command: bundle exec ruby test.rb

- type: serial
  steps:
    - name: dockerhub_push
      service: demo
      type: push
      image_name: something/test-repo
      registry: https://index.docker.io/v1/
      dockercfg_path: dockercfg
```

Note that our **image_name** here is *something/test-repo*. This is the name of the image in `codeship-services.yml`:

```yaml
demo:
  build:
    image: something/test-repo
    dockerfile_path: Dockerfile
  links:
    - redis
    - postgres
  environment:
    TEST_TOKEN: Testing123

redis:
  image: redis:3.0.5

postgres:
   image: postgres:9.3.6
```

Find out more about these two files in [steps configuration]({{ site.baseurl }}{% post_url docker/2015-05-25-steps %}) and [services configuration]({{ site.baseurl }}{% post_url docker/2015-05-25-services %}).
