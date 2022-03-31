+++
title = "Using stack and launch outputs"
weight = 386
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
 - provisioning stacks
 - provisioning products / launches

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Things to note, before we start

- The cloudformation_stack_output feature was added in version 0.150.0 of Service Catalog Puppet.  You will need to be using this version (or later)
- The servicecatalog_provisioned_product_output feature was added in version 0.160.0 of Service Catalog Puppet.  You will need to be using this version (or later)

### Provision a stack with some outputs

In order to use a stack output you must first provision a stack that provides the output.  Here is an example of such a
template:

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

Here we are provisioning a stack that outputs VpcId as an output.

### Provisioning a stack that depends on the initial stack, which consumes stack outputs

Once you have provisioned the stack that provides the output you will need to define a stack that uses the output:

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

Here we are defining a stack that uses VpcId as a parameter.

### Provision a stack using Service Catalog Puppet

_Now we are ready to provision the stack using the manifest file._

To use the output from one stack as a parameter for another you can use the following syntax:

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

In this example we are reading VpcCidrBlock and VpcId from the stack named example-vpc when provisioning the stack named
example-subnet.

### Working with ServiceCatalog Provisioned product outputs

If you would like to obtain the output of a provisioned product deployment, it is possible to call 
the `servicecatalog_provisioned_product_output` method to obtain stack outputs. In the example below we are calling from
the output of a launch called 'example-vpc'

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

