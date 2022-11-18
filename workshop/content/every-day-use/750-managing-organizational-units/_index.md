+++
title = "Managing Organizational Units"
weight = 750
home_region = "eu-west-1"
+++
---

## What are we going to do?

This tutorial will walk you through how to use the "{{% param title %}}" feature.

We will assume you have:
 
 - installed Service Catalog Puppet correctly
 - set up AWS Organizations support for Puppet
 - created a manifest file
 
We are going to perform the following steps to "{{% param title %}}":

- Creating an Organizational Unit
- Optimising Your Organizations Usage

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"


### Creating an Organizational Unit

To create an organizational unit you must create an organizational-units entry in your manifest file:

 <figure>
  {{< highlight yaml >}}
organizational-units:
  workloads-production:
    path: "/workloads/production"
    create_in:
      accounts:
        - account_id: "012345678910"
          regions: "default_region"
    tags:
      - Key: "WorkloadType"
        Value: "Production"
  {{< / highlight >}}
 </figure>

The snippet above will create a workloads OU within the root of your organization and will then create a production OU 
within it.  If either of the two OUs exist already this solution will not try to recreate them.

When this solution creates the OU it will assign the tags you have specified.

### Optimising Your Organizations Usage

AWS Organization API throttling limits are associated to your management account and shared between all consumers.  It 
is best practice to reduce the calls you make to AWS Organizations.  To reduce the calls you can specify parent_ou_id 
within the configuration.  This will stop the solution from 'looking up' the OUs parent using the API and thus save you 
some API calls. 

 <figure>
  {{< highlight yaml >}}
organizational-units:
  workloads-production:
    path: "/workloads/production"
    parent_ou_id: "ou-aaaa-bbbbbbbb"
    create_in:
      accounts:
        - account_id: "012345678910"
          regions: "default_region"
    tags:
      - Key: "WorkloadType"
        Value: "Production"
  {{< / highlight >}}
 </figure>