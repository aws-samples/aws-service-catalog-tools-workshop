+++
title = "Create the control"
weight = 100
home_region = "eu-west-1"
codecommit_repo_name = "aws-config-desired-instance-types" 
codecommit_repo_branch = "master" 
product_name = "aws-config-desired-instance-types"
product_version = "v1"
portfolio_name = "cloud-engineering-governance"
+++
---

## What are we going to do?

We are going to perform the following steps:

- define a product with a version and a portfolio in a hub account
- add the source code for the product
- provision that product into a spoke account

The hub AWS Account is the source of truth for our AWS Service Catalog products. Spoke AWS accounts are consumers of these products, you can think of them as accounts that need governance controls applied. For this workshop, we are using the same account as both the hub and spoke for simplicity; in a multi-account setup, these could be separate AWS Accounts and Regions. 

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Define a product with a version and a portfolio

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}}  

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/tasks/create_file.png" >}}

- Copy the following snippet into the main input field:
 
  <figure>
   {{< highlight js >}}
Schema: factory-2019-04-01
Products:
  - Name: "aws-config-desired-instance-types"
    Owner: "budget-and-cost-governance@example.com"
    Description: "Enables AWS Config rule - desired-instance-type with our RIs"
    Distributor: "cloud-engineering"
    SupportDescription: "Speak to budget-and-cost-governance@example.com about exceptions and speak to cloud-engineering@example.com about implementation issues"
    SupportEmail: "cloud-engineering@example.com"
    SupportUrl: "https://wiki.example.com/cloud-engineering/budget-and-cost-governance/aws-config-desired-instance-types"
    Tags:
      - Key: "type"
        Value: "governance"
      - Key: "creator"
        Value: "cloud-engineering"
      - Key: "cost-center"
        Value: "governance"
    Versions:
      - Name: "v1"
        Description: "v1 of aws-config-desired-instance-types"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "aws-config-desired-instance-types"
            BranchName: "master"
    Portfolios:
      - "cloud-engineering-governance"
Portfolios:
  - DisplayName: "cloud-engineering-governance"
    Description: "Portfolio containing the products needed to govern AWS accounts"
    ProviderName: "cloud-engineering"
    Associations:
      - "arn:aws:iam::${AWS::AccountId}:role/TeamRole"
    Tags:
      - Key: "type"
        Value: "governance"
      - Key: "creator"
        Value: "cloud-engineering"
      - Key: "cost-center"
        Value: "governance"
   {{< / highlight >}}
  </figure>

 
- Set the *File name* to `portfolios/reinvent.yaml`

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

{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}


### Add the source code for our product

When you configured your product version, you specified the following version: 

 <figure>
  {{< highlight js >}}
    Versions:
      - Name: "v1"
        Description: "v1 of aws-config-desired-instance-types"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "aws-config-desired-instance-types"
            BranchName: "master"
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
 AWSTemplateFormatVersion: "2010-09-09"
 Description: "Create an AWS Config rule ensuring the given instance types are the only instance types used"
 
 Parameters:
   InstanceType:
     Type: String
     Description: "Comma separated list of EC2 instance types (for example, 't2.small, m4.large')."
     Default: "t2.micro, t2.small"
 
 Resources:
   AWSConfigRule:
     Type: AWS::Config::ConfigRule
     Properties:
       ConfigRuleName: "desired-instance-type"
       Description: "Checks whether your EC2 instances are of the specified instance types."
       InputParameters:
         instanceType: !Ref InstanceType
       Scope:
         ComplianceResourceTypes:
           - "AWS::EC2::Instance"
       Source:
         Owner: AWS
         SourceIdentifier: DESIRED_INSTANCE_TYPE
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
{{% codepipeline_pipeline_link "aws-config-desired-instance-types-v1-pipeline" %}}.  

Once the pipeline has completed it should show the *Source*, *Tests*, *Package* and *Deploy* stages in green to indicate 
they have completed successfully:

{{< figure src="/tasks/SuccessfulFactoryProductRun.png" >}}

{{% notice tip %}}
You should see your commit message on this screen, it will help you know which version of ServiceCatalogFactory repository the 
pipeline is processing.
{{% /notice %}}

{{% notice note %}}
If this is failing please raise your hand for some assistance
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

- Click on *reinvent-cloud-engineering-governance*

{{< figure src="/tasks/PortfolioReinventCloudEngineeringGovernance.png" >}}

- Click on the product *_{{% param product_name %}}_*

- Click on the version *_{{% param product_version %}}_*

{{< figure src="/tasks/ClickAwsConfigS3BucketServerSideEncryptionEnabledV1.png" >}}
