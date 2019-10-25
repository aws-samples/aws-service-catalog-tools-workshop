+++
title = "Sharing the product"
weight = 600
home_region = "eu-west-1"
+++
---


### Sharing the product


_We will add our account to the frameworks manifest file so it knows about our account and we will tell the framework to
share our newly created product into our account._


#### Adding the product to the manifest

_We will start out by adding your account to the manifest file._

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}} again


- Click on *manifest.yaml*

- Click *Edit*

{{< figure src="/tasks/ClickEdit.png" >}}

- Append the following snippet to the YAML document in the main input field (be careful with your indentation):

 {{% code file="reInvent2019/300-task-3/artefacts/manifest-launches-snippet.yaml" language="yaml" %}}
 
- The main input field should look like this:

 {{% code file="reInvent2019/300-task-3/artefacts/manifest-all.yaml" language="yaml" %}}


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

Once you have verified the pipeline has run you can go to {{% service_catalog_provisioned_products_link %}} to view your 
provisioned product.  Please note when you arrive at the provisioned product page you will need to select account from 
the filter by drop down in the top right:

{{< figure src="/tasks/FilterByAccount.png" >}}

{{% notice note %}}
If you cannot see your product please raise your hand for some assistance
{{% /notice %}}

You have now successfully provisioned a product!
