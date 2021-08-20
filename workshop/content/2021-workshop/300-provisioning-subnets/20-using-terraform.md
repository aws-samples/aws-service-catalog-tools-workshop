+++
title = "Using Terraform"
weight = 20
home_region = "eu-west-1"
codecommit_repo_name = "subnet-terraform" 
codecommit_repo_branch = "main" 
product_name = "subnet"
product_version = "v1"
+++
---


## What are we going to do?

We are going to perform the following steps:

- Define a workspace
- Add the source code for our product
- Update the manifest file


## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Define a workspace

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}}  

- Open the *Add file* menu and click the *Create file* button


- Paste the following snippet to the main input field:

  <figure>
   {{< highlight js >}}
Schema: factory-2019-04-01
Workspaces:
  - Name: "subnet"
    Versions:
      - Name: "v1"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "subnet"
            BranchName: "main"
   {{< / highlight >}}
  </figure>


- Set your filename to *workspaces/networking.yaml*
- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/tasks/CommitChanges.png" >}}


#### What did we just do?

The YAML file we created in the CodeCommit repository told the framework to:

- create a pipeline that will take source code from a branch named {{% param codecommit_repo_branch %}} of CodeCommit repo named {{% param codecommit_repo_name %}}

#### Verify the change worked

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run. If you were very quick in making the change, the pipeline 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulFactoryRun.png" >}}

{{% notice note %}}
The screenshots may differ slightly as the design of AWS CodePipeline changes.  You should see a pipeline where each 
stage is green.
{{% /notice %}}


### Add the source code for our product

When you configured your product version, you specified the following version: 

 <figure>
  {{< highlight js >}}
    Versions:
      - Name: "v1"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "subnet"
            BranchName: "main"
  {{< / highlight >}}
 </figure>


This tells the framework the source code for the product comes from the _{{% param codecommit_repo_branch %}}_ branch of a
_CodeCommit_ repository of the name _{{% param codecommit_repo_name %}}_. 

We now need to create the CodeCommit repository and add the AWS CloudFormation template we are going to use for our
workspace.

- Navigate to {{% codecommit_link %}}

- Click *Create repository*

{{< figure src="/tasks/CreateRepository.png" >}}

- Input the name `{{% param codecommit_repo_name %}}`

{{< figure src="/tasks/InputTheName.png" >}}

- Click *Create*

{{< figure src="/tasks/ClickCreate.png" >}}

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/tasks/create_file.png" >}}

- Copy the following snippet into the main input field:

 <figure>
 {{< highlight js >}}

variable "VPCId" {
  type = string
}

variable "SubnetCIDR" {
  type = string
}

resource "aws_subnet" "main" {
  vpc_id     = var.VPCId
  cidr_block = var.SubnetCIDR
}
 {{< / highlight >}}
</figure>


- Set the *File name* to `subnet.tf`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


{{% notice note %}}
The name or number of files does not matter when you are creating your own workspaces using Terraform.
{{% /notice %}}

Creating that file should trigger your 
{{% codepipeline_pipeline_link "workspace--subnet-v1-pipeline" %}}.  

Once the pipeline has completed it should show the stages in green to indicate 
they have completed successfully:

{{< figure src="/tasks/SuccessfulFactoryProductRun.png" >}}

{{% notice tip %}}
You should see your commit message on this screen, it will help you know which version of ServiceCatalogFactory repository the 
pipeline is processing. 

{{% /notice %}}

{{% notice note %}}
The screenshots may differ slightly as the design of AWS CodePipeline changes.  You should see a pipeline where each 
stage is green.

{{% /notice %}}


You have now successfully created a stack! 

#### Verify the stack is present in Amazon S3

Now that you have verified the pipeline has run correctly you can go to Amazon S3 to view the stack.

- Navigate to [https://s3.console.aws.amazon.com/s3/home](https://s3.console.aws.amazon.com/s3/home)

- Select the bucket named sc-puppet-stacks-repository-<account_id>

- Navigate to workspace/{{% param product_name %}}/{{% param product_version %}} where you should see an object named workspace.zip


### Update the manifest file

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}} again

- Click on *manifest.yaml*

- Click *Edit*
 
- Append the following snippet to the end of the file in the input field:

  <figure>
   {{< highlight js >}}
workspaces:
  subnet:
    name: "subnet"
    version: "v1"
    depends_on:
      - name: vpc
        type: stack
        affinity: stack
    parameters:
      VPCID:
        ssm: 
          name: "/networking/vpc/account-parameters/${AWS::AccountId}/${AWS::Region}/VPCId"
      SubnetCIDR:
        default: '10.0.1.0/24'
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
    capabilities:
      - CAPABILITY_NAMED_IAM
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
        value: []
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

launches:
  subnet:
    portfolio: "networking-mandatory"
    product: "subnet"
    version: "v1"
    depends_on:
      - name: vpc
        type: stack
        affinity: stack
    parameters:
      VPCID:
        ssm: 
          name: "/networking/vpc/account-parameters/${AWS::AccountId}/${AWS::Region}/VPCId"
      SubnetCIDR:
        default: '10.0.0.0/24'
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"

workspaces:
  subnet:
    name: "subnet"
    version: "v1"
    depends_on:
      - name: vpc
        type: stack
        affinity: stack
    parameters:
      VPCID:
        ssm: 
          name: "/networking/vpc/account-parameters/${AWS::AccountId}/${AWS::Region}/VPCId"
      SubnetCIDR:
        default: '10.0.1.0/24'
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
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
workspaces:
  subnet:
    name: "subnet"
    version: "v1"
    depends_on:
      - name: vpc
        type: stack
        affinity: stack
    parameters:
      VPCID:
        ssm: 
          name: "/networking/vpc/account-parameters/${AWS::AccountId}/${AWS::Region}/VPCId"
      SubnetCIDR:
        default: '10.0.1.0/24'
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

You have now successfully provisioned a workspace.
