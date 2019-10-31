+++
title = "Sharing the product"
weight = 600
home_region = "eu-west-1"
+++
---


### Sharing the product

We need to tell the framework that we want to share the portfolio *cloud-engineering-governance-self-service*.  To do 
this we will need to update the manifest file.

#### Adding your shares to the manifest
 
- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}} again

- Click on *manifest.yaml*

- Click *Edit*

{{< figure src="/tasks/ClickEdit.png" >}}

- Append the following snippet to the YAML document in the main input field (be careful with your indentation):

 {{% code file="40-reinvent2019/300-task-3/artefacts/orchestrator/manifest-shares-addition.yaml" language="js" %}}
 
- The main input field should look like this:

 {{% code file="40-reinvent2019/300-task-3/artefacts/orchestrator/manifest-all.yaml" language="js" %}}



#### Committing the manifest file

_Now that we have written the manifest file we are ready to commit it._

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/tasks/CommitChanges.png" >}}


#### Verifying the provisioning


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

You have now successfully shared a portfolio!
