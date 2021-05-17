+++
title = "Sharing a portfolio using AWS Organizations"
weight = 362
home_region = "eu-west-1"
+++
---

## What are we going to do?

This tutorial will walk you through "{{% param title %}}" to OU member accounts.

Doing this will allow the framework to share Service Catalog Portfolios by using AWS Organizations OUs, rather than account-to-account sharing.  This will reduce the time required to share Portfolios.

We are going to perform the following steps:

- enable organizational sharing
- create a manifest file
- add an account to the manifest file
- add a spoke-local-portfolios to the manifest file

During this process you will check your progress by verifying what the framework is doing at each step.

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"


### Enable Organizational Sharing

{{% notice note %}}
This is action is only required once. 
{{% /notice %}}

Using the AWS Console:
- Navigate to Service Catalog in the AWS Console
- Select ***Portfolios*** from the sidebar.
- Select previously created Portfolio, i.e `reinvent-cloud-engineering-governance`
- Select ***Actions***, then ***Share***.
- Select the ***Organizations*** button.
  - You'll see a warning message: *"Organizational sharing is not available"*
- Select the ***Enable*** button.

{{< figure src="/how-tos/creating-and-provisioning-a-product/EnableOrganizationalSharing.png" >}}


### Creating the manifest file

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/how-tos/creating-and-provisioning-a-product/create_file.png" >}}

### Adding an OU to the manifest file

_We will start out by adding your OU to the manifest file._

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}


- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/how-tos/creating-and-provisioning-a-product/create_file.png" >}}

- Copy the following snippet into the main input field:

  <figure>
   {{< highlight js >}}
accounts:
  - ou: "<YOUR_OU_OR_PATH>"
    name: "application-accounts"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
      - "eu-west-2"
    tags:
      - "type:prod"
      - "partition:eu"
   {{< / highlight >}}
  </figure>

 
- Update `<YOUR_OU_OR_PATH>` to show your OU or OU Path which contains [member accounts](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html)
  - for example `/production/application-accounts/`


### Adding spoke-local-portfolio to the manifest

_Now we are ready to add a product, which we will share via AWS Organizations, to the manifest file._

- Add the following snippet to the end of the main input field:

 <figure>
  {{< highlight js >}}
spoke-local-portfolios:
  account-vending-for-spokes:
    portfolio: "reinvent-cloud-engineering-governance"
    sharing_mode: AWS_ORGANIZATIONS
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
  {{< / highlight >}}
 </figure>

Notice that we have included `sharing_mode: AWS_ORGANIZATIONS`.

Here, the Portfolio Share will be accepted in the `default_region` of accounts that are `type:prod`.

- The main input field should look like this:

 <figure>
  {{< highlight js >}}
accounts:
  - ou: "<YOUR_OU_OR_PATH>"
    name: "application-accounts"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
      - "eu-west-2"
    tags:
      - "type:prod"
      - "partition:eu"
spoke-local-portfolios:
  account-vending-for-spokes:
    portfolio: "reinvent-cloud-engineering-governance"
    sharing_mode: AWS_ORGANIZATIONS
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
  {{< / highlight >}}
 </figure>


### Committing the manifest file

_Now that we have written the manifest file we are ready to commit it._

- Set the *File name* to `manifest.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/how-tos/creating-and-provisioning-a-product/CommitChanges.png" >}}


### Verifying the sharing

Once you have made your changes the {{% service_catalog_puppet_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Deploy* stages in green to indicate they have completed 
successfully:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SuccessfulPuppetRunV2.png" >}}

Once you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} in the member account to view your shared product. 

When you share a portfolio the framework will decide if it should share the portfolio.  If the target account is the same
as the factory account it will not share the portfolio as it is not needed.
