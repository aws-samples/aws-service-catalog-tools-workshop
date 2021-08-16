+++
title = "Creating the Stack"
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

- Define a stack
- Add the source code for our product


## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Define a stack

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}}  

- Click on stacks

- Click on network-workshop.yaml

- Click on edit

- Append the following snippet to the main input field:
 
  <figure>
   {{< highlight js >}}
  - Name: "vpc"
    Versions:
      - Name: "v1"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "vpc"
            BranchName: "main"
   {{< / highlight >}}
  </figure>

 
- The full file should look like this:

  <figure>
   {{< highlight js >}}
Schema: factory-2019-04-01
Stacks:
  - Name: "delete-default-networking-function"
    Versions:
      - Name: "v1"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "delete-default-networking-function"
            BranchName: "main"
  - Name: "vpc"
    Versions:
      - Name: "v1"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "vpc"
            BranchName: "main"
   {{< / highlight >}}
  </figure>


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
            RepositoryName: "vpc"
            BranchName: "main"
  {{< / highlight >}}
 </figure>


This tells the framework the source code for the product comes from the _{{% param codecommit_repo_branch %}}_ branch of a
_CodeCommit_ repository of the name _{{% param codecommit_repo_name %}}_. 

We now need to create the CodeCommit repository and add the AWS CloudFormation template we are going to use for our
product.

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

AWSTemplateFormatVersion: '2010-09-09'
Description: |
  Builds out a VPC for use
Parameters:
  VPCCIDR:
    Type: String
    Default: '10.0.0.0/16'
    Description: |
      Subnet to use for the VPC
Resources:
  VPC:
    Type: AWS::EC2::VPC
    Description: The vpc being created
    Properties:
      EnableDnsSupport: true
      EnableDnsHostnames: true
      CidrBlock: !Ref VPCCIDR

Outputs:
  VPCId:
    Description: The ID of the VPC that was created
    Value: !Ref VPC

 {{< / highlight >}}
</figure>


- Set the *File name* to `stack.template.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

Creating that file should trigger your 
{{% codepipeline_pipeline_link "stack--vpc-v1-pipeline" %}}.  

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

- Navigate to stack/{{% param product_name %}}/{{% param product_version %}} where you should see an object named stack.template.yaml

