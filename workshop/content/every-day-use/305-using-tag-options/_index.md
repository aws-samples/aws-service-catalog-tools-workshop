+++
title = "Using tag options"
weight = 305
home_region = "eu-west-1"
+++
---

## What are tag options?
AWS Service Catalog allows you to associate tag options to portfolios and products (tag options apply to each version / provisioning artefact of a product).

When you associate a tag option you are forcing the user who launches (creates a provisioned product) to apply the specified tag name and value in your tag option.

## What are we going to do?

This tutorial will walk you through "{{% param title %}}".

We will assume you have:
 
 - installed Service Catalog Factory correctly
 - installed Service Catalog Puppet correctly
 - bootstrapped a spoke
 - you have created a product
 - you have created a portfolio

We are going to perform the following steps:

- Adding tag options to your portfolio
- Applying tag options when using Service Catalog Puppet

During this process you will check your progress by verifying what the framework is doing at each step.

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Adding tag options to your portfolio

You can add tag options to the portfolios or products that exist in the /portfolios directory of your 
ServiceCatalogFactory repository:

Applying to a portfolio:
  <figure>
   {{< highlight js >}}
---
Schema: factory-2019-04-01

Portfolios:
  - DisplayName: "shared"
    Description: "Shared portfolio"
    ProviderName: "shared"
    TagOptions:
      - Key: "creating-team"
        Value: "ccoe"
    Products:
      - Name: vpc
        Owner: central-it@customer.com
        Distributor: central-it-team 
   {{< / highlight >}}
  </figure>


Applying to a product defined within a portfolio:
  <figure>
   {{< highlight js >}}
---
Schema: factory-2019-04-01

Portfolios:
  - DisplayName: "shared"
    Description: "Shared portfolio"
    ProviderName: "shared"
    Products:
      - Name: vpc
        Owner: central-it@customer.com
        Distributor: central-it-team
        TagOptions:
          - Key: "product-type"
            Value: "networking"
   {{< / highlight >}}
  </figure>


Applying to a product defined outside of a portfolio:
  <figure>
   {{< highlight js >}}
---
Schema: factory-2019-04-01

Portfolios:
  - DisplayName: "shared"
    Description: "Shared portfolio"
    ProviderName: "shared" 

Products:
  - Name: eks-cluster
    Owner: central-it@customer.com
    Distributor: central-it-team
    TagOptions:
      - Key: "creating-sub-team"
        Value: "networking-team"
    Portfolios:
      - shared
   {{< / highlight >}}
  </figure>

### Applying tag options when using Service Catalog Puppet

When you install or update Service Catalog Puppet you can modify the parameter named ShouldShareTagOptions value to 
enable or disable tag options when Service Catalog Puppet creates portfolio shares.  This value will apply for each 
launch and each spoke-local-portfolio.

You can override the global should share tag options value within the manifest file for launches and 
spoke-local-portfolios:

  <figure>
   {{< highlight js >}}
spoke-local-portfolios:
  ccoe-products:
    share_tag_options: True
    portfolio: ccoe-products
    associations:
      - arn:aws:iam::${AWS::AccountId}:role/EndUsers
    deploy_to:
      tags:
        - tag: "role:spoke"
          regions: "enabled_regions"
   {{< / highlight >}}
  </figure>


  <figure>
   {{< highlight js >}}

launches:
  sleeper:
    share_tag_options: True
    portfolio: "ccoe-products"
    product: "vpc"
    version: "v1"
    deploy_to:
      tags:
        - tag: "role:spoke"
          regions: "enabled_regions"


   {{< / highlight >}}
  </figure>