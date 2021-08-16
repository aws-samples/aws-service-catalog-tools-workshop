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
  assert-no-default-vpcs:
    expected:
      source: manifest
      config:
        value:
          - ""
    actual:
      source: boto3
      config:
        client: 'ec2'
        call: describe_vpcs
        arguments: {}
        use_paginator: true
        filter: Vpcs[?IsDefault==`true`].State
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
- using the client, call the describe_vpcs command using a paginator and providing no arguments
- you then told service catalog puppet to use a filter to remove items from the results of the describe_vpcs command - this
  is useful to remove things like CreateDate, Arns and other properties that vary by region / account.
  

### Recommendations 
- It is recommended to add assertions verifying default VPCs are removed.
- It is recommended to use fine-grained depends_on statements when using assertions to reduce choke points.  

You have now successfully executed an assertion!
