+++
title = "Provision the control"
weight = 200
home_region = "eu-west-1"
codecommit_repo_name = "aws-config-rds-storage-encrypted" 
codecommit_repo_branch = "main" 
product_name = "aws-config-rds-storage-encrypted"
product_version = "v1"
portfolio_name = "cloud-engineering-governance"
aliases = [
    "/40-reinvent2019/150-task-2/200-provision-the-control.html",
]
+++
---


## What are we going to do?

We are going to perform the following steps:

- provision the product _{{% param product_name %}}_ 

For this workshop, we are using the same account as both the hub and spoke for simplicity; in a multi-account setup, products that are created in a hub account could be provisioned in multiple spoke accounts.

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Provision the product _{{% param product_name %}}_ into a spoke account

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}} again

- Click on *manifest.yaml*

- Click *Edit*
 
- Append the following snippet to the end of the main input field:

 <figure>
  {{< highlight js >}}
  aws-config-rds-storage-encrypted:
    portfolio: "reinvent-cloud-engineering-governance"
    product: "aws-config-rds-storage-encrypted"
    version: "v1"
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
  {{< / highlight >}}
 </figure>


- The main input field should look like this (remember to set your account_id):

 <figure>
  {{< highlight js >}}
accounts:
  - account_id: "<YOUR_ACCOUNT_ID_WITHOUT_HYPHENS>"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
    tags:
      - "type:prod"
      - "partition:eu"

launches:
  aws-config-desired-instance-types:
    portfolio: "reinvent-cloud-engineering-governance"
    product: "aws-config-desired-instance-types"
    version: "v1"
    parameters:
      InstanceType:
        default: "t2.medium, t2.large, t2.xlarge"
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
  aws-config-rds-storage-encrypted:
    portfolio: "reinvent-cloud-engineering-governance"
    product: "aws-config-rds-storage-encrypted"
    version: "v1"
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
 {{< / highlight >}}
 </figure>



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

Once it has completed it should show the *Source*, *Generate* and *Deploy* stages in green to indicate they have completed 
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

