---
title: Using The Codeship API For CI/CD Workflows
shortTitle: API
menus:
  basic/builds:
    title: API
    weight: 11
tags:
  - api
  - integrations
categories:
  - Builds and Configuration  
redirect_from:
  - /integrations/api/
  - /basic/getting-started/api/
---

* include a table of contents
{:toc}

## API v2 Introduction

We recently launched a new version of the API as a public Beta, which is open to anyone and doesn't require any registration. This page will provide more context around the new API and examples of how to work with it.

If you're just looking to get started, head over to the [API v2 Documentation](https://apidocs.codeship.com/v2/) for all the details.

## Overview

The new API have initially been focused on solving a specific set of use cases, that have been requested by the majority of users:

* Custom Dashboards - the ask here have been to be able to mix and match data from codeship with other systems, to create custom dashboards that would not be possible inside Codeship
* Chaining Projects - what we've heard most here is needing to trigger a downstream project based on results from one or more upstream projects and potentially information from outside of codeship
* Automatically (or manually) Trigger New Builds - scheduled builds, builds triggered by events in external systems, or just giving QA a button on a webpage to trigger a build have been among the requests for this scenario.
* Automatic project creation - for those who more frequently create new projects, there's been a lot of requests for being able to automatically provisioning a project on codeship; together with provisioning a new repo, test environment etc. to make bootstrapping a new project quicker and more standardized

## Available Endpoints

Having the above scenarios as a guiding light, we have focus on these specific endpoints:

* Authentication and authorization
* Projects
* Builds

### Projects Endpoint

For Projects, you're able to do most CRUD operations (we're working on the remaining ones) which should allow you to automate most of your project maintenance tasks; especially useful for those with 10s or 100s of projects.

**Things to note**:

* There's currently no Delete action on projects
* Test and deployment pipelines cannot be updated at this point in time

### Builds Endpoint

Builds can't really be deleted, but otherwise you can do pretty much anything with them. You can even go a level deeper than what the Codeship UI offers; if you restart a build, the old build data is kept around, but the UI only shows the latest. With the builds endpoint you can get the information on those old builds as well.

In terms of `commands` on the builds endpoint, we've deviated slightly from "textbook REST" and have allowed endpoints to `/restart` and existing build or `/stop` a running build. If you want to trigger a build that pulls the latest code from a given branch, you would POST to the `/builds` endpoint with the project and the branch in question. More details can be found on this in the [API v2 Documentation](https://apidocs.codeship.com/v2/).

**Things to note**:

* At this point we can't provide log output via the API. We're working on making that possible, but it'll take some time.

## What happens to v1?

The first version of the API is still in production, though the documentation is now hosted on the new [API v1 Documentation](https://apidocs.codeship.com/v1/) site.

While v2 is still in Beta, nothing will change for v1, but it will be deprecated and eventually fully removed. Going forward, you shouldn't expect any updates or fixes to v1, and ideally you should plan to migrate your projects to use v2. We will provide at least 6 months notice before completely removing v1, which would not happen until v2 exits Beta