---
title: API
layout: page
tags:
  - api
  - integrations
category: Getting Started
redirect_from:
  - /integrations/api/
---

<div class="info-block">
The API is currently only available for projects on Codeship Basic and not available on Codeship Pro. An API upgrade that works with both Basic and Pro will be released soon.
</div>

* include a table of contents
{:toc}

## Updated API Documentation

Going forward, we are now supporting our API documentation at a new location. [Click here to access it now.](https://codeship-api.api-docs.io/v1)

## Get an API Key

You can get your API key on [your account page](https://app.codeship.com/user/edit).

## Projects

### Get a list of your available projects

GET /api/v1/projects.json

```shell
curl -i https://codeship.com/api/v1/projects.json?api_key=valid_api_key
```

returns

```json
{
  "projects": [
    {
      "id": 33837,
      "repository_name": "codeship/documentation",
      "uuid": "59a737f0-1648-0132-c4e7-72c6c37b1f6e",
      "builds": [ … ]
    },
    …
  ]
}
```

### Get a single project

GET /api/v1/projects/:project_id.json

Parameters

| Name           | Type       | Description             |
| ---------------|:-----------|:------------------------|
| branch         | string     | Name of a branch        |

```shell
curl -i https://codeship.com/api/v1/projects/:project_id.json?api_key=valid_api_key
```

returns

```json
{
  "id": 33837,
  "repository_name": "codeship/documentation",
  "uuid": "59a737f0-1648-0132-c4e7-72c6c37b1f6e",
  "builds": [ … ]
}
```

To only get builds from a specific branch, add the `branch=branch_name` parameter to the call:
```shell
curl -i "https://codeship.com/api/v1/projects/:project_id.json?api_key=valid_api_key&branch=valid_branch_name"
```


## Builds

### Build data

Anytime a build is referenced in the above API calls, the data contains the following attributes

```json
{
  "id": 3277309,
  "uuid": "80240b80-6742-0132-8d88-366b9ffd5919"
  "project_id": 33837,
  "status": "success",
  "branch": "master",
  "commit_id": "81d2282b97c37c30a40302282402828f61f4f4ee",
  "github_username": "mlocher",
  "message": "Fixed the second code block for skipping builds.",
  "started_at": "2014-12-16T11:13:35.178Z",
  "finished_at": "2014-12-16T11:14:08.271Z",
  "debug_connection": null,
}
```

### Restart a single build

POST /api/v1/builds/:build_id/restart.json

```shell
curl -i -X POST https://codeship.com/api/v1/builds/:build_id/restart.json?api_key=valid_api_key
```

returns

```json
{
  "id": 808412,
  "uuid": "cc059370-9a70-0131-c115-0088653824b4"
}
```

### Restart the last build of a project on Codeship

You can restart the last build for a specific branch of a project, from within Codeship Basic, with the included
`codeship_restart_build` script. Using this script, you don't have to know the ID of the latest build before hand, which makes it easier to automate things.

Set the following variables in your project's environment settings first

```shell
CODESHIP_API_KEY
CODESHIP_API_PROJECT_ID (you can get that one from the URL of a project)
CODESHIP_API_BRANCH
```

By adding the following command to your build, you can restart the last build on a specific
branch for the project you defined with the environment variables.

```shell
codeship_restart_build
```

Behind the scenes, the `codeship_restart_build` script calls the Codeship API to get information about the builds of a project and restart the latest build of the speficied branch.
If you want to see how that's done, you can [check out the source](https://github.com/codeship/scripts/blob/master/utilities/codeship_restart_build.sh) (in case you want to do the same in your own systems).

At a high level, the script calls `/api/v1/projects/:project_id.json?branch=valid_branch_name` to get builds from the project, for the specified branch.
Looking at the returned builds, it identifies the latest one and then calls `/api/v1/builds/:build_id/restart.json` to restart it.
