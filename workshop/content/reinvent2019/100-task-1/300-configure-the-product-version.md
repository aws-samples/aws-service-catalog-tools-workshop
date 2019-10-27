+++
title = "Configure product version"
weight = 300
home_region = "eu-west-1"
+++
---

### Configuring the product version pipeline

_Now that a product and version have been created we now need to add the source code for the product so we can get it
added to Service Catalog._


#### Add the source code for your product
When you configured your product version, you specified the following: 

{{% code file="reInvent2019/100-task-1/artefacts/factory/create-the-version--version-only.yaml" language="js" %}}

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
    file="reInvent2019/100-task-1/artefacts/product.template.yaml" 
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
