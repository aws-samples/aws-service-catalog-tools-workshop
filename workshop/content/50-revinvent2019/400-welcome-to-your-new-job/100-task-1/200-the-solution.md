+++
title = "The solution"
weight = 200
home_region = "eu-west-2"
+++
---


The solution is ...


## The plan
We are going to create an AWS Service Catalog product and provision it into our account.  This product will enable an 
AWS Config managed rule that will check if server side encryption is enabled on the AWS S3 buckets in our account.

To do this we will tell the framework a new product exists and then we will add the source code for the product.


{{% notice note %}}
If you need help at any time please raise your hands in the air like you just don't care.
{{% /notice %}}

## Sprint 1

### Create the product

We need to tell the framework we want to create a product:  

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}}  
- Scroll down to the bottom of the page and hit the `Create file` button

{{< figure src="https://via.placeholder.com/640x200.png?text=CreateFile" title="Create file" >}}

- Copy the following snippet into the main input field:

 {{% code file="50-revinvent2019/400-welcome-to-your-new-job/100-task-1/artefacts/product.yaml" language="js" %}}

- Set the *File name* to `portfolios/reinvent.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="https://via.placeholder.com/640x100.png?text=CommitChanges" title="Commit changes" >}}



### Verify the product was created

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

### Create the version

We now need to tell the framework we want to create a new version of our product:  

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} again
- Click on *portfolios*

{{< figure src="https://via.placeholder.com/640x400.png?text=ClickOnPortfolios" title="ClickOnPortfolios" >}}

- Click on *reinvent.yaml*

{{< figure src="https://via.placeholder.com/640x400.png?text=ClickOnreinvent.yaml" title="ClickOnreinvent.yaml" >}}

- Click *Edit*

{{< figure src="https://via.placeholder.com/640x400.png?text=ClickEdit" title="ClickEdit" >}}

- Add the following to the end of the file (be careful with your indentation):

 {{% code file="50-revinvent2019/400-welcome-to-your-new-job/100-task-1/artefacts/version_only.yaml" language="js" %}}
 
- Verify the contents of your file matches this:

 {{% code file="50-revinvent2019/400-welcome-to-your-new-job/100-task-1/artefacts/product_and_version.yaml" language="js" %}}

Once you have updated the file fill in the fields for *Author name*, *Email address*, *Commit message* and hit *Commit changes*

{{< figure src="https://via.placeholder.com/640x400.png?text=CommitChanges.yaml" title="CommitChanges" >}}

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

### Verify the version was created

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run or if you were quick 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="https://via.placeholder.com/640x400.png?text=SuccessfulRun" title="SuccessfulRun" >}}

{{% notice tip %}}
You should see your commit message on this screen, it will help you know which version of ServiceCatalogFactory repo
the pipeline is processing.
{{% /notice %}}

{{% notice note %}}
If this is failing please raise your hand for some assistance
{{% /notice %}}


Now that your *ServiceCatalogFactory* pipeline has completed you can view the newly created pipeline: 
{{% codepipeline_pipeline_link "reinvent-aws-config-s3-bucket-server-side-encryption-enabled-v1-pipeline" %}}

You can ignore whether this has run successfully or not for now.  We need to add the source code for it to work properly.


### Adding the source code for your product

When you configured your version you specified the following: 

{{% code file="50-revinvent2019/400-welcome-to-your-new-job/100-task-1/artefacts/version_only.yaml" language="js" %}}

We now need to create the CodeCommit repository and add the AWS Cloudformation template we are going to use for our
product.

- Navigate to {{% codecommit_link %}}

- Click *Create repository*

{{< figure src="https://via.placeholder.com/640x400.png?text=CreateRepository" title="CreateRepository" >}}

- Input the name `aws-config-s3-bucket-server-side-encryption-enabled`

{{< figure src="https://via.placeholder.com/640x400.png?text=InputTheName" title="InputTheName" >}}

- Click *Create*

{{< figure src="https://via.placeholder.com/640x400.png?text=ClickCreate" title="ClickCreate" >}}

- Scroll down to the bottom of the page and hit the `Create file` button

{{< figure src="https://via.placeholder.com/640x200.png?text=CreateFile" title="CreateFile" >}}

- Copy the following snippet into the main input field:

 {{% code file="50-revinvent2019/400-welcome-to-your-new-job/100-task-1/artefacts/product.template.yaml" language="js" %}}

- Set the *File name* to `product.template.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}








 

Once you have verified the pipeline has run you can go to {{% service_catalog_products_list_link %}} to view your newly
created version.

You should see the product you just created listed:

{{< figure src="https://via.placeholder.com/640x400.png?text=SeeYourProduct" title="SeeYourProduct" >}}

Click on the product and verify v1 is there

{{< figure src="https://via.placeholder.com/640x400.png?text=SeeYourVersion" title="SeeYourVersion" >}}

{{% notice note %}}
If you cannot see your version please raise your hand for some assistance
{{% /notice %}}

You have now successfully created a version for your product!
 
### Create the portfolio

Before we can add a product to a portfolio we need to create the portfolio first. Below are the steps needed to create a 
portfolio:  

- Navigate to the AWS CodeCommit repo  
- Hit add file
- Name it `portfolios/reinvent.yaml`
- Copy the following snippet into it

 {{% code file="50-revinvent2019/400-welcome-to-your-new-job/100-task-1/artefacts/portfolio.yaml" language="js" %}}

The role `arn:aws:iam::${AWS::AccountId}:role/TeamRole` is the one you are using in this workshop.  Adding this to the 
associations allows you to use the portfolio. 

The tags that have been specified for the portfolio are also applied to the product.


### Add the product to the portfolio
