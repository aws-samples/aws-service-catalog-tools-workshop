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


{{< figure src="/how-tos/creating-and-provisioning-a-product/create_file.png" >}}

- Copy the following snippet into the main input field:

 {{% code file="30-how-tos/100-creating-and-provisioning-a-product/artefacts/factory/create-the-product--product-only.yaml" language="js" %}}
 
- Set the *File name* to `portfolios/reinvent.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/how-tos/creating-and-provisioning-a-product/CommitChanges.png" >}}


#### Verify that the change worked

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were very quick, the pipeline 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SuccessfulFactoryRun.png" >}}

