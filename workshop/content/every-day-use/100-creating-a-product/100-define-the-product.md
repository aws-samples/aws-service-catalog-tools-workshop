+++
title = "Define the product"
weight = 100
home_region = "eu-west-1"
abc = true
+++
---

## What are we going to do?

We are going to perform the following steps:

- create a portfolio file
- define a product
- define a version for our product
- commit our portfolio file
- verify the framework has create an AWS CodePipeline for our product version

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Create the portfolio file

We need to tell the framework that a product exists.  We do that by creating a portfolio file and by describing the 
products details there.  

Here is how we do this:

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}}  
- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/how-tos/creating-and-provisioning-a-product/create_file.png" >}}

- Copy the following snippet into the main input field:

 {{% code file="every-day-use/100-creating-a-product/artefacts/factory/create-the-product--product-only.yaml" language="js" %}}
 
- Set the *File name* to `portfolios/reinvent.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/how-tos/creating-and-provisioning-a-product/CommitChanges.png" >}}

We have just told the framework there is a product named aws-config-enable-config.  This product has no versions and so 
it will not appear in AWS Service Catalog yet.

### Create the version

We now need to tell the framework we want to create a new version of our product.  

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} again

- Click on *portfolios*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickOnPortfolios.png" >}}

- Click on *reinvent.yaml*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickOnreinvent.png" >}}

- Click *Edit*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickEdit.png" >}}

- Add the following to the end of the file (be careful with your indentation):

 {{% code file="every-day-use/100-creating-a-product/artefacts/factory/create-the-version--version-only.yaml" language="js" %}}
 
- Verify the contents of your file matches this:

 {{% code file="every-day-use/100-creating-a-product/artefacts/factory/create-the-version--product_and_version.yaml" language="js" %}}

Once you have updated the file fill in the fields for *Author name*, *Email address*, *Commit message* and hit *Commit changes*

{{< figure src="/how-tos/creating-and-provisioning-a-product/CommitChanges.png" >}}

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

### Verify the version was created

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SuccessfulFactoryRun.png" >}}

{{% notice tip %}}
You should see your commit message on this screen, it will help you know which version of ServiceCatalogFactory repo
the pipeline is processing.
{{% /notice %}}

Now that your *ServiceCatalogFactory* pipeline has completed you can view the newly created pipeline: 
{{% codepipeline_pipeline_link "aws-config-enable-config-v1-pipeline" %}}

You can safely ignore aws-config-enable-config-v1-pipeline has failed.  For the pipeline to succeed, we need to add the source code for it to work which we will do in the next step.
