+++
title = "Using assertions"
weight = 700
home_region = "eu-west-1"
+++
---

## What are we going to do?

With assertions, you tell the framework to compare expected results to actual results.  If they do not match then the
framework sees this as a failure and anything depending on your assertion will not execute.

You can declare the expected results object in your manifest file where you can also tell the framework how to build up
an actual results.

This tutorial will walk you through how to use the "{{% param title %}}" feature.

We will assume you have:
 
 - installed Service Catalog Puppet correctly
 - bootstrapped a spoke
 - created a manifest file
 - added an account to the manifest file
 
We are going to perform the following steps to "{{% param title %}}":

- Adding an assertion to your manifest file

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Adding an assertion to your manifest file

Add the following snippet to your manifest file:

 <figure>
  {{< highlight js >}}
assertions:
  assert-puppet-role-path:
    expected:
      source: manifest
      config:
        value:
          - "/servicecatalog-puppet/"
    actual:
      source: boto3
      config:
        client: 'iam'
        call: list_roles
        arguments: {}
        use_paginator: true
        filter: Roles[?RoleName==`PuppetRole`].Path
    assert_for:
      tags:
        - regions: regions_enabled
          tag: role:all
  {{< / highlight >}}
 </figure>

If you already had an assertions please append the assert-puppet-role-path declaration to the existing assertions 
section.

You will most likely need to update the tag from role:all to whatever you are using in your environment.

#### What did we just do?

In each region of each account in your assert_for you asked service catalog puppet to do the following:

- assume role into the region of the account
- create an iam client using boto3
- using the client, call the list_roles command using a paginator and providing no arguments
- you then told service catalog puppet to use a filter to remove items from the results of the list_roles command - this
  is useful to remove things like CreateDate, Arns and other properties that vary by region / account.
  
This example was wasteful as IAM resources are global to an account - running the assertion in each region was just to
showcase how this works multi region.  Also, the puppet role is needed to run the assertion so again this was just an 
example of what you can do with this feature.  

### Recommendations 
- It is recommended to add assertions verifying default VPCs are removed.
- It is recommended to use fine-grained depends_on statements when using assertions to reduce choke points.  

You have now successfully executed an assertion!
