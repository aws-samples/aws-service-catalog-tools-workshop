+++
title = "Work with stack outputs"
weight = 600
home_region = "eu-west-1"
+++
---

## What are we going to do?

This tutorial will walk you through how to use the "{{% param title %}}" feature.

We will assume you have:
 
 - installed Service Catalog Puppet correctly
 - bootstrapped a spoke
 - created a manifest file
 - added an account to the manifest file

 We will assume you are comfortable:
 - making changes your portfolios files
 - making changes your manifest file

We are going to perform the following steps to "{{% param title %}}":

- creating a stack using Service Catalog Factory
- provision a stack using Service Catalog Puppet
- creating a dependent stack with Service Catalog Factory
- consume a stack output from the initial stack that we provisioned

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Things to note, before we start

- The stacks feature was added in version 0.63.0 of Service Catalog Factory.  You will need to be using this version (or later)
- This feature was added in version 0.152.0 of Service Catalog Puppet.  You will need to be using this version (or later)
- Stacks can use parameters, deploy_to and outputs
- Stacks can be used in spoke execution mode
- Stacks can be used in dry-runs
- Stacks can be provisioned in spoke execution mode (since Service Catalog Puppet version 0.109.0)
- Stacks do not appear in list-launches (they are not a launch)

## Creating a stack using Service Catalog Factory

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} 

- click _Add file_ and then _Create file_

- Paste the following into the main input window:

- In the _File name_ field enter the following `stacks/example.yaml`

 <figure>
  {{< highlight js >}}
Schema: factory-2019-04-01
Stacks:
  - Name: "example-vpc"
    Versions:
      - Name: "v1"
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "example-vpc"
            BranchName: "main"
  {{< / highlight >}}
 </figure>

- Please note the file name is not significant but it must have the extension `.yaml` and it must be in a directory named `stacks`

- Fill in the other fields and save the file.  Once you do the pipeline `servicecatalog-factory-pipeline` will run.  

- Once the pipeline is complete you will have a new pipeline named `stack--example-vpc-v1-pipeline`

- You should navigate to AWS CodeCommit, create a repo named `example-vpc` and add a file named `stack.template.yaml` with the following content on the `main` branch:

 <figure>
  {{< highlight js >}}
Parameters:
  CidrBlock:
    Type: String
  Name:
    Type: String

Resources:
  VPC:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: !Ref CidrBlock
      EnableDnsHostnames: True
      EnableDnsSupport: True
      Tags:
        - Key: Name
          Value: !Ref Name
Outputs:
  VpcId:
    Value: !Ref VPC
    Description: Output VPC ID for utilisation by dependent product
  VpcCidrBlock:
    Value: !GetAtt VPC.CidrBlock
{{< / highlight >}}
 </figure>

- Once you have added the file the pipeline `stack--example-vpc-v1-pipeline` will run.  It will take the source code and add will add it to Amazon S3 so you can use it in Service Catalog Puppet in the step below. 


## Provision a stack using Service Catalog Puppet

_Now we are ready to provision the stack using the manifest file._

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}

- Click the *ServiceCatalogPuppet* repository

- Click the link to the *manifest.yaml* file, and then click the *Edit* button

- Add the following snippet to the end of the main input field:

 <figure>
  {{< highlight js >}}
stacks:
  example-vpc:
    name: example-vpc
    version: v1
    parameters:
      Name:
        default: "example-vpc"
      CidrBlock:
        default: "10.0.0.0/16"
    deploy_to:
      tags:
        - tag: type:prod
          regions: regions_enabled
  {{< / highlight >}}
 </figure>

### Capabilities

In some cases, you must explicitly acknowledge that your stack template contains certain capabilities in order for 
CloudFormation to create the stack.  

### Committing the manifest file

_Now that we have updated the manifest file we are ready to commit our changes._

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/how-tos/invoking-a-lambda-function/commit_changes.png" >}}

## Provisioning a stack that depends on the initial stack, which consumes stack outputs

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} 

- click _stacks_ 

- click _example.yaml_

- click _Edit_

- Paste the following into the main input window:

 <figure>
  {{< highlight js >}}
Schema: factory-2019-04-01
Stacks:
  - Name: "example-subnet"
    Versions:
      - Name: "v1"
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "example-subnetc"
            BranchName: "main"
  {{< / highlight >}}
 </figure>

- Please note the file name is not significant but it must have the extension `.yaml` and it must be in a directory named `stacks`

- Fill in the other fields and save the file.  Once you do the pipeline `servicecatalog-factory-pipeline` will run.  

- Once the pipeline is complete you will have a new pipeline named `stack--example-subnet-v1-pipeline`

- You should navigate to AWS CodeCommit, create a repo named `example-subnet` and add a file named `stack.template.yaml` with the following content on the `main` branch:

 <figure>
  {{< highlight js >}}
Parameters:
  CidrBlock:
    Type: String
  VpcId:
    Type: String

Resources:
  Subnet:
    Type: AWS::EC2::Subnet
    Properties:
      CidrBlock: !Select [ 0, !Cidr [ !Ref CidrBlock, 6, 5 ]]
      AvailabilityZone: !Select
        - 0
        - Fn::GetAZs: !Ref "AWS::Region"
      Tags:
        - Key: Name
          Value: "Example-Subnet-AZ1"
      VpcId: !Ref VpcId
{{< / highlight >}}
 </figure>

- Once you have added the file the pipeline `stack--example-vpc-v1-pipeline` will run.  It will take the source code and add will add it to Amazon S3 so you can use it in Service Catalog Puppet in the step below. 


## Provision a stack using Service Catalog Puppet

_Now we are ready to provision the stack using the manifest file._

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}

- Click the *ServiceCatalogPuppet* repository

- Click the link to the *manifest.yaml* file, and then click the *Edit* button

- Add the following snippet to the end of the main input field:

 <figure>
  {{< highlight js >}}
stacks:
  example-subnet:
    name: example-subnet
    version: v1
    depends_on:
      - example-vpc
    parameters:
      CidrBlock:
        cloudformation_stack_output:
          account_id: ${AWS::AccountId}
          region: ${AWS::Region}
          stack_name: example-vpc
          output_key: VpcCidrBlock
      VpcId:
        cloudformation_stack_output:
          account_id: ${AWS::AccountId}
          region: ${AWS::Region}
          stack_name: example-vpc
          output_key: VpcId
    deploy_to:
      tags:
        - tag: type:prod
          regions: regions_enabled
  {{< / highlight >}}
 </figure>

### Capabilities

In some cases, you must explicitly acknowledge that your stack template contains certain capabilities in order for 
CloudFormation to create the stack.

### Working with ServiceCatalog Provisioned product outputs

If you would like to obtain the output of a provisioned product deployment, it is possible to call the `servicecatalog_provisioned_product_output` method to obtain stack outputs. In the example below we are calling from the output of a launch called 'example-vpc'

 <figure>
  {{< highlight js >}}
stacks:
  example-subnet:
    name: example-subnet
    version: v1
    depends_on:
      - example-vpc
    parameters:
      CidrBlock:
        servicecatalog_provisioned_product_output:
          account_id: ${AWS::AccountId}
          region: ${AWS::Region}
          provisioned_product_name: example-vpc
          output_key: VpcCidrBlock
      VpcId:
        servicecatalog_provisioned_product_output:
          account_id: ${AWS::AccountId}
          region: ${AWS::Region}
          provisioned_product_name: example-vpc
          output_key: VpcId
    deploy_to:
      tags:
        - tag: type:prod
          regions: regions_enabled
  {{< / highlight >}}
 </figure>

### Committing the manifest file

_Now that we have updated the manifest file we are ready to commit our changes._

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/how-tos/invoking-a-lambda-function/commit_changes.png" >}}

#### What did we just do?

- You created an AWS CloudFormation template for a VPC and a subnet
- You used the templates to create multiple stacks in CloudFormation
- The subnet stack consumed output parameters from the VPC stack

### Verifying the stacks have been created

Once you have made your changes the {{% service_catalog_puppet_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Deploy* stages in green to indicate they have completed 
successfully:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SuccessfulPuppetRunV2.png" >}}





