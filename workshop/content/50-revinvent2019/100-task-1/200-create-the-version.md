+++
title = "Create the version"
weight = 200
home_region = "eu-west-1"
+++
---


### Create the version

_We now need to tell the framework we want to create a new version of our product.  Once this is done we will have an AWS
CodePipeline that will take the source code for our product from git and add it to AWS Service Catalog in each region we
specified when installing the framework._

#### Adding the version to the framework

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} again
- Click on *portfolios*

{{< figure src="/tasks/ClickOnPortfolios.png" >}}

- Click on *reinvent.yaml*

{{< figure src="/tasks/ClickOnreinvent.png" >}}

- Click *Edit*

{{< figure src="/tasks/ClickEdit.png" >}}

- Add the following to the end of the file (be careful with your indentation):

 {{% code file="50-revinvent2019/100-task-1/artefacts/version_only.yaml" language="yaml" %}}
 
- Verify the contents of your file matches this:

 {{% code file="50-revinvent2019/100-task-1/artefacts/product_and_version.yaml" language="yaml" %}}

Once you have updated the file fill in the fields for *Author name*, *Email address*, *Commit message* and hit *Commit changes*

{{< figure src="/tasks/CommitChanges.png" >}}

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

#### Verify the version was created

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulFactoryRun.png" >}}

{{% notice tip %}}
You should see your commit message on this screen, it will help you know which version of ServiceCatalogFactory repo
the pipeline is processing.
{{% /notice %}}

{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}


Now that your *ServiceCatalogFactory* pipeline has completed you can view the newly created pipeline: 
{{% codepipeline_pipeline_link "reinvent-aws-config-s3-bucket-server-side-encryption-enabled-v1-pipeline" %}}

You can ignore reinvent-aws-config-s3-bucket-server-side-encryption-enabled-v1-pipeline has failed.  
We need to add the source code for it to work.

