+++
title = "Add the product to the portfolio"
weight = 500
home_region = "eu-west-1"
+++
---


### Add the product to the portfolio

_Now that you have a product and portfolio you can add the product to the portfolio._

#### Add the product to the portfolio

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} again

- Click on *portfolios*

{{< figure src="/tasks/ClickOnPortfolios.png" >}}

- Click on *reinvent.yaml*

{{< figure src="/tasks/ClickOnreinvent.png" >}}

- Click *Edit*

{{< figure src="/tasks/ClickEdit.png" >}}

- Replace the contents of your file with this:

{{% code file="50-revinvent2019/200-task-2/artefacts/final.yaml" language="js" %}}

- Take note of lines 26 and 27.  We have added a portfolio to the product.

Once you have updated the file fill in the fields for *Author name*, *Email address*, *Commit message* and hit 
*Commit changes*

{{< figure src="/tasks/CommitChanges.png" >}}

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

#### Verify the product was added to the portfolio

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulFactoryRun.png" >}}


{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}

Once you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} to view your
portfolio.

- Click on *reinvent-cloud-engineering-governance*

{{< figure src="/tasks/PortfolioReinventCloudEngineeringGovernance.png" >}}


- Click on the product *aws-config-s3-bucket-server-side-encryption-enabled*

{{< figure src="/tasks/ClickAwsConfigS3BucketServerSideEncryptionEnabled.png" >}}

- Click on the version *v1*

{{< figure src="/tasks/ClickAwsConfigS3BucketServerSideEncryptionEnabledV1.png" >}}
