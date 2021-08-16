+++
title = "Provisioning the Stack"
weight = 30
home_region = "eu-west-1"
codecommit_repo_name = "vpc" 
codecommit_repo_branch = "main" 
product_name = "vpc"
product_version = "v1"
+++
---


## What are we going to do?

We are going to perform the following steps:

- Update the manifest file

## Step by step guide

Here are the steps you need to follow to provision the stack. 


### Update the manifest file

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}} again

- Click on *manifest.yaml*

- Click *Edit*
 
- Append the following snippet to the end of the stacks section in the input field:

  <figure>
   {{< highlight js >}}
  vpc:
    name: "vpc"
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
  vpc:
    name: "vpc"
    version: "v1"
    depends_on:
      - name: "delete-default-networking" 
        type: "lambda-invocation"
        affinity: "lambda-invocation"
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
    outputs:
      ssm: 
        - param_name: "/networking/vpc/account-parameters/${AWS::AccountId}/${AWS::Region}/VPCId"
          stack_output: VPCId
      
lambda-invocations:
  delete-default-networking:
    function_name: DeleteDefaultNetworking
    qualifier: $LATEST
    invocation_type: Event
    depends_on:
      - name: "delete-default-networking-function"
        type: "stack"
        affinity: "stack"
    invoke_for:
      tags:
        - regions: "default_region"
          tag: "type:prod"

assertions:
  assert-no-default-vpcs:
    expected:
      source: manifest
      config:
        value:
          - ""
    actual:
      source: boto3
      config:
        client: 'ec2'
        call: describe_vpcs
        arguments: {}
        use_paginator: true
        filter: Vpcs[?IsDefault==`true`].State
    depends_on:
      - name: "delete-default-networking"
        type: "lambda-invocation"
        affinity: "lambda-invocation"
    assert_for:
      tags:
        - regions: regions_enabled
          tag: type:prod
 {{< / highlight >}}
 </figure>


#### Committing the manifest file

_Now that we have updated the manifest file we are ready to commit it._

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
  vpc:
    name: "vpc"
    version: "v1"
    depends_on:
      - name: "delete-default-networking" 
        type: "lambda-invocation"
        affinity: "lambda-invocation"
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
  {{< / highlight >}}
 </figure>


You told the framework to provision _{{% param product_version %}}_ of _{{% param product_name %}}_ into the default region of each account that has the tag _type:prod_


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

