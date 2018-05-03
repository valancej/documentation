---
title: Keeping Build Artifacts After CI/CD
shortTitle: Build Artifacts
menus:
  basic/ci:
    title: Artifacts
    weight: 5
tags:
  - cdn
  - artifacts
  - testing
categories:
  - Continuous Integration
  - Caching
redirect_from:
  - /continuous-integration/keep-build-artifacts/
---

* include a table of contents
{:toc}

For security reasons Codeship does not provide persistent storage of files between builds (aside from the build log). If you wish to retain artifacts for troubleshooting purposes, then you will need to implement steps to transfer them to a remote server during the build run.

## Upload artifacts to S3

If you want to upload artifacts to S3 during your test steps, you can use the AWS CLI. First add the following environment variables to your project configuration.

```
AWS_DEFAULT_REGION
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```

then add the following commands to the your setup / test steps

```shell
pip install awscli
aws s3 cp your_artifact_file.zip s3://mybucket/your_artifact_file.zip
```

{% csnote info %}
For Codeship Pro, our [_Codeship AWS container_]({{ site.baseurl }}{% link _pro/continuous-deployment/aws.md %}) can be implemented to transfer artifacts to S3 storage.
{% endcsnote %}

For more advanced usage of the S3 CLI, please see the [S3 documentation](http://docs.aws.amazon.com/cli/latest/reference/s3/index.html) on amazon.com

**Note** that you can simply add another integrated S3 deployment after your actual deployment if you only want to keep artifacts for specific branches.

## Upload through SFTP

Each project has its own public key which you'll find in your project settings on the *General* page. You can use this key to grant access to your storage provider for Codeship or upload files through SFTP.
