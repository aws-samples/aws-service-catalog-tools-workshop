+++
title = "Using AWS Service Catalog"
weight = 15

home_region = "eu-west-1"
codecommit_repo_name = "subnet" 
codecommit_repo_branch = "main" 
product_name = "subnet"
product_version = "v1"
portfolio_name = "networking-mandatory"

+++
---


## What are we going to do?

We are going to perform the following steps:

- Define a product with a version and a portfolio
- Add the source code for our product
- Provision the product _{{% param product_name %}}_ into a spoke account

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Define a product with a version and a portfolio

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}}  

- Open the *Add file* menu and click the *Create file* button

- Copy the following snippet into the main input field:
 
  <figure>
   {{< highlight js >}}
Schema: factory-2019-04-01
Products:
  - Name: "subnet"
    Owner: "networking@example.com"
    Description: "subnet for networking"
    Distributor: "networking team"
    SupportDescription: "Speak to networking@example.com about exceptions and speak to cloud-engineering@example.com about implementation issues"
    SupportEmail: "cloud-engineering@example.com"
    SupportUrl: "https://wiki.example.com/cloud-engineering/networking/subnet"
    Tags:
      - Key: "type"
        Value: "governance"
      - Key: "creator"
        Value: "cloud-engineering"
      - Key: "cost-center"
        Value: "governance"
    Versions:
      - Name: "v1"
        Description: "v1 of subnet"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "subnet"
            BranchName: "main"
    Portfolios:
      - "mandatory"
Portfolios:
  - DisplayName: "mandatory"
    Description: "Portfolio containing the mandatory networking components"
    ProviderName: "cloud-engineering"
    Associations:
      - "arn:aws:iam::${AWS::AccountId}:role/<INSERT YOUR ROLE NAME HERE>"
    Tags:
      - Key: "type"
        Value: "governance"
      - Key: "creator"
        Value: "cloud-engineering"
      - Key: "cost-center"
        Value: "governance"
   {{< / highlight >}}
  </figure>

 
- Set the *File name* to *portfolios/networking.yaml*

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/tasks/CommitChanges.png" >}}


#### What did we just do?

The YAML file we created in the CodeCommit repository told the framework to perform several actions:

- create a product named _{{% param product_name %}}_
- add a _{{% param product_version %}}_ of our product
- create a portfolio named _{{% param portfolio_name %}}_
- add the product: _{{% param product_name %}}_ to the portfolio: _{{% param portfolio_name %}}_

#### Verify the change worked

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run. If you were very quick in making the change, the pipeline 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulFactoryRun.png" >}}


### Add the source code for our product

When you configured your product version, you specified the following version: 

 <figure>
  {{< highlight js >}}
    Versions:
      - Name: "v1"
        Description: "v1 of subnet"
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
  SubnetCIDR:
    Type: String
    Description: |
      Subnet to use for the Subnet
  VPCID:
    Type: String
    Description: |
      VPC to create Subnet in
Resources:
  Subnet:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId:
        Ref: VPCID
      CidrBlock: 
        Ref: SubnetCIDR
      AvailabilityZone: !Select 
          - 0
          - !GetAZs 
            Ref: 'AWS::Region'
 {{< / highlight >}}
</figure>


- Set the *File name* to `product.template.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

Creating that file should trigger your 
{{% codepipeline_pipeline_link "subnet-v1-pipeline" %}}.  

Once the pipeline has completed it should show the stages in green to indicate they have completed successfully:

{{< figure src="/tasks/SuccessfulFactoryProductRun.png" >}}

{{% notice tip %}}
You should see your commit message on this screen, it will help you know which version of ServiceCatalogFactory repository the 
pipeline is processing.
{{% /notice %}}

Once you have verified the pipeline has run you can go to {{% service_catalog_products_list_link %}} to view your newly
created version.

You should see the product you created listed:

{{< figure src="/tasks/SeeYourTask1Product.png" >}}

Click on the product and verify *{{% param product_version %}}* is there

{{< figure src="/tasks/SeeYourTask1ProductVersion1.png" >}}

{{% notice note %}}
If you cannot see your version please raise your hand for some assistance
{{% /notice %}}

You have now successfully created a version for your product! 

#### Verify the product was added to the portfolio


Now that you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} to view your
portfolio.

- Click on *{{% param portfolio_name %}}*

{{< figure src="/tasks/PortfolioReinventCloudEngineeringGovernance.png" >}}

- Click on the product *_{{% param product_name %}}_*

- Click on the version *_{{% param product_version %}}_*

{{< figure src="/tasks/ClickAwsConfigS3BucketServerSideEncryptionEnabledV1.png" >}}



### Provision the product _{{% param product_name %}}_ into a spoke account
 
- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}} again

- Click on *manifest.yaml*

- Click *Edit*
 
- Append the following snippet to the end of the main input field:

  <figure>
   {{< highlight js >}}
launches:
  subnet:
    portfolio: "networking-mandatory"
    product: "subnet"
    version: "v1"
    depends_on:
      name: vpc
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

launches:
  subnet:
    portfolio: "networking-mandatory"
    product: "subnet"
    version: "v1"
    depends_on:
      name: vpc
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
 {{< / highlight >}}
 </figure>


#### Committing the manifest file


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

- provision a product named _{{% param product_name %}}_ into the default region of the account

When you added the following:

 <figure>
  {{< highlight js >}}
launches:
  subnet:
    portfolio: "networking-mandatory"
    product: "subnet"
    version: "v1"
    depends_on:
      name: vpc
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
  {{< / highlight >}}
 </figure>


You told the framework to provision _{{% param product_version %}}_ of _{{% param product_name %}}_ from the portfolio 
_{{% param portfolio_name %}}_ into every account that has the tag _type:prod_

 <figure>
  {{< highlight js "hl_lines=7-9" >}}
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


Within each account there will be a copy of the product provisioned into the default region:

 <figure>
  {{< highlight js "hl_lines=4" >}}
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



#### Verifying the provisioned product

Once you have made your changes the {{% service_catalog_puppet_pipeline_link %}} should have run. If you were quick in making the change, the pipeline 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the stages in green to indicate they have completed successfully:

{{< figure src="/tasks/SuccessfulPuppetRun.png" >}}

Once you have verified the pipeline has run you can go to {{% service_catalog_provisioned_products_link %}} to view your 
provisioned product.  Please note when you arrive at the provisioned product page you will need to select account from 
the filter by drop down in the top right:

{{< figure src="/tasks/FilterByAccount.png" >}}

You have now successfully provisioned a product
