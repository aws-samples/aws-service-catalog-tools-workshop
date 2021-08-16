+++
title = "Deploying the Lambda"
weight = 30
home_region = "eu-west-1"
codecommit_repo_name = "delete-default-networking-function" 
codecommit_repo_branch = "main" 
product_name = "delete-default-networking-function"
product_version = "v1"
+++
---


## What are we going to do?

We are going to perform the following steps:

- Create a manifest file with our account in it
- Provision the stack _{{% param product_name %}}_ into a spoke account

## Step by step guide

Here are the steps you need to follow to provision the stack. 


### Create a manifest file with our account in it

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/tasks/create_file.png" >}}


- For the next step you will need to know your account id.  To find your account id you can check the console, in the __top right__ drop down. It is a 12 digit number. When using your account id please __do not__ include the hyphens ('-') and do not use the angle brackets ('<','>')  

{{< figure src="/tasks/FindMyAccountNumber.png" >}}


{{% notice note %}}
The screenshots may differ slightly as the design of AWS CodePipeline changes.  You should see a pipeline where each 
stage is green.
{{% /notice %}}


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

### Provision the stack _{{% param product_name %}}_ into a spoke account
 
- Append the following snippet to the end of the main input field:

  <figure>
   {{< highlight js >}}
stacks:
  delete-default-networking-function:
    name: "delete-default-networking-function"
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
stacks:
  delete-default-networking-function:
    name: "delete-default-networking-function"
    version: "v1"
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

When you added the following:

 <figure>
  {{< highlight js >}}
stacks:
  delete-default-networking-function:
    name: "delete-default-networking-function"
    version: "v1"
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
  {{< / highlight >}}
 </figure>


You told the framework to provision _{{% param product_version %}}_ of _{{% param product_name %}}_ into the default region of each account that has the tag _type:prod_

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


#### Verifying the provisioned stack

Once you have made your changes the {{% service_catalog_puppet_pipeline_link %}} should have run. If you were quick in making the change, the pipeline 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulPuppetRun.png" >}}

{{% notice note %}}
The screenshots may differ slightly as the design of AWS CodePipeline changes.  You should see a pipeline where each 
stage is green.
{{% /notice %}}


Once you have verified the pipeline has run you can go to the AWS CloudFormation console in the default region of the 
account you specified to view your provisioned stack.  

You have now successfully provisioned a stack.

