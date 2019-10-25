+++
title = "Create the product"
weight = 100
home_region = "eu-west-1"
+++
---

### Create the product

_We need to tell the framework we want to create a product. When we add the product to the framework it will add it to
AWS Service Catalog in every region we specified when installing the framework._  

#### Adding the product to the framework

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} again
- Click on *portfolios*

{{< figure src="/tasks/ClickOnPortfolios.png" >}}

- Click on *reinvent.yaml*

{{< figure src="/tasks/ClickOnreinvent.png" >}}

- Click *Edit*

{{< figure src="/tasks/ClickEdit.png" >}}

- Add the following to the products section (be careful with your indentation):

 {{% code file="reInvent2019/200-task-2/artefacts/factory/create-the-product--product-only.yaml" language="js" %}}
 
- The whole input should look like this:

{{% code file="reInvent2019/200-task-2/artefacts/factory/create-the-product--product.yaml" language="js" %}}
 
- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/tasks/CommitChanges.png" >}}


#### Verify the change worked

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulFactoryRun.png" >}}

{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}
