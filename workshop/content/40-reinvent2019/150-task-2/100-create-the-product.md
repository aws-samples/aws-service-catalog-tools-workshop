+++
title = "Create the product"
weight = 100
home_region = "eu-west-1"
+++
---

### Create the product

_We need to tell the framework that we want to create a product. When we add the product to the framework it will add it to
AWS Service Catalog in every region that we specified when installing the framework._  

#### Adding the product to the framework

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}}  
- Scroll down to the bottom of the page and hit the *Create file* button


{{< figure src="/tasks/create_file.png" >}}

- Copy the following snippet into the main input field:

 {{% code file="40-reinvent2019/100-task-1/artefacts/factory/create-the-product--product-only.yaml" language="js" %}}
 
- Set the *File name* to `portfolios/reinvent.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/tasks/CommitChanges.png" >}}


#### Verify that the change worked

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were very quick, the pipeline 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulFactoryRun.png" >}}

{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}



### Create the version

_We have created the product. We now need to tell the framework we want to create a new version of our product.  Once this is done we will have an AWS
CodePipeline that will take the source code for our product from a git repository and add it to AWS Service Catalog in each region that we
specified when installing the framework._

#### Add the product version to the framework

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} again
- Click on *portfolios*

{{< figure src="/tasks/ClickOnPortfolios.png" >}}

- Click on *reinvent.yaml*

{{< figure src="/tasks/ClickOnreinvent.png" >}}

- Click *Edit*

{{< figure src="/tasks/ClickEdit.png" >}}

- Add the following to the end of the file (be careful with your indentation):

 {{% code file="40-reinvent2019/100-task-1/artefacts/factory/create-the-version--version-only.yaml" language="js" %}}
 
- Verify the contents of your file matches this:

 {{% code file="40-reinvent2019/100-task-1/artefacts/factory/create-the-version--product_and_version.yaml" language="js" %}}

Once you have updated the file fill in the fields for *Author name*, *Email address*, *Commit message* and hit *Commit changes*

{{< figure src="/tasks/CommitChanges.png" >}}

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

#### Verify the version was created

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulFactoryRun.png" >}}

{{% notice tip %}}
You should see your commit message on this screen, it will help you know which version of ServiceCatalogFactory repo
the pipeline is processing.
{{% /notice %}}

{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}


Now that your *ServiceCatalogFactory* pipeline has completed you can view the newly created pipeline: 
{{% codepipeline_pipeline_link "aws-config-enable-config-v1-pipeline" %}}

You can safely ignore aws-config-enable-config-v1-pipeline has failed.  For the pipeline to succeed, we need to add the source code for it to work which we will do in the next step.




### Configuring the product version pipeline

_Now that a product and version have been created we now need to add the source code for the product so we can get it
added to Service Catalog._


#### Add the source code for your product
When you configured your product version, you specified the following: 

{{% code file="40-reinvent2019/100-task-1/artefacts/factory/create-the-version--version-only.yaml" language="js" %}}

We now need to create the CodeCommit repository and add the AWS CloudFormation template we are going to use for our
product into that repository.

- Navigate to {{% codecommit_link %}}

- Click *Create repository*

{{< figure src="/tasks/CreateRepository.png" >}}


- Input the name `aws-config-enable-config`

{{< figure src="/tasks/InputTheName.png" >}}

- Click *Create*

{{< figure src="/tasks/ClickCreate.png" >}}

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/tasks/create_file.png" >}}

- Copy the following snippet into the main input field:

 {{% code 
    file="40-reinvent2019/100-task-1/artefacts/product.template.yaml" 
    language="js" 
 %}}

- Set the *File name* to `product.template.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

Creating that file should trigger your 
{{% codepipeline_pipeline_link "aws-config-enable-config-v1-pipeline" %}}.  

Once the pipeline has has completed it should show the *Source* and *Build* stages in green to indicate they have 
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

Click on the product and verify *v1* is there

{{< figure src="/tasks/SeeYourTask1ProductVersion1.png" >}}

{{% notice note %}}
If you cannot see your version please raise your hand for some assistance
{{% /notice %}}

You have now successfully created a version for your product!  Next you are going to create a portfolio and add your
product to it.



### Create the portfolio

_Before we can add a product to a portfolio we need to create the portfolio. Below are the steps needed to create a 
portfolio._

#### Adding the portfolio to the framework

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} again

- Click on *portfolios*

{{< figure src="/tasks/ClickOnPortfolios.png" >}}

- Click on *reinvent.yaml*

{{< figure src="/tasks/ClickOnreinvent.png" >}}

- Click *Edit*

{{< figure src="/tasks/ClickEdit.png" >}}

- Add the following to the end of the file (be careful with your indentation):

% code file="40-reinvent2019/100-task-1/artefacts/factory/create-the-portfolio--portfolio_only.yaml" language="js" %}}
 
- Verify the contents of your file matches this:

{{% code file="40-reinvent2019/100-task-1/artefacts/factory/create-the-portfolio--portfolio_product_and_version.yaml" language="js" %}}

Once you have updated the file fill in the fields for *Author name*, *Email address*, *Commit message* and hit 
*Commit changes*

{{< figure src="/tasks/CommitChanges.png" >}}

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


#### Verify the portfolio was created

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulFactoryRun.png" >}}

{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}

Once you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} to view your
portfolio.

You should see the portfolio you just created listed:

{{< figure src="/tasks/SeeYourPortfolio.png" >}}

{{% notice note %}}
If you cannot see your portfolio please raise your hand for some assistance
{{% /notice %}}

You have now successfully created a portfolio!



### Add the product to the portfolio

_Now that you have a product and portfolio you can add the product to the portfolio._

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} again

- Click on *portfolios*

{{< figure src="/tasks/ClickOnPortfolios.png" >}}

- Click on *reinvent.yaml*

{{< figure src="/tasks/ClickOnreinvent.png" >}}

- Click *Edit*

{{< figure src="/tasks/ClickEdit.png" >}}

- Replace the contents of your file with this:

{{% code file="40-reinvent2019/100-task-1/artefacts/factory/completed.yaml" language="js" %}}

- Take note of lines 26 and 27.  We have added a portfolio to the product.

Once you have updated the file fill in the fields for *Author name*, *Email address*, *Commit message* and hit 
*Commit changes*

{{< figure src="/tasks/CommitChanges.png" >}}

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

#### Verify the product was added to the portfolio

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulFactoryRun.png" >}}


{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}

Once you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} to view your
portfolio.

- Click on *reinvent-cloud-engineering-governance*

{{< figure src="/tasks/PortfolioReinventCloudEngineeringGovernance.png" >}}


- Click on the product *aws-config-enable-config*

{{< figure src="/tasks/ClickAwsConfigS3BucketServerSideEncryptionEnabled.png" >}}

- Click on the version *v1*

{{< figure src="/tasks/ClickAwsConfigS3BucketServerSideEncryptionEnabledV1.png" >}}

