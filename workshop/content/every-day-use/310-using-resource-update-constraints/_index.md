+++
title = "Using resource update constraints"
weight = 310
home_region = "eu-west-1"
+++
---

## What are we going to do?

This tutorial will walk you through "{{% param title %}}" to a spoke local portfolio

We will assume you have:
 
 - installed Service Catalog Puppet correctly
 - created a product
 - created a portfolio
 - added a product to a portfolio

We are going to perform the following steps:

 - specify a resource update constraint to control tag updates 


## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Things to note, before we start

- This feature was added to version 0.178.0.  You will need to be using this version (or later)


### Specify a resource update constraint to control tag updates

_Now we are ready to add a stack to the manifest file._

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}

- Click the *ServiceCatalogPuppet* repository

- Click the link to the *manifest.yaml* file, and then click the *Edit* button

- Find the spoke-local-portfolio you want to add the constraint to:

 <figure>
  {{< highlight js >}}
spoke-local-portfolios:
  networking-options-for-spokes:
    portfolio: networking
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
{{< / highlight >}}
 </figure>

Add the constraint: 


 <figure>
  {{< highlight js >}}
spoke-local-portfolios:
  networking-options-for-spokes:
    portfolio: networking
    constraints:
      resource_update:
        - products: "vpc"
          tag_update_on_provisioned_product: NOT_ALLOWED
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
{{< / highlight >}}
 </figure>

When adding the constraint you can specify ALLOWED or NOT_ALLOWED as the value for tag_update_on_provisioned_product.

When specifying products you can use a wildcard to specify more than one product:

 <figure>
  {{< highlight js >}}
spoke-local-portfolios:
  networking-options-for-spokes:
    portfolio: networking
    constraints:
      resource_update:
        - products: "vpc-with-*-subnet*"
          tag_update_on_provisioned_product: NOT_ALLOWED
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
{{< / highlight >}}
 </figure>

Or you can specify a list:

 <figure>
  {{< highlight js >}}
spoke-local-portfolios:
  networking-options-for-spokes:
    portfolio: networking
    constraints:
      resource_update:
        - products: 
            - "vpc-with-1-subnet"
            - "vpc-with-2-subnets"
            - "vpc-with-3-subnets"
          tag_update_on_provisioned_product: NOT_ALLOWED
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
{{< / highlight >}}
 </figure>

