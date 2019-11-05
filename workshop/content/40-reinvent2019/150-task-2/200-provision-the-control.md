+++
title = "Provision the control"
weight = 200
home_region = "eu-west-1"
codecommit_repo_name = "aws-config-rds-storage-encrypted" 
codecommit_repo_branch = "master" 
product_name = "aws-config-rds-storage-encrypted"
product_version = "v1"
portfolio_name = "cloud-engineering-governance"
+++
---


## What are we going to do?

We are going to perform the following steps:

- provision the product _{{% param product_name %}}_ into a spoke account

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Provision the product _{{% param product_name %}}_ into a spoke account

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}} again

- Click on *manifest.yaml*

- Click *Edit*
 
- Append the following snippet to the end of the main input field:

 {{% code file="40-reinvent2019/150-task-2/artefacts/orchestrator/manifest-launches-only.yaml" language="js" %}}

- The main input field should look like this (remember to set your account_id):

 {{% code file="40-reinvent2019/150-task-2/artefacts/orchestrator/manifest-all.yaml" language="js" %}}


#### AWS Committing the manifest file

_Now that we have written the manifest file we are ready to commit it._

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/tasks/CommitChanges.png" >}}


#### What did we just do?

The YAML we pasted in the previous step told the framework to perform the following actions:

- provision a product named _{{% param product_name %}}_ into each of the enabled regions of the account


#### Verifying the provisioning


Once you have made your changes the {{% service_catalog_puppet_pipeline_link %}} should have run. If you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulPuppetRun.png" >}}


{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}

Once you have verified the pipeline has run you can go to {{% service_catalog_provisioned_products_link %}} to view your 
provisioned product.  Please note when you arrive at the provisioned product page you will need to select account from 
the filter by drop down in the top right:

{{< figure src="/tasks/FilterByAccount.png" >}}

{{% notice note %}}
If you cannot see your product please raise your hand for some assistance
{{% /notice %}}

You have now successfully provisioned a product

#### Verify the AWS Config rule is enabled

To see the AWS Config rule enabled, navigate to {{% config_rules_list_link %}}.  Once there you should see the 
following:

{{< figure src="/tasks/aws-config-rule-enabled.png" >}}

