---
title: Organization Accounts
tags:
  - administration
  - project
  - organizations
  - team management
  - teams
  - account
  - whitelisting
categories:
  - Account
  - Security
redirect_from:
  - /administration/organizations/
menus:
  general/account:
    title: Organization Accounts
    weight: 2
---

* include a table of contents
{:toc}

Organizations simplify and enhance team management as well as subscription management for (larger) teams on Codeship.

You can define arbitrary teams and add them to any organization project and add Codeship accounts to those teams. You can also provide read-only access to some of your team members.

## Managing Teams And Projects

On the _Teams_ tab of the organization settings, you can manage your different teams, add new teams and invite or remove team members from the available teams.


### Team Roles And Permissions

We currently offer the following roles (though more roles are already on our todo list):

* **Owners** have control over all aspects of an organization. From changing the subscription to managing organization projects and teams.
* **Managers** have control over team and project management of an organization. They can add and remove projects and manage the organization teams by adding new team members or assigning projects to teams. They have access to all projects and are able to change the project configuration.
* **Project Managers** can manage projects the team is assigned to. They can debug builds, update test settings, or manage deployments.
* **Contributors** have read-only access to their projects. This means they can view the project dashboard and build details but are not allowed to change project settings, or open debug builds. Contributors are allowed to restart builds.

##### Role Permissions

| Permission                 | Owners | Managers | Project Managers | Contributors |
| -------------------------- | :----: | :------: | :--------------: | :----------: |
| **Organizations** | | | | |
| Update/Delete Organization |   x    | | | |
| Manage Billing             |   x    | | | |
| **Teams** | | | | |
| Create/Delete Team         |   x    |   x      | | |
| Update Team                |   x    |   x      |        x         | |
| **Projects** | | | | |
| Create/Update Project      |   x    |   x      |        x         | |
| View Project Details       |   x    |   x      |        x         |    x         |
| Delete/Transfer Project    |   x    |   x      | | |
| View All Projects          |   x    |   x      | | |
| View/Reset AES key         |   x    |   x      |        x         | |
| **Builds** | | | | |
| Restart Build/Pipeline     |   x    |   x      |        x         |    x         |
| Start Debug Build          |   x    |   x      |        x         | |
| Approve Build              |   x    |   x      | | |
| Stop Build                 |   x    |   x      |        x         | |

### Default Teams

Two teams are created for each organization by default:
* **Owners**, containing only the user who created the organization by default. However, you can add any other Codeship account to the _Owners_ team, as well.
  * Use that team to share responsibility around subscription, team management and billing.
* **Managers**, which is empty by default but is assigned the Managers permissions level.
  * Use that team to give everyone access to all projects with full permission to view, edit and configure projects.

_Manage access and permissions to projects more granularly by creating specific teams that have access to specific projects by using the **Project Managers** or **Contributor** role._


### Creating A New Team
If you want to create a new team, click the _Create new team_ button and select the appropriate role.

![Creating a Team]({{ site.baseurl }}/images/administration/create_team.png)

Once you have created a new team, you can invite your colleagues and add new team members via their email address as well as any existing projects.

If you need to change the team settings (e.g., the name or the role), hover over the team card and click the gear icon showing on the right hand side.

### Managing Team Settings
By going to _Edit Team Settings_ for a specific team you are able to:
* Rename a team
* Change the role of a team
* Delete a team

![Creating a Team]({{ site.baseurl }}/images/administration/manage_team_settings.png)

### Adding Projects To Teams

Projects can be assigned to any team in your organization, but only _Owners_ and _Managers_ are able to do so. By default, _Owners_ and _Managers_ have permission to view all projects regardless of team assignments, as well.

![Adding a project to a team]({{ site.baseurl }}/images/administration/add_projects_to_teams.gif)

## Removing A User From All Teams And Projects

To remove a team member from all organization teams and projects, click into your team management page. At the top, you will see a link for "Show All Members".

From the "Show All Members" screen, changes to any team member will apply to all teams and projects, organization-wide.

![Importing a personal project to an organization]({{ site.baseurl }}/images/administration/remove_all.png)

## Removing yourself from a team or organization

To remove yourself from an organization or team within an organization navigate to the _Teams_ page, which can be accessed through the main navigation. On this page, next to each team that you are a member of, you have the option to _Leave Team_.

**Note:** If you remove yourself from all teams, you will also remove yourself from access to this organization.

![Remove yourself from a team]({{ site.baseurl }}/images/general/remove_yourself_from_team.png)

## Creating An Organization

* Click on your name in the navigation bar at the top and click the green _Create Organization_ button.

* Choose an available name and you're done!

![Creating an Organization]({{ site.baseurl }}/images/administration/create_organization.png)

## Changing The Name Of An Account

_The name of an account can be changed by members of the owner team only._

In order to change the account name, navigate to the _Settings_ page of your account.

![Renaming your account]({{ site.baseurl }}/images/general/update_organization_name.png)

Account names are required to be unique. Changing the account name will also change the dashboard url - `app.codeship.com/<your_account_name>` - for that account.

On the account page, you also have the option to enable the IP Whitelisting feature. Read more about that in the [IP Whitelisting]({{ site.baseurl }}{% link _general/account/whitelisting.md %}) documentation to see if it is something your organization needs.

## Delete Your Organization Account

To delete your organization account on Codeship, navigate to the _Settings_ page of your organization and select delete organization.
Be aware that:
* You have to be part of the **Owner Team**
* You must cancel your billing subscription before you are able to delete your organization account
* The organization will be removed and all team members will lose access
* All your projects, configuration and builds will be deleted

**Note** that you must be in the _Owners_ group to be able to delete an organization.


## Accessing Invoices

For all users assigned the **Owner** role in an organization, you can access invoices by clicking on your name in the top right and selecting an organization from the drop-down. Then, on the sidebar underneath the organization name, you will see a tab for _Invoices_.

## Cancel Your Billing Subscription

To cancel your billing subscription but not delete your account, simply click _Subscription_ from the top navigation and select the free plan as your account option.


## Transfer A Project To An Organization

You can transfer your project to another organization by navigating to:

***Project Settings > General***

A user with appropriate permissions for the target organization will need to confirm the transfer, unless your account also has **Owner** or **Manager** permissions on the organization you are transferring the project to.

When confirming a project transfer, you can choose which of the current team members to keep and which to remove.

If you want to **bulk transfer projects**, please reach out to our support via [helpdesk.codeship.com](https://helpdesk.codeship.com).

![Importing a personal project to an organization]({{ site.baseurl }}/images/administration/import_projects.png)
