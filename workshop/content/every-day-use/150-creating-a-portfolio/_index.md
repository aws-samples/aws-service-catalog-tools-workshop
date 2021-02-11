+++
title = "Creating a portfolio"
weight = 150
home_region = "eu-west-1"

+++
---


## What are we going to do?

This tutorial will walk you through "{{% param title %}}" with a spoke account.

We will assume you have installed Service Catalog Puppet correctly.

We are going to perform the following steps:

- create a portfolio file
- define a product
- define a version for our product
- commit our portfolio file
- verify the framework has create an AWS CodePipeline for our product version

During this process you will check your progress by verifying what the framework is doing at each step.


## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Adding the portfolio to the framework

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} 

- Click on *portfolios*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickOnPortfolios.png" >}}

- Click on *reinvent.yaml*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickOnreinvent.png" >}}

- Click *Edit*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickEdit.png" >}}

- Add the following to the end of the file (be careful with your indentation):

 <figure>
  {{< highlight js >}}
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

 
- Verify the contents of your file matches this:

 <figure>
  {{< highlight js >}}
Schema: factory-2019-04-01
Products:
  - Name: "aws-config-enable-config"
    Owner: "data-governance@example.com"
    Description: "Enables AWS Config"
    Distributor: "cloud-engineering"
    SupportDescription: "Speak to data-governance@example.com about exceptions and speak to cloud-engineering@example.com about implementation issues"
    SupportEmail: "cloud-engineering@example.com"
    SupportUrl: 'https://wiki.example.com/cloud-engineering/governance/aws-config-enable-config'
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


Once you have updated the file fill in the fields for *Author name*, *Email address*, *Commit message* and hit 
*Commit changes*

{{< figure src="/how-tos/creating-and-provisioning-a-product/CommitChanges.png" >}}

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


### Verify the portfolio was created

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SuccessfulFactoryRun.png" >}}

Once you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} to view your
portfolio.

You should see the portfolio you just created listed:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SeeYourPortfolio.png" >}}

You have now successfully created a portfolio!

