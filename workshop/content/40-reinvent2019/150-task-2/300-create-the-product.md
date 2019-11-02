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

We previously provisioned a detective control to ensure AWS RDS Instances have encryption enabled.  Using this framework
we can create compliant products for our users to provision resources.  We are going to create a product that allows our
users to provision an AWS RDS Instance that meets the Data Governance teams guidelines.
 
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

- We will need to insert the following to the products section:

{{% code file="40-reinvent2019/150-task-2/artefacts/factory/new_product_details_second_time.yaml" language="js" %}}

- We will need to insert the following to the portfolios section:

{{% code file="40-reinvent2019/150-task-2/artefacts/factory/new_portfolio_details_second_time.yaml" language="js" %}}

- Once completed it should like look this: 

{{% code file="40-reinvent2019/150-task-2/artefacts/factory/completed_second_time.yaml" language="js" highlight="62-63" %}}

{{% notice note %}}
Have a look at the highlighted lines.  We are using this to turn on stelligent's _cfn-nag_.  This will add an extra layer
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

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were very quick, the pipeline 
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

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

Creating that file should trigger your 
{{% codepipeline_pipeline_link "rds-instance-v1-pipeline" %}}.  

Once the pipeline has completed it should show the *Source* and *Build* stages in green to indicate they have 
completed successfully:

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

- Click on *_{{% param portfolio_name %}}_*

{{< figure src="/tasks/PortfolioReinventCloudEngineeringGovernance.png" >}}

- Click on the product *_{{% param product_name %}}_*

- Click on the version *_{{% param product_version %}}_*

{{< figure src="/tasks/ClickAwsConfigS3BucketServerSideEncryptionEnabledV1.png" >}}


### Share that portfolio with a spoke account

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

Once you have made your changes the {{% service_catalog_puppet_pipeline_link %}} should have run or if you were quick 
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
