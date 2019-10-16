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

{{< figure src="https://via.placeholder.com/640x400.png?text=ClickOnPortfolios" title="ClickOnPortfolios" >}}

- Click on *reinvent.yaml*

{{< figure src="https://via.placeholder.com/640x400.png?text=ClickOnreinvent.yaml" title="ClickOnreinvent.yaml" >}}

- Click *Edit*

{{< figure src="https://via.placeholder.com/640x400.png?text=ClickEdit" title="ClickEdit" >}}

- Replace the contents of your file with this:

{{% code file="50-revinvent2019/100-task-1/artefacts/final.yaml" language="yaml" %}}

- Take note of lines 26 and 27.  We have added a portfolio to the product.

Once you have updated the file fill in the fields for *Author name*, *Email address*, *Commit message* and hit 
*Commit changes*

{{< figure src="https://via.placeholder.com/640x400.png?text=CommitChanges.yaml" title="CommitChanges" >}}

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

#### Verify the product was added to the portfolio

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="https://via.placeholder.com/640x400.png?text=SuccessfulRun" title="SuccessfulRun" >}}

{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}

Once you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} to view your
portfolio.

- Click on *reinvent-cloud-engineering-governance*

{{< figure 
    src="https://via.placeholder.com/640x400.png?text=PortfolioReinventCloudEngineeringGovernance" 
    title="PortfolioReinventCloudEngineeringGovernance" 
>}}

- Click on the product *aws-config-s3-bucket-server-side-encryption-enabled*

{{< figure 
    src="https://via.placeholder.com/640x400.png?text=ClickAwsConfigS3BucketServerSideEncryptionEnabled" 
    title="ClickAwsConfigS3BucketServerSideEncryptionEnabled" 
>}}

- Click on the version *v1*

{{< figure src="https://via.placeholder.com/640x400.png?text=v1" title="v1" >}}