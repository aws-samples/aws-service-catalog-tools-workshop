+++
title = "Migrating from stacksets to stacks"
weight = 384
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
 - have provisioned a stackset you want to migrate to a stack without recreating resources

We will assume you are comfortable:
 - making changes your manifest file
 

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Things to note, before we start

- This feature was added to version 0.134.0.  You will need to be using this version (or later)

### Updating your manifest file

Your account should contain a stack that was part of a stackset.  You will need to know the stack set name used.

You will need to add a stack to your manifest file. You can name the stack whatever you want. You will need to add an 
attribute named stack_set_name and the value should be the stack set name - not the stack set instance.  In this example 
it looks like this:

 <figure>
  {{< highlight js >}}
stacks:
  basic-vpc:
    name: basic-vpc
    version: v1
    stack_set_name: basic-vpc
    deploy_to:
      tags:
        - tag: group:spoke
          regions: regions_enabled
  {{< / highlight >}}
 </figure>

When you make this change the framework will look for a stacks in the spoke account with a stack name beginning with 
StackSet-basic-vpc-.  If it finds it, it will use your new (stack) template to update the CloudFormation stack your 
stack set created.  You should not modify the stack set unless you want to terminate the resources.  If you terminate the 
stackset or if the stack instance does not exist in the spoke account a new stack will be created using the stack name 
from the manifest file as the CloudFormation stack name.  

With this approach you can migrate a stack set to a stack.  In existing accounts the stack from the stack set will be 
used (with a name of StackSet-<stack_name>-<hash>) and in accounts where the stack from the stack set was never 
provisioned a new stack will be created using the manifest file stack name.