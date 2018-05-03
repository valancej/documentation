---
title: Deploy To S3
menus:
  basic/cd:
    title: AWS S3
    weight: 7
tags:
  - deployment
  - aws
  - s3
  - amazon
categories:
  - Deployment
  - AWS
---

* include a table of contents
{:toc}

Codeship makes it easy to deploy your application files to AWS S3 using Codeship's integrated [deployment pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}).

## Setup AWS S3 Deployment

### Step 1 - Navigate to Deployment Configuration
Navigate to your project's deployment configuration page by selecting _Project Settings_ > _Deploy_ on the top right side of the page.

![Project Settings Deployment]({{ site.baseurl }}/images/continuous-deployment/project_configuration.png)

### Step 2 - Add New Deployment Pipeline
Edit an existing deployment pipeline or create a new deployment pipeline by selecting + _Add new deployment pipeline_. Create the deployment pipeline to match the exact name of your deployment branch or a [wildcard branch]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}#wildcard-branch-deployment-pipelines).

![Create branch deploy]({{ site.baseurl }}/images/continuous-deployment/create_deploy_branch.png)

### Step 3 - AWS S3
Select _Amazon S3_

![Select S3]({{ site.baseurl }}/images/continuous-deployment/select_s3.png)


### Step 4 - Deployment Configuration
![Configure S3]({{ site.baseurl }}/images/continuous-deployment/configure_s3.png)

#### AWS Access Key ID & Secret Access Key
AWS access credentials -- see AWS documentation on [understanding and getting your security credentials](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html).

#### Region
The specified region of your S3 bucket -- see AWS [list of S3 Regions](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region).

#### Local Path
Location of file or directory to upload to S3 bucket.

#### S3 Bucket
Your [unique S3 bucket name](https://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html).

#### ACL
Specified AWS Access Control List -- see AWS documentation for [overview of access control lists](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html).

### Step 5 - Save Deployment Configuration
![S3 Success]({{ site.baseurl }}/images/continuous-deployment/s3_success.png)

### Step 6 - Next Steps
You have now successfully setup deployment to AWS S3. Go ahead and [push a commit to your configured deploy branch]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).
