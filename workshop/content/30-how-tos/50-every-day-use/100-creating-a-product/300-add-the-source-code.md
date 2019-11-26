+++
title = "Add the source code"
weight = 300
home_region = "eu-west-1"
+++
---

## What are we going to do?

We are going to perform the following steps:

- Add the source code for the version of the product we have just created


## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"


### Add the source code for your product
When you configured your product version, you specified the following: 

{{% code file="30-how-tos/50-every-day-use/100-creating-a-product/artefacts/factory/create-the-version--version-only.yaml" language="js" %}}

We now need to create the CodeCommit repository and add the AWS CloudFormation template we are going to use for our
product into that repository.

- Navigate to {{% codecommit_link %}}

- Click *Create repository*

{{< figure src="/how-tos/creating-and-provisioning-a-product/CreateRepository.png" >}}


- Input the name `aws-config-enable-config`

{{< figure src="/how-tos/creating-and-provisioning-a-product/InputTheName.png" >}}

- Click *Create*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickCreate.png" >}}

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/how-tos/creating-and-provisioning-a-product/create_file.png" >}}

- Copy the following snippet into the main input field:

 {{% code 
    file="30-how-tos/50-every-day-use/100-creating-a-product/artefacts/product.template.yaml" 
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

Once the pipeline has completed it should show the *Source*, *Package* and *Deploy* stages in green to indicate they have 
completed successfully:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SuccessfulFactoryProductRun.png" >}}

{{% notice tip %}}
You should see your commit message on this screen, it will help you know which version of ServiceCatalogFactory repository the 
pipeline is processing.
{{% /notice %}}

Once you have verified the pipeline has run you can go to {{% service_catalog_products_list_link %}} to view your newly
created version.

You should see the product you created listed:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SeeYourTask1Product.png" >}}

Click on the product and verify *v1* is there

{{< figure src="/how-tos/creating-and-provisioning-a-product/SeeYourTask1ProductVersion1.png" >}}

You have now successfully created a version for your product!  
