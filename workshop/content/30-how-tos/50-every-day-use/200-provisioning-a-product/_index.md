+++
title = "Provisioning a product"
weight = 200
home_region = "eu-west-1"
+++
---

## What are we going to do?

This tutorial will walk you through "{{% param title %}}" into a spoke account.

We will assume you have:
 
 - installed Service Catalog Puppet correctly
 - you have bootstrapped a spoke
 - you have created a product
 - you have created a portfolio

We are going to perform the following steps:

- create a manifest file
- add an account to the manifest file
- add a launch to the manifest file

During this process you will check your progress by verifying what the framework is doing at each step.

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Creating the manifest file

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/how-tos/creating-and-provisioning-a-product/create_file.png" >}}

### Adding an account to the manifest file

- Copy the following snippet into the main input field:

 {{% code file="30-how-tos/50-every-day-use/200-provisioning-a-product/artefacts/orchestrator/manifest-accounts-only.yaml" language="js" %}}
 
- Update account_id on line to show your account id

### Adding a launch to the manifest

_Now we are ready to add a product to the manifest file._

- Add the following snippet to the end of the main input field:

 {{% code file="30-how-tos/50-every-day-use/200-provisioning-a-product/artefacts/orchestrator/manifest-launches-only.yaml" language="js" %}}

- The main input field should look like this:

 {{% code file="30-how-tos/50-every-day-use/200-provisioning-a-product/artefacts/orchestrator/manifest-all.yaml" language="js" %}}


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


### Verifying the provisioning

Once you have made your changes the {{% service_catalog_puppet_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SuccessfulPuppetRun.png" >}}

Once you have verified the pipeline has run you can go to {{% service_catalog_provisioned_products_link %}} to view your 
provisioned product.  Please note when you arrive at the provisioned product page you will need to select account from 
the filter by drop down in the top right:

{{< figure src="/how-tos/creating-and-provisioning-a-product/FilterByAccount.png" >}}

You have now successfully provisioned a product! When provisioned, this product will automatically enable AWS Config.
