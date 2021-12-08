+++
title = "Sharing a portfolio"
weight = 300
home_region = "eu-west-1"
+++
---

## What are we going to do?

This tutorial will walk you through "{{% param title %}}" with a spoke account.

We will assume you have:
 
 - installed Service Catalog Puppet correctly
 - bootstrapped a spoke
 - you have created a product
 - you have created a portfolio

We are going to perform the following steps:

- create a manifest file
- add an account to the manifest file
- add a spoke-local-portfolios to the manifest file

During this process you will check your progress by verifying what the framework is doing at each step.

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Creating the manifest file

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/how-tos/creating-and-provisioning-a-product/create_file.png" >}}

### Adding an account to the manifest file

_We will start out by adding your account to the manifest file._

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}


- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/how-tos/creating-and-provisioning-a-product/create_file.png" >}}

- Copy the following snippet into the main input field:

  <figure>
   {{< highlight js >}}
accounts:
  - account_id: "<YOUR_ACCOUNT_ID_WITHOUT_HYPHENS>"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
      - "eu-west-2"
    tags:
      - "type:prod"
      - "partition:eu"   
   {{< / highlight >}}
  </figure>

 
- Update account_id on line to show your account id


### Adding spoke-local-portfolio to the manifest

_Now we are ready to add a product to the manifest file._

- Add the following snippet to the end of the main input field:

 <figure>
  {{< highlight js >}}
spoke-local-portfolios:
  account-vending-for-spokes:
    portfolio: reinvent-cloud-engineering-governance
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"  
  {{< / highlight >}}
 </figure>


- The main input field should look like this:

 <figure>
  {{< highlight js >}}
accounts:
  - account_id: "<YOUR_ACCOUNT_ID_WITHOUT_HYPHENS>"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
      - "eu-west-2"
    tags:
      - "type:prod"
      - "partition:eu"
spoke-local-portfolios:
  account-vending-for-spokes:
    portfolio: reinvent-cloud-engineering-governance
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

Once you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} to view your 
shared product.  

When you share a portfolio the framework will decide if it should share the portfolio.  If the target account is the same
as the factory account it will not share the portfolio as it is not needed.

### Adding Associations

In order to use an AWS Service Catalog portfolio as an end user (to provision products) you will need to have an 
association added to the portfolio.  Associations can be for groups, users or roles.  To add an association you need to 
follow the example below:

 <figure>
  {{< highlight js >}}
accounts:
  - account_id: "<YOUR_ACCOUNT_ID_WITHOUT_HYPHENS>"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
      - "eu-west-2"
    tags:
      - "type:prod"
      - "partition:eu"
spoke-local-portfolios:
  account-vending-for-spokes:
    portfolio: reinvent-cloud-engineering-governance
    associations:
      - arn:aws:iam::${AWS::AccountId}:role/MyServiceCatalogAdminRole
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"  
  {{< / highlight >}}
 </figure>

Please note the solution will replace ${AWS::AccountId} with the account id of the target account where the portfolio 
will be share to.  You can add more than one association but you cannot add the same association twice.  If you are 
wanting to add an association for you as the maintainer we recommend you add this in the portfolio/*.yaml files but if 
you are adding associations for people that will be using the portfolio we recommend adding them here in manifest.

When using associations it may be useful for your spoke local portfolio to depend_on a stack or launch that
provisions the specified role into the spoke account.

If you are using service AWS Control Tower and/or AWS SSO the IAM role that gets created in the spoke accounts is not
deterministic.  You can use a wildcard in the association to work around this:

 <figure>
  {{< highlight js >}}
accounts:
  - account_id: "<YOUR_ACCOUNT_ID_WITHOUT_HYPHENS>"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
      - "eu-west-2"
    tags:
      - "type:prod"
      - "partition:eu"
spoke-local-portfolios:
  account-vending-for-spokes:
    portfolio: reinvent-cloud-engineering-governance
    associations:
      - arn:aws:iam::${AWS::AccountId}:role/IDoNotKnowTheSuffix-*
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"  
  {{< / highlight >}}
 </figure>

### Adding Launch Role Constraints

When AWS Service Catalog provisions a product from a portfolio the resources will be created by the principal who invoked
the provision product command.  This means that principal will need to have all of the permissions required to create
each of the resources specified in the product.  If you would like to delegate the creation of the resources to a service
role you can do so using a launch role constraint.

Launch role constraints specify for a given portfolio, the specified products will be provisioned as service role - 
which needs to be assumable by the Service Catalog service.

Here is an example of to configure this:

 <figure>
  {{< highlight js >}}
accounts:
  - account_id: "<YOUR_ACCOUNT_ID_WITHOUT_HYPHENS>"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
      - "eu-west-2"
    tags:
      - "type:prod"
      - "partition:eu"
spoke-local-portfolios:
  account-vending-for-spokes:
    portfolio: reinvent-cloud-engineering-governance
    constraints:
      launch:
        - products: "VPC-*"
          roles:
            - arn:aws:iam::${AWS::AccountId}:role/MyServiceCatalogAdminRole
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"  
  {{< / highlight >}}
 </figure>

Please note the solution will replace ${AWS::AccountId} with the account id of the target account where the portfolio 
will be share to.

When you specify VPC-* as the products value the solution will look for all products that match the wildcard and then
set up a launch role constraint.

When using launch role constraints it may be useful for your spoke local portfolio to depend_on a stack or launch that
provisions the specified role into the spoke account.