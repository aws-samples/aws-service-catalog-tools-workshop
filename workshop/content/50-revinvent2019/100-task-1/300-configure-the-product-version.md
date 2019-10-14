+++
title = "Configure the product version"
weight = 300
home_region = "eu-west-2"
+++
---

### Configuring the product version pipeline

_Now that a product and version have been created we now need to add the source code for the product so we can get it
added to Service Catalog._


#### Adding the source code for your product
When you configured your version, you specified the following: 

{{% code file="50-revinvent2019/100-task-1/artefacts/version_only.yaml" language="yaml" %}}

We now need to create the CodeCommit repository and add the AWS Cloudformation template we are going to use for our
product into that repository.

- Navigate to {{% codecommit_link %}}

- Click *Create repository*

{{< figure src="https://via.placeholder.com/640x400.png?text=CreateRepository" title="CreateRepository" >}}

- Input the name `aws-config-s3-bucket-server-side-encryption-enabled`

{{< figure src="https://via.placeholder.com/640x400.png?text=InputTheName" title="InputTheName" >}}

- Click *Create*

{{< figure src="https://via.placeholder.com/640x400.png?text=ClickCreate" title="ClickCreate" >}}

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="https://via.placeholder.com/640x200.png?text=CreateFile" title="CreateFile" >}}

- Copy the following snippet into the main input field:

 {{% code 
    file="50-revinvent2019/100-task-1/artefacts/product.template.yaml" 
    language="yaml" 
 %}}

- Set the *File name* to `product.template.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

Creating that file should trigger your 
{{% codepipeline_pipeline_link "reinvent-aws-config-s3-bucket-server-side-encryption-enabled-v1-pipeline" %}}.  

Once the pipeline has has completed it should show the *Source* and *Build* stages in green to indicate they have 
completed successfully:

{{< figure src="https://via.placeholder.com/640x400.png?text=SuccessfulRun" title="SuccessfulRun" >}}

{{% notice tip %}}
You should see your commit message on this screen, it will help you know which version of ServiceCatalogFactory repo the 
pipeline is processing.
{{% /notice %}}

{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}

Once you have verified the pipeline has run you can go to {{% service_catalog_products_list_link %}} to view your newly
created version.

You should see the product you previously created listed:

{{< figure src="https://via.placeholder.com/640x400.png?text=SeeYourProduct" title="SeeYourProduct" >}}

Click on the product and verify *v1* is there

{{< figure src="https://via.placeholder.com/640x400.png?text=SeeYourVersion" title="SeeYourVersion" >}}

{{% notice note %}}
If you cannot see your version please raise your hand for some assistance
{{% /notice %}}

You have now successfully created a version for your product!  Next you are going to create a portfolio and add your
product to it.
