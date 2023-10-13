+++
title = "Deleting the product pipeline"
weight = 300
home_region = "eu-west-1"
abc = true
+++
---

### Delete a product version pipeline

#### Step by step guide

When you are ready to delete a product version pipeline you will need to edit its definition in the portfolio yaml.

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} 

- Click on *portfolios*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickOnPortfolios.png" >}}

- Click on the portfolio yaml containing your product

- Click *Edit*

- Add or set the attribute Status for the version you want to delete to terminated:

  <figure>
   {{< highlight js "hl_lines=16" >}}
Schema: factory-2019-04-01
Products:
  - Name: account-vending-machine
    Owner: central-it@customer.com
    Description: The iam roles needed for you to do your jobs
    Distributor: central-it-team
    SupportDescription: Contact us on Chime for help #central-it-team
    SupportEmail: central-it-team@customer.com
    SupportUrl: https://wiki.customer.com/central-it-team/self-service/account-iam
    Tags:
    - Key: product-type
      Value: iam
    Versions:
      - Name: v1
        Description: The iam roles needed for you to do your jobs
        Status: terminated
        Source:
          Provider: CodeCommit
          Configuration:
            RepositoryName: account-vending-machine
            BranchName: v1
    {{< / highlight >}}
  </figure>

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

- Click the *Commit changes* button:

{{< figure src="/how-tos/creating-and-provisioning-a-product/CommitChanges.png" >}}

When the framework runs the product version pipeline will be deleted. 


### Delete all product version pipelines

#### Step by step guide

When you are ready to delete all pipelines for a product you will need to edit its definition in the portfolio yaml.

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} 

- Click on *portfolios*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickOnPortfolios.png" >}}

- Click on the portfolio yaml containing your product

- Click *Edit*

- Add or set the attribute Status for the product you want to delete all pipelines for to terminated:

  <figure>
   {{< highlight js "hl_lines=4" >}}
Schema: factory-2019-04-01
Products:
  - Name: account-vending-machine
    Status: terminated
    Owner: central-it@customer.com
    Description: The iam roles needed for you to do your jobs
    Distributor: central-it-team
    SupportDescription: Contact us on Chime for help #central-it-team
    SupportEmail: central-it-team@customer.com
    SupportUrl: https://wiki.customer.com/central-it-team/self-service/account-iam
    Tags:
    - Key: product-type
      Value: iam
    Versions:
      - Name: v1
        Description: The iam roles needed for you to do your jobs        
        Source:
          Provider: CodeCommit
          Configuration:
            RepositoryName: account-vending-machine
            BranchName: v1
    {{< / highlight >}}
  </figure>

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

- Click the *Commit changes* button:

{{< figure src="/how-tos/creating-and-provisioning-a-product/CommitChanges.png" >}}

When the framework runs all of the pipelines for the product will be deleted.
