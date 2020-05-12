+++
title = "Disabling the product versions"
weight = 100
home_region = "eu-west-1"
abc = true
+++
---

## What are we going to do?

We are going to perform the following steps:

- disable a product version

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Disable the product version

When working with other teams it is recommended that you disable a product version before you delete it.  This gives
teams time to react before deletion of the product.  If they are dependent on the product version still they can 
reach out to you to inform you.

To disable a version you need to set its *Active* attribute to *False*.  You do this by editing its definition in the 
portfolio yaml.

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} 

- Click on *portfolios*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickOnPortfolios.png" >}}

- Click on the portfolio yaml containing your product

- Click *Edit*

- Add or set the attribute Active for the version you want to disable to False:

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
        Active: False
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

When the framework runs the product will be disabled. This change will only affect the version of the product in your
factory account.  If you are using the imported product in your spoke accounts it will have affect there otherwise
you will need to run service-catalog-puppet to cascade the change. 

You can verify this by navigating to Service Catalog and checking your disabled product.  It should look like:

{{< figure src="/how-tos/deleting-a-product/product-is-inactive.png" >}}
