---
title: Using The Codeship API For CI/CD Workflows
shortTitle: Codeship API v2
menus:
  general/integrations:
    title: Codeship API
    weight: 25
tags:
  - api
  - integrations
categories:
  - Builds and Configuration  
redirect_from:
  - /integration/api/
  - /basic/getting-started/api/
  - /basic/builds-and-configuration/api/
---

* include a table of contents
{:toc}

## Codeship API v2

The Codeship API v2 provides a number of ways for you to programmatically interact with your projects on Codeship.

To get started visit the [API v2 documentation](https://apidocs.codeship.com/v2/) for all the details. If you need help with the API please reach out to our [support team](https://helpdesk.codeship.com).

## Core Use Cases

The API is focused on solving a specific set of core use cases:

* Custom Dashboards - Mix and match data from Codeship with other systems to create custom dashboards. See [this example](https://blog.codeship.com/creating-a-custom-build-status-page-using-codeship-api-v2/) for inspiration on how to get started.
* Chaining Projects - Trigger a downstream project based on results from one or more upstream projects, and potentially information from outside of Codeship. If you're looking to chain multiple Codeship projects, consider relying on a notification webhook as the trigger instead of polling the API for updates to the upstream build. See [this example](https://blog.codeship.com/chained-builds-with-codeship-api-v2/) for some ideas.
* Trigger New Builds - Scheduled builds, builds triggered by events in external systems, or just giving QA a button on a webpage to trigger a build.
* Automatic Project Creation - For those who frequently create new projects you can automatically provision a project on Codeship, together with provisioning a new repo, test environment, etc.

## Available Endpoints

With the above scenarios as a guide, there are these specific endpoints:

* Authentication and authorization
* Projects
* Builds

### Projects Endpoint

For projects, you're able to do most CRUD operations which should allow you to automate most of your project maintenance tasks; especially useful for those with 10s or 100s of projects. There is currently no delete action on projects.

### Builds Endpoint

Builds can't be deleted, but otherwise you can do most anything with them. You can even go a level deeper than what the Codeship UI offers. If you restart a build, the old build data is kept around, but the UI only shows the latest. With the builds endpoint you can get the information on those old builds as well.

In terms of `commands` on the builds endpoint, we've deviated slightly from "textbook REST" and have allowed endpoints to `/restart` an existing build or `/stop` a running build. If you want to trigger a build that pulls the latest code from a given branch, you would POST to the `/builds` endpoint with the project and the branch in question. More details can be found on this in the [API v2 documentation](https://apidocs.codeship.com/v2/).

## API Clients

### Go

If you're using Go for your automation, you can get started more quickly with our [Codeship Go API client](https://github.com/codeship/codeship-go). There's a good introduction in the repo, and also [full documentation](https://godoc.org/github.com/codeship/codeship-go).

The Go library is released with the MIT license, so feel free to use it as you will. If you have suggestions, bugs or otherwise want to contribute to the project, please use the [GitHub issues](https://github.com/codeship/codeship-go/issues) to submit these (or submit a PR).
