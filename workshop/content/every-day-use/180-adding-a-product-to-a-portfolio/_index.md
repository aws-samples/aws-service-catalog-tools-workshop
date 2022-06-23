+++
title = "Adding a product to a portfolio"
weight = 180
home_region = "eu-west-1"
+++
---

## What are we going to do?

This tutorial will walk you through "{{% param title %}}" into a spoke account.

We will assume you have:
 
 - installed Service Catalog Puppet correctly
 - you have created a product
 - you have created a portfolio

We are going to perform the following steps:

- add a product to a portfolio

During this process you will check your progress by verifying what the framework is doing at each step.

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Add the product to the portfolio

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} again

- Click on *portfolios*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickOnPortfolios.png" >}}

- Click on *reinvent.yaml*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickOnreinvent.png" >}}

- Click *Edit*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickEdit.png" >}}

- Replace the contents of your file with this:

 <figure>
  {{< highlight js "hl_lines=26-27" >}}
Schema: factory-2019-04-01
Products:
  - Name: "aws-config-enable-config"
    Owner: "data-governance@example.com"
    Description: "Enables AWS Config"
    Distributor: "cloud-engineering"
    SupportDescription: "Speak to data-governance@example.com about exceptions and speak to cloud-engineering@example.com about implementation issues"
    SupportEmail: "cloud-engineering@example.com"
    SupportUrl: "https://wiki.example.com/cloud-engineering/governance/aws-config-enable-config"
    Tags:
      - Key: "type"
        Value: "governance"
      - Key: "creator"
        Value: "cloud-engineering"
      - Key: "cost-center"
        Value: "cloud-engineering"
    Versions:
      - Name: "v1"
        Description: "v1 of aws-config-enable-config"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "aws-config-enable-config"
            BranchName: "main"
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
        Value: "cloud-engineering"  
  {{< / highlight >}}
 </figure>


- Take note of the highlighted lines 26 and 27.  We have added a portfolio to the product.
- Please be aware that the role arn:aws:iam::${AWS::AccountId}:role/TeamRole probably does not exist in your account and will need updating.

Once you have updated the file fill in the fields for *Author name*, *Email address*, *Commit message* and hit 
*Commit changes*

{{< figure src="/how-tos/creating-and-provisioning-a-product/CommitChanges.png" >}}

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

### Verify the product was added to the portfolio

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SuccessfulFactoryRun.png" >}}

Once you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} to view your
portfolio.

- Click on *reinvent-cloud-engineering-governance*

{{< figure src="/how-tos/creating-and-provisioning-a-product/PortfolioReinventCloudEngineeringGovernance.png" >}}


- Click on the product *aws-config-enable-config*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickAwsConfigS3BucketServerSideEncryptionEnabled.png" >}}

- Click on the version *v1*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickAwsConfigS3BucketServerSideEncryptionEnabledV1.png" >}}
