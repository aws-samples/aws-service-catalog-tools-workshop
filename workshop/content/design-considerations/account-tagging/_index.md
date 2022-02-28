+++
title = "Account Tagging"
weight = 300

+++
---

## What are we going to do?

This article will explain how tags are used by the Service Catalog Tools and will make some recommendations on which
tags you should be thinking about using.

## How does Service Catalog Tools use account tags?

When writing your manifest you can specify tags for AWS Accounts:

<figure>
  {{< highlight js "hl_lines=9-10">}}
accounts:
  - account_id: "012345678910"
    name: "prod-member-service-9"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
      - "eu-west-2"
    tags:
      - "type:prod"
      - "partition:eu"
  {{< / highlight >}}
 </figure>
 
 The tags assigned to this account are *type:prod* and *partition:eu*.

These tags are later used in the *launches* and *spoke-portfolio-shares* sections of the manifest file to choose which 
AWS Accounts should have products provisioned into them and which AWS Accounts should have portfolios shared with them:

<figure>
  {{< highlight js "hl_lines=8 16" >}}
launches:
  aws-config-rds-storage-encrypted:
    portfolio: "reinvent-cloud-engineering-governance"
    product: "aws-config-rds-storage-encrypted"
    version: "v1"
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"

spoke-local-portfolios:
  cloud-engineering-self-service:
    portfolio: "reinvent-cloud-engineering-self-service"
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
  {{< / highlight >}}
 </figure>          
 
The Service Catalog Tools looks through the *launches* and the *spoke-local-portfolios*.  For each *launch* and 
*spoke-local-portfolio* found the framework will look through the tags specified in the tags section.  For each tag found
the Service Catalog Tools will look through the list of accounts for an account with the same tag.  When the tag is found
the product is provisioned if the tag was found in the launch section otherwise the portfolio specified will be shared if
the tag was found in a *spoke-local-portfolio*.

## How you can make best use of them

Having the right number of tags is essential.  Too few tags will cause you to have less flexibility but having too many
may lead to a larger than needed manifest file or feeling overwhelmed.

To begin with, we recommend using *foundation* and *additional* tags to align to the multi-account strategy best practice:

- outype:foundational
- outype:additional

We then recommend describing which OU the AWS Accounts are in:

- ou:sharedservices
- ou:networking
- ou:securityreadonly

We then recommend the following tags based on the type of the workloads that exist in the AWS account:

- type:prod
- type:test
- type:dev
- type:sandbox
- type:suspended

We then recommend using a set of scope tags to help explain the governance needs of the accounts:

- scope:pci
- scope:pii
- scope:hipaa

We may also want to classify the account by the confidentiality of the data within it

- confidentiality:highly
- confidentiality:medium
- confidentiality:public

It may also be convenient to tag the accounts with the team or business unit:

- team:ccoe 
- team:member-services 
- team:mobile-banking 
- businessunit:security 

The tags you specify within the manifest are not applied to the accounts using AWS Organizations - they only exist
within the manifest file.  You can change them at any time and renaming them will not result in changes.

{{% notice note %}}
If you would like to share your tagging patterns raise a [github issue](https://github.com/aws-samples/aws-service-catalog-tools-workshop/issues) to share
{{% /notice %}}
