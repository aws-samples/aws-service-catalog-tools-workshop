+++
title = "Applying Tag Policies"
weight = 850
home_region = "eu-west-1"
+++
---

## What are we going to do?

With tag-policies, you tell the framework to apply a tag policy to a specific account, every account with a specified
tag or to an organizational unit.


This tutorial will walk you through how to use the "{{% param title %}}" feature.

We will assume you have:
 
 - installed Service Catalog Puppet correctly
 - bootstrapped a spoke
 - created a manifest file
 - added an account to the manifest file
 
We are going to perform the following steps to "{{% param title %}}":

- Setting up the IAM role
- Applying a tag policy to a specific account
- Applying a tag policy to every account with a specified tag
- Applying a tag policy to an organizational unit

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"


### Setting up the IAM role

When using tag-policies you will need an IAM role assumable from the account where you have installed this framework.

#### Using AWS CloudFormation to create the IAM Role

Within your AWS Organizations management account you should create an AWS CloudFormation stack with the following name:

`puppet-organizations-service-control-policies-stack`

Using the template of the URL:

`https://service-catalog-tools.s3.eu-west-2.amazonaws.com/puppet/latest/servicecatalog-puppet-scp-master.template.yaml`

This stack will have an output named *PuppetOrgRoleForExpandsArn*.  Take a note of this Arn as you will need it in the
next step.

#### Setting the Org IAM role ARN

Once you have created the IAM Role, you need to tell the framework which role you want to use.  You do this by creating
an AWS Systems Manager Parameter Store parameter named `/servicecatalog-puppet/org-scp-role-arn` in the *region* of the 
*account* where you will install puppet and use as your hub account.  You can do this via the console or via the cli.

<figure>
  {{< highlight shell >}}
aws ssm put-parameter --name /servicecatalog-puppet/org-scp-role-arn --type String --value <VALUE-FROM-STEP-ABOVE>  
  {{< / highlight >}}
</figure>


### Applying a tag policy to a specific account

To apply a tag policy to a specific account add the following snippet to your manifest file:

 <figure>
  {{< highlight yaml >}}
tag-policies:
  force-cost-center:
    description: "force cost center"
    tags:
      - Key: Category
        Value: Foundational
    content:
      default: {
        "tags": {
          "costcenter": {
            "tag_key": {
              "@@assign": "CostCenter"
            },
            "tag_value": {
              "@@assign": [
                  "100",
                  "200"
              ]
            },
            "enforced_for": {
              "@@assign": [
                  "secretsmanager:*"
              ]
            }
          }
        }
      }
    apply_to:
      accounts:
        - account_id: "338024302548"
{{< / highlight >}}
 </figure>

You will need to update the account_id from 000000000000 to the account_id you want to apply the tag policy
to.

Please note, you do not need to specify a region in the apply_to section.

### Applying a tag policy to every account with a specified tag

To apply a tag policy to every account with specified tag add the following snippet to your manifest file:

 <figure>
  {{< highlight yaml >}}
tag-policies:
  force-cost-center:
    description: "force cost center"
    tags:
      - Key: Category
        Value: Foundational
    content:
      default: {
        "tags": {
          "costcenter": {
            "tag_key": {
              "@@assign": "CostCenter"
            },
            "tag_value": {
              "@@assign": [
                  "100",
                  "200"
              ]
            },
            "enforced_for": {
              "@@assign": [
                  "secretsmanager:*"
              ]
            }
          }
        }
      }
    apply_to:
      tags:
        - tag: type:prod
  {{< / highlight >}}
 </figure>

You will need to update the tag from type:prod to the tag you want to apply the tag policy to.

Please note, you do not need to specify a region in the apply_to section.

### Applying a tag policy to an organizational unit

To apply a tag policy to a specific organizational unit add the following snippet to your manifest file:

 <figure>
  {{< highlight yaml >}}
tag-policies:
  force-cost-center:
    description: "force cost center"
    tags:
      - Key: Category
        Value: Foundational
    content:
      default: {
        "tags": {
          "costcenter": {
            "tag_key": {
              "@@assign": "CostCenter"
            },
            "tag_value": {
              "@@assign": [
                  "100",
                  "200"
              ]
            },
            "enforced_for": {
              "@@assign": [
                  "secretsmanager:*"
              ]
            }
          }
        }
      }
    apply_to:
      ous:
        - ou: /workloads
  {{< / highlight >}}
 </figure>

You will need to update the ou from /workloads to the path you want to apply the tag policy
to.

Alternatively you can use an ou id instead of a path:

 <figure>
  {{< highlight yaml >}}
tag-policies:
  force-cost-center:
    description: "force cost center"
    tags:
      - Key: Category
        Value: Foundational
    content:
      default: {
        "tags": {
          "costcenter": {
            "tag_key": {
              "@@assign": "CostCenter"
            },
            "tag_value": {
              "@@assign": [
                  "100",
                  "200"
              ]
            },
            "enforced_for": {
              "@@assign": [
                  "secretsmanager:*"
              ]
            }
          }
        }
      }
    apply_to:
      ous:
        - ou: ou-japk-38pz9nbt
  {{< / highlight >}}
 </figure>

### Storing your policies in Amazon S3

You can choose to store you tag policies in Amazon S3 using the following syntax:

 <figure>
  {{< highlight yaml >}}
tag-policies:
  force-cost-center:
    description: "force cost center"
    tags:
      - Key: Category
        Value: Foundational
    content:
      s3: 
        bucket: my-policy-store
        key: force-cost-center.json
    apply_to:
      ous:
        - ou: /workloads
  {{< / highlight >}}
 </figure>

### Extra notes 
- You do not need to specify a region in the apply_to section
- Tag policies can only be used in hub execution mode
- All json documents will be minimised before being applied

You have now successfully applied a tag policy!
