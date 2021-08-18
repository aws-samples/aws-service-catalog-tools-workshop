+++
title = "Using parameters in the real world"
weight = 125

+++
---

## What are we going to do?

This article will show you how to manage parameters across your Service Catalog Tools environment.  It is a collection 
of real world examples of how to use parameters for organization unit, account and region level wide configurations. 


## Using parameters (basic usage)

When you specify a launch you can specify parameters.  Here is an example where a vpc is provisioned into the *default
region* of each account tagged as *type:spoke*:

 <figure>
  {{< highlight yaml >}}
launches:
  networking:
    portfolio: "networking"
    product: "vpc"
    version: "v1"
    parameters:
      cidr:
        default: "10.0.0.1/24"
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
  {{< / highlight >}}
 </figure>

You could have also retrieved the value from SSM:

 <figure>
  {{< highlight yaml >}}
launches:
  networking:
    portfolio: "networking"
    product: "vpc"
    version: "v1"
    parameters:
      cidr:
        ssm: 
          name: "/multi-account-config/networking/vpc/default/cidr"
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
  {{< / highlight >}}
 </figure>

This makes it dynamic but what happens if you want to have a different value for each region?

## Using mappings for parameters

You can use a mapping to make this more configurable:

 <figure>
  {{< highlight yaml >}}
mappings:
  VPCs:
    us-east-1:
      "cidr": "10.0.0.1/24"
    us-west-1:
      "cidr": "192.168.0.1/26"

launches:
  networking:
    portfolio: "networking"
    product: "vpc"
    version: "v1"
    parameters:
      cidr:
        mapping: [VPCs, AWS::Region, cidr] 
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
  {{< / highlight >}}
 </figure>

With the above configuration you are saying when provisioning *vpc* into *us-east-1* use *10.0.0.1/24* and when 
provisioning into *us-west-1* use *192.168.0.1/26*.  This allows you to have a different parameter value for each region 
but that value will be the same for every launch.  To make it different per account you can use the following:

 <figure>
  {{< highlight yaml >}}
mappings:
  VPCs:
    0123456789010:
      "cidr": "10.0.0.1/24"
    0098765432110:
      "cidr": "192.168.0.1/26"

launches:
  networking:
    portfolio: "networking"
    product: "vpc"
    version: "v1"
    parameters:
      cidr:
        mapping: [VPCs, AWS::AccountId, cidr]
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
{{< / highlight >}}
 </figure>

With the above configuration you are saying when provisioning *vpc* into account *0123456789010* use *10.0.0.1/24* and 
when provisioning into account *0098765432110* use *192.168.0.1/26*.  This allows you to have a different parameter 
value for each account but you will have to update your manifest file each time you want to add an account.

## Using intrinsic functions in ssm parameter names

You can use the account id and region name within the SSM parameter name value to use account and region specific ssm
parameters:

 <figure>
  {{< highlight yaml >}}
launches:
  networking:
    portfolio: "networking"
    product: "vpc"
    version: "v1"
    parameters:
      cidr:
        ssm:
          name: "/vpcs/${AWS::AccountId}/${AWS::Region}/cidr"
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
{{< / highlight >}}
 </figure>

Each time vpc is provisioned into a region of an account the region name and account id will be used to substitute 
values in the ssm name attribute.  For example, when you provision into *us-east-1* of account *012345678910* the ssm
parameter used to get the value for the *cidr* parameter will be the one with the name 
*"/vpcs/012345678910/us-east-1/cidr"*.

## Storing values in ssm using intrinsic functions

You can store the stack outputs for your products in SSM and use intrinsic functions to derive the name:

 <figure>
  {{< highlight yaml >}}
launches:
  networking:
    portfolio: "networking"
    product: "vpc"
    version: "v1"
    parameters:
      cidr:
        ssm:
          name: "/vpcs/${AWS::AccountId}/${AWS::Region}/cidr"
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
    outputs:
      ssm:
        - param_name: "/vpcs/${AWS::AccountId}/${AWS::Region}/id"
          stack_output: VPCId
{{< / highlight >}}
 </figure>

When you provision into *us-east-1* of account *012345678910* the ssm parameter used to store the stack output will 
have the name of *"/vpcs/012345678910/us-east-1/id"*

## Customer provided parameters

If you have built a self-service / account vending mechanism you may want to allow the customers of your solution to set 
some parameters to be used later on - for example whether they require a connected account or not, if they want private
subnets or public or even if they want to have networking at all or not.  

If you are vending accounts by provisioning a product into your Service Catalog Tools account you have a very easy 
option.  Include an SSM parameter into your account creation product.  The name of the parameter should be derived 
from the account id of the newly created account:

 <figure>
  {{< highlight yaml >}}
AWSTemplateFormatVersion: '2010-09-09'
Parameters:
  NetworkType:
    Type: String
    AllowedValues" : ["connected", "private", "public", "none"]
    Description: Type of networking setup required
Resources:
  Account:
    Type: Custom::Resource
    Description: A custom resource representing an AWS Account
    Properties:
      ServiceToken: !Ref AccountCreatorLambdaArn
      Email: !Ref Email
      AccountName: !Ref AccountName
      IamUserAccessToBilling: !Ref IamUserAccessToBilling

  NetworkingRequired:
    Type: AWS::SSM::Parameter
    Properties:
      Name: !Sub "/networking/${Account.AccountId}/NetworkType"
      Value: !Ref NetworkType
{{< / highlight >}}
 </figure>

Please note some of the parameters and resources have been omitted from the example above.

This will create an SSM parameter in your Service Catalog Tools account that can be used in your launches:

 <figure>
  {{< highlight yaml >}}
launches:
  networking:
    portfolio: "networking"
    product: "networks"
    version: "v1"
    parameters:
      NetworkType:
        ssm:
          name: "/networking/${AWS::AccountId}/NetworkType"
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
{{< / highlight >}}
 </figure>

Within your product you can use conditions to provision the correct set of resources or you can use three launches (one
for each network type) along with a condition on whether they should do anything or not:

 <figure>
  {{< highlight yaml >}}
launches:
  networking-connected:
    portfolio: "networking"
    product: "networks"
    version: "v1"
    parameters:
      NetworkType:
        ssm:
          name: "/networking/${AWS::AccountId}/NetworkType"
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
  networking-private:
    portfolio: "networking"
    product: "networks"
    version: "v1"
    parameters:
      NetworkType:
        ssm:
          name: "/networking/${AWS::AccountId}/NetworkType"
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
  networking-private:
    portfolio: "networking"
    product: "networks"
    version: "v1"
    parameters:
      NetworkType:
        ssm:
          name: "/networking/${AWS::AccountId}/NetworkType"
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
{{< / highlight >}}
 </figure>

Example product template for private product:

 <figure>
  {{< highlight yaml >}}

AWSTemplateFormatVersion: 2010-09-09
Parameters:
  NetworkType:
    Description: Type of network to create
    Type: String
    AllowedValues" : ["connected", "private", "public", "none"]

Conditions:
  CreateNetwork: !Equals
    - !Ref NetworkType
    - private

Resources:
  Network:
    Type: 'AWS::EC2::VPC'
    Properties:
      CidrBlock: 10.0.0.0/16
      EnableDnsSupport: 'false'
      EnableDnsHostnames: 'false'

{{< / highlight >}}
 </figure>


## Using boto3 parameters

You can use the result of a boto3 call as a parameter.  

Here we are saying use the ssm client in the spoke account for the region you are provisioning the stack into to call 
get_parameter and filter the result down to Parameter.Value:

 <figure>
  {{< highlight yaml >}}

stacks:
  golden-ami-id-replicator:
    name: "ssm-parameter"
    version: "v2"
    execution: "hub"
    parameters:
      Name:
        default: "GoldenAMIId"
      Value:
        boto3:
          account_id: "${AWS::AccountId}"
          region: "${AWS::Region}"
          client: "ssm"
          call: "get_parameter"
          use_paginator: false
          arguments:
            Name: "GoldenAMIId"
          use_paginator: false
          filter: "Parameter.Value"
    deploy_to:
      tags:
        - tag: role:spoke
          regions: regions_enabled

{{< / highlight >}}
 </figure>

If you omit the region the framework will use the home region where you installed the framework and if you omit the 
account_id the framework will use the hub account where you installed the framework.

Using ${AWS::AccountId} and ${AWS::Region} evaluate to the account and region where the action is occuring.