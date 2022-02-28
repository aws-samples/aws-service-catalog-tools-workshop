+++
title = "Deleting the provisioned resource"
weight = 300
home_region = "eu-west-1"
abc = true
+++
---

## What are we going to do?

This tutorial will walk you through how to use the "{{% param title %}}" feature.

We will assume you have:

 - installed Service Catalog Factory correctly
 - installed Service Catalog Puppet correctly
 - bootstrapped a spoke
 - created a manifest file
 - added an account to the manifest file
 - added a resource in manifest file
 - run the framework

We will assume you are comfortable:
 - making changes your portfolios files
 - making changes your manifest file

We are going to perform the following steps:

- delete a provisioned resource

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Delete a provisioned resource

When you are ready to delete a provisioned resource you will need to edit its definition in the portfolio yaml.

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}

- Click the *ServiceCatalogPuppet* repository

- Click the link to the *manifest.yaml* file, and then click the *Edit* button

- Add or set the attribute status for the resource you want to delete to terminated

- Example "stack" resource deletion:

 <figure>
  {{< highlight js >}}
stacks:
  ssm-parameter:
    name: ssm-parameter
    status: terminated
    version: v1
    parameters:
      Name:
        default: "hello"
      Value:
        default: "world"
    deploy_to:
      tags:
        - tag: type:prod
          regions: regions_enabled
  {{< / highlight >}}
 </figure>

### Note

The same "status: terminated" tag can be added to following resources as well to delete them from respective accounts.

- launches
- lambda-invocations
- code-build-runs
- service-control-policies

### Committing the manifest file

_Now that we have updated the manifest file we are ready to commit our changes._

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/how-tos/invoking-a-lambda-function/commit_changes.png" >}}

When the framework runs, the provisioned resource in the target account will be deleted.

You can verify this by navigating to the target account and checking the deletion of resource.
