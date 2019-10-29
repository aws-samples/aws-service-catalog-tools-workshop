+++
title = "Create the portfolio"
weight = 400
home_region = "eu-west-1"
+++
---


### Create the portfolio

_Before we can add a product to a portfolio we need to create the portfolio. Below are the steps needed to create a 
portfolio._

#### Adding the portfolio to the framework

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} again

- Click on *portfolios*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickOnPortfolios.png" >}}

- Click on *reinvent.yaml*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickOnreinvent.png" >}}

- Click *Edit*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickEdit.png" >}}

- Add the following to the end of the file (be careful with your indentation):

{{% code file="30-how-tos/100-creating-and-provisioning-a-product/artefacts/factory/create-the-portfolio--portfolio_only.yaml" language="js" %}}
 
- Verify the contents of your file matches this:

{{% code file="30-how-tos/100-creating-and-provisioning-a-product/artefacts/factory/create-the-portfolio--portfolio_product_and_version.yaml" language="js" %}}

Once you have updated the file fill in the fields for *Author name*, *Email address*, *Commit message* and hit 
*Commit changes*

{{< figure src="/how-tos/creating-and-provisioning-a-product/CommitChanges.png" >}}

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


#### Verify the portfolio was created

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SuccessfulFactoryRun.png" >}}

Once you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} to view your
portfolio.

You should see the portfolio you just created listed:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SeeYourPortfolio.png" >}}

You have now successfully created a portfolio!


