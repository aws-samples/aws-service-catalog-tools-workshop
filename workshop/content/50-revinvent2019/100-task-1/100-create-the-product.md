+++
title = "Create the product"
weight = 100
home_region = "eu-west-2"
+++
---

### Create the product

_We need to tell the framework we want to create a product. When we add the product to the framework it will add it to
AWS Service Catalog in every region we specified when installing the framework._  

#### Adding the product to the framework

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}}  
- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="https://via.placeholder.com/640x200.png?text=CreateFile" title="Create file" >}}

- Copy the following snippet into the main input field:

 {{% code file="50-revinvent2019/100-task-1/artefacts/product.yaml" language="yaml" %}}

- Set the *File name* to `portfolios/reinvent.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="https://via.placeholder.com/640x100.png?text=CommitChanges" title="Commit changes" >}}



#### Verify the product was created

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="https://via.placeholder.com/640x400.png?text=SuccessfulRun" title="SuccessfulRun" >}}

{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}

Once you have verified the pipeline has run you can go to {{% service_catalog_products_list_link %}} to view your product

You should see the product you just created listed:

{{< figure src="https://via.placeholder.com/640x400.png?text=SeeYourProduct" title="SeeYourProduct" >}}

{{% notice note %}}
If you cannot see your product please raise your hand for some assistance
{{% /notice %}}

You have now successfully created a product!

