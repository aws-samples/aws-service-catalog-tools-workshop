+++
title = "Provision the control"
weight = 200
home_region = "eu-west-1"
codecommit_repo_name = "aws-config-desired-instance-types" 
codecommit_repo_branch = "master" 
product_name = "aws-config-desired-instance-types"
product_version = "v1"
portfolio_name = "cloud-engineering-governance"
+++
---


## What are we going to do?

We are going to perform the following steps:

- create a manifest file with our account in it
- provision the product _{{% param product_name %}}_ into our account

## Step by step guide

Here are the steps you need to follow to provision the control. In the previous task, we created an AWS Service Catalog product but it has not yet been provisioned.


### Create a manifest file with our account in it

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/tasks/create_file.png" >}}

- Copy the following snippet into the main input field and replace account_id to show your account id on the highlighted line:

{{% code file="40-reinvent2019/100-task-1/artefacts/orchestrator/manifest-accounts-only.yaml" language="js" highlight="2" %}}

{{% notice note %}}
You can find your Account Number in the __top right__ drop down of the AWS Console page. It is a 12 digit number. Please __do not__ include the hyphens ('-') in the manifest code.
{{% /notice %}}

{{< figure src="/tasks/FindMyAccountNumber.png" >}}


### Provision the product _{{% param product_name %}}_ into a spoke account
 
- Append the following snippet to the end of the main input field:

 {{% code file="40-reinvent2019/100-task-1/artefacts/orchestrator/manifest-launches-only.yaml" language="js" highlight="6-8" %}}
 
{{% notice note %}}
The CloudFormation template we used to create this product had a parameter named _InstanceType_. The highlighted lines 
show how we can use the framework to set a value for that parameter when provisioning it. 
{{% /notice %}}


- The main input field should look like this (remember to set your account_id):

 {{% code file="40-reinvent2019/100-task-1/artefacts/orchestrator/manifest-all.yaml" language="js" %}}


#### Committing the manifest file

_Now that we have written the manifest file we are ready to commit it._

- Set the *File name* to `manifest.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/tasks/CommitChanges.png" >}}


#### What did we just do?

The YAML file we created in the previous step told the framework to perform the following actions:

- provision a product named _{{% param product_name %}}_ into each of the enabled regions of the account

When you added the following:

{{% code file="40-reinvent2019/100-task-1/artefacts/orchestrator/manifest-launches-only.yaml" language="js" highlight="11-12" %}}

You told the framework to provision _{{% param product_version %}}_ of _{{% param product_name %}}_ from the portfolio 
_{{% param portfolio_name %}}_ into every account that has the tag _type:prod_

{{% code file="40-reinvent2019/100-task-1/artefacts/orchestrator/manifest-accounts-only.yaml" language="js" highlight="8-11" %}}

Within each account there will be a copy of the product provisioned into each of the regions listed in the 
regions_enabled section:

{{% code file="40-reinvent2019/100-task-1/artefacts/orchestrator/manifest-accounts-only.yaml" language="js" highlight="5-7" %}}

For this workshop, we are creating and provisioning the product into the same AWS Account, but in a multi-account setup, you might choose to create a product in a "hub" account and provision it only to "spoke" accounts.

#### Verifying the provisioned product


Once you have made your changes the {{% service_catalog_puppet_pipeline_link %}} should have run. If you were quick in making the change, the pipeline 
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

#### Verify that the AWS Config rule is enabled

To see the AWS Config rule enabled, navigate to {{% config_rules_list_link %}}.  Once there you should see the 
following:

{{< figure src="/tasks/aws-config-rule-enabled.png" >}}

