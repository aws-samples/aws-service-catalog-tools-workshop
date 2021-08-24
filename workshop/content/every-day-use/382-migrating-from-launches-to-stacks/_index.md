+++
title = "Migrating from launches to stacks"
weight = 382
home_region = "eu-west-1"
+++
---

## What are we going to do?

This tutorial will walk you through how to use the "{{% param title %}}" feature.

We will assume you have:
 
 - installed Service Catalog Puppet correctly
 - bootstrapped a spoke
 - created a manifest file
 - added an account to the manifest file
 - have provisioned a launch you want to migrate to a stack without recreating resources

We will assume you are comfortable:
 - making changes your manifest file
 

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Things to note, before we start

- This feature was added to version 0.114.0.  You will need to be using this version (or later)

### Updating your manifest file

Your manifest should contain a launch:

 <figure>
  {{< highlight js >}}
launches:
  basic-vpc:
    portfolio: ccoe
    product: basic-vpc
    version: v1
    deploy_to:
      tags:
        - tag: group:spoke
          regions: regions_enabled
  {{< / highlight >}}
 </figure>

You will need to remove the launch named basic-vpc from your manifest file and add a stack to your manifest file. You 
can name the stack whatever you want. You will need to add an attribute named launch_name with the value of basic-vpc 
where basic-vpc is the launch name you used previously.  In this example it looks like this:

 <figure>
  {{< highlight js >}}
stacks:
  basic-vpc:
    name: basic-vpc
    version: v1
    launch_name: basic-vpc
    deploy_to:
      tags:
        - tag: group:spoke
          regions: regions_enabled
  {{< / highlight >}}
 </figure>

When you make this change the framework will look for a provisioned product in the spoke account named basic-vpc.  If it
finds it, it will use your new (stack) template to update the CloudFormation stack your previous launch created.  You 
should not terminate the provisioned product unless you want to terminate the resources.  If you terminate the product
or if the product does not exist in the spoke account a new stack will be created using the stack name from the manifest
file as the CloudFormation stack name.  

With this approach you can migrate a launch to a stack.  In existing accounts the stack from the provisioned product
will be used (with a name of SC-<account_id>-<pp_id>) and in accounts where the stack from the product was never 
provisioned a new stack will be created using the manifest file stack name.