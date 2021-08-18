+++
title = "Asserting the resources are removed"
weight = 50
home_region = "eu-west-1"
codecommit_repo_name = "delete-default-networking-function" 
codecommit_repo_branch = "main" 
product_name = "delete-default-networking-function"
product_version = "v1"
+++
---


## What are we going to do?

We are going to perform the following steps:

- Define an assertion

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Define an assertion

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}} again

- Click on *manifest.yaml*

- Click *Edit*
 
- Append the following snippet to the end of the main input field:

 <figure>
  {{< highlight js >}}
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
    assert_for:
      tags:
        - regions: regions_enabled
          tag: type:prod
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
    capabilities:
      - CAPABILITY_NAMED_IAM
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
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

The YAML we pasted in the previous step told the framework to use the ec2 client from boto3 to describe vpcs.  We told 
the framework not to use any arguments when invoking describe vpcs and we told the framework to use a paginator ensuring
we find every page of results.  We then used a filter to include only VPCs where the IsDefault attribute is set to true

