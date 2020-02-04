+++
title = "Create the product"
weight = 300
home_region = "eu-west-1"
codecommit_repo_name = "rds-instance" 
codecommit_repo_branch = "master" 
product_name = "rds-instance"
product_version = "v1"
portfolio_name = "cloud-engineering-self-service"
+++
---

## What are we going to do?

We have provisioned a detective control to look for AWS RDS Instances that have don't have encryption enabled.  We can do better, and create an AWS Service Catalog product that meets the encryption requirement by default using service catalog tools. When users create a new RDS instance using this product, encryption at rest is enabled by default and no further configuration is required. 

We are going to perform the following steps:

- define a product with a version and a portfolio 
- add the source code for our product
- share that portfolio with a spoke account

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Define a product with a version and a portfolio

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} again

- Click on *portfolios*

{{< figure src="/tasks/ClickOnPortfolios.png" >}}

- Click on *reinvent.yaml*

{{< figure src="/tasks/ClickOnreinvent.png" >}}

- Click *Edit*

{{< figure src="/tasks/ClickEdit.png" >}}

- Add the following to the products section:

{{% code file="40-reinvent2019/150-task-2/artefacts/factory/new_product_details_second_time.yaml" language="js" %}}

- Add the following to the portfolios section:

{{% code file="40-reinvent2019/150-task-2/artefacts/factory/new_portfolio_details_second_time.yaml" language="js" %}}

- Once completed it should like look this: 



 <figure>
  {{< highlight js "hl_lines=62-63"  >}}

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

  - Name: "aws-config-rds-storage-encrypted"
    Owner: "data-governance@example.com"
    Description: "Enables AWS Config rule - aws-config-rds-storage-encrypted"
    Distributor: "cloud-engineering"
    SupportDescription: "Speak to data-governance@example.com about exceptions and speak to cloud-engineering@example.com about implementation issues"
    SupportEmail: "cloud-engineering@example.com"
    SupportUrl: "https://wiki.example.com/cloud-engineering/data-governance/aws-config-rds-storage-encrypted"
    Tags:
      - Key: "type"
        Value: "governance"
      - Key: "creator"
        Value: "cloud-engineering"
      - Key: "cost-center"
        Value: "governance"
    Versions:
      - Name: "v1"
        Description: "v1 of aws-config-rds-storage-encrypted"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "aws-config-rds-storage-encrypted"
            BranchName: "master"
    Portfolios:
      - "cloud-engineering-governance"

  - Name: "rds-instance"
    Owner: "data-governance@example.com"
    Description: "A compliant RDS Instance you can use that meets data governance standards"
    Distributor: "cloud-engineering"
    SupportDescription: "Speak to data-governance@example.com about exceptions and speak to cloud-engineering@example.com about implementation issues"
    SupportEmail: "cloud-engineering@example.com"
    SupportUrl: "https://wiki.example.com/cloud-engineering/data-governance/rds-instance"
    Options:
      ShouldCFNNag: True
    Tags:
      - Key: "type"
        Value: "governance"
      - Key: "creator"
        Value: "cloud-engineering"
    Versions:
      - Name: "v1"
        Description: "v1 of rds-instance"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "rds-instance"
            BranchName: "master"
    Portfolios:
      - "cloud-engineering-self-service"

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

  - DisplayName: "cloud-engineering-self-service"
    Description: "Portfolio containing products that you can use to ensure you meet the governance guidelines"
    ProviderName: "cloud-engineering"
    Associations:
      - "arn:aws:iam::${AWS::AccountId}:role/TeamRole"
    Tags:
      - Key: "type"
        Value: "governance"
      - Key: "creator"
        Value: "cloud-engineering"

 {{< / highlight >}}
 </figure>







{{% notice note %}}
Have a look at the highlighted lines.  We are using this to turn on _cfn-nag_, an open source tool by Stelligent that looks for insecure configuration of resources.  This will add an extra layer
of governance ensuring the AWS CloudFormation templates we are using meets the quality bar set by _cfn-nag_.
{{% /notice %}}

- Set your *Author name*

- Set your *Email address*

- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

- Click the *Commit changes* button:

{{< figure src="/tasks/CommitChanges.png" >}}


#### What did we just do?

The YAML we pasted in the previous step told the framework to perform several actions:

- create a product named _{{% param product_name %}}_
- add a _{{% param product_version %}}_ of our product
- create a portfolio named _{{% param portfolio_name %}}_
- add the product: _{{% param product_name %}}_ to the portfolio: _{{% param portfolio_name %}}_

#### Verify the change worked

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run. If you were very quick, the pipeline 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulFactoryRun.png" >}}

{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}


### Add the source code for our product

When you configured your product version, you specified the following version: 

{{% code file="40-reinvent2019/150-task-2/artefacts/factory/create-the-version--version-only_second_time.yaml" language="js" %}}

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

{{% code file="40-reinvent2019/150-task-2/artefacts/product_second_time.template.yaml" language="js" %}}

- Set the *File name* to `product.template.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*
- Click *Commit changes*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

Creating that file should trigger your 
{{% codepipeline_pipeline_link "rds-instance-v1-pipeline" %}}.  

Once the pipeline has completed it should show the *Source* stage in green to indicate it has completed successfully but 
it should show the CFNNag action within the Tests stage as failing:

{{< figure src="/tasks/FailedCFNNag.png" >}}

Clicking the _Details_ link within the CFNNag box will bring you to the AWS CodeBuild project.  When you scroll near to 
the bottom of that page you should see an error:

```bash
·[0;31;49m| FAIL F26·[0m 
·[0;31;49m|·[0m 
·[0;31;49m| Resources: ["RdsDbCluster"]·[0m 
·[0;31;49m| Line Numbers: [84]·[0m 
·[0;31;49m|·[0m 
·[0;31;49m| RDS DBCluster should have StorageEncrypted enabled·[0m 
```  

CFNNag has determined you are not applying encryption to your DBCluster.  This is a violation of the data governance 
guidelines and so we need to fix it.

- Go to {{% codecommit_link %}}

- Click on the _{{% param codecommit_repo_name %}}_ repository

- Click on _product.template.yaml_

- Click on edit

- Replace the contents with this:

{{% code file="40-reinvent2019/150-task-2/artefacts/product_third_time.template.yaml" language="js" highlight="91 116" %}}

Please observe the highlighted lines showing where we have made a change.  We have added:

```js
      StorageEncrypted: True
``` 
- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*
- Click *Commit changes*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


Creating that file should trigger your 
{{% codepipeline_pipeline_link "rds-instance-v1-pipeline" %}}.  

Once the pipeline has completed it should show the *Source* and *Tests* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/PassedCFNNag.png" >}}


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

#### Verify that the product was added to the portfolio

Now that you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} to view your
portfolio.

- Click on *_{{% param portfolio_name %}}_*

{{< figure src="/tasks/PortfolioReinventCloudEngineeringGovernance.png" >}}

- Click on the product *_{{% param product_name %}}_*

- Click on the version *_{{% param product_version %}}_*

{{< figure src="/tasks/ClickAwsConfigS3BucketServerSideEncryptionEnabledV1.png" >}}


### Share portfolio with a spoke account

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}} again

- Click on *manifest.yaml*

- Click *Edit*

{{< figure src="/tasks/ClickEdit.png" >}}

- Append the following snippet to the YAML document in the main input field (be careful with your indentation):

{{% code file="40-reinvent2019/150-task-2/artefacts/orchestrator/manifest-shares-addition.yaml" language="js" %}}
 
- The main input field should look like this:

{{% code file="40-reinvent2019/150-task-2/artefacts/orchestrator/manifest-all-second_time.yaml" language="js" %}}


#### Committing the manifest file

- Set your *Author name*

- Set your *Email address*

- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

- Click the *Commit changes* button:

{{< figure src="/tasks/CommitChanges.png" >}}


#### Verifying the sharing

Once you have made your changes the {{% service_catalog_puppet_pipeline_link %}} should have run. If you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulPuppetRun.png" >}}

{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}

Once you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} to view your 
shared product.  

When you share a portfolio the framework will decide if it should share the portfolio.  If the target account is the same
as the factory account it will not share the portfolio as it is not needed. 

{{% notice note %}}
If you cannot see your product please raise your hand for some assistance
{{% /notice %}}
