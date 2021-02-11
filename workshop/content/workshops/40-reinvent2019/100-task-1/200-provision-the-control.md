+++
title = "Provision the control"
weight = 200
home_region = "eu-west-1"
codecommit_repo_name = "aws-config-desired-instance-types" 
codecommit_repo_branch = main" 
product_name = "aws-config-desired-instance-types"
product_version = "v1"
portfolio_name = "cloud-engineering-governance"
aliases = [
    "/40-reinvent2019/100-task-1/200-provision-the-control.html",
]
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


- For the next step you will need to know your account id.  To find your account id you can check the console, in the __top right__ drop down. It is a 12 digit number. When using your account id please __do not__ include the hyphens ('-') and do not use the angle brackets ('<','>')  

{{< figure src="/tasks/FindMyAccountNumber.png" >}}

- Copy the following snippet into the main input field and replace account_id to show your account id on the highlighted line:

 <figure>
  {{< highlight js "hl_lines=2" >}}
accounts:
  - account_id: "<YOUR_ACCOUNT_ID_WITHOUT_HYPHENS>"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
    tags:
      - "type:prod"
      - "partition:eu"
  {{< / highlight >}}
 </figure>



it should look like the following - __but with your account id__ on the highlighted line:

 <figure>
  {{< highlight js "hl_lines=2" >}}
accounts:
  - account_id: "012345678910"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
    tags:
      - "type:prod"
      - "partition:eu"
  {{< / highlight >}}
 </figure>

### Provision the product _{{% param product_name %}}_ into a spoke account
 
- Append the following snippet to the end of the main input field:

  <figure>
   {{< highlight js "hl_lines=6-8" >}}
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
   {{< / highlight >}}
  </figure>

 
{{% notice note %}}
The CloudFormation template we used to create this product had a parameter named _InstanceType_. The highlighted lines 
show how we can use the framework to set a value for that parameter when provisioning it. 
{{% /notice %}}


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
  {{< / highlight >}}
 </figure>


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

 <figure>
  {{< highlight js "hl_lines=11-12" >}}
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
  {{< / highlight >}}
 </figure>


You told the framework to provision _{{% param product_version %}}_ of _{{% param product_name %}}_ from the portfolio 
_{{% param portfolio_name %}}_ into every account that has the tag _type:prod_

 <figure>
  {{< highlight js "hl_lines=8-11" >}}
accounts:
  - account_id: "<YOUR_ACCOUNT_ID_WITHOUT_HYPHENS>"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
    tags:
      - "type:prod"
      - "partition:eu"
  {{< / highlight >}}
 </figure>


Within each account there will be a copy of the product provisioned into each of the regions listed in the 
regions_enabled section:

 <figure>
  {{< highlight js "hl_lines=5-7" >}}
accounts:
  - account_id: "<YOUR_ACCOUNT_ID_WITHOUT_HYPHENS>"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
    tags:
      - "type:prod"
      - "partition:eu"
  {{< / highlight >}}
 </figure>


For this workshop, we are creating and provisioning the product into the same AWS Account, but in a multi-account setup, you might choose to create a product in a "hub" account and provision it only to "spoke" accounts.


{{% notice note %}}
In the workshop, you will only have permission to view the products in eu-west-1.
{{% /notice %}}

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

