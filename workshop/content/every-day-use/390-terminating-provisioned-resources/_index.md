+++
title = "Terminating provisioned resources"
weight = 390
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
 - provisioned a resource - either through a stack, app, workspace or launch

We will assume you are comfortable:
 - making changes your manifest file

We are going to perform the following steps:

- terminate a provisioned resource

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Terminate a provisioned resource

When you are ready to terminate a provisioned resource you will need to edit its definition in the manifest yaml.

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}

- Click the *ServiceCatalogPuppet* repository

- Click the link to the *manifest.yaml* file, and then click the *Edit* button

- Add or set the attribute status for the resource you want to terminate to terminated

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

- Example "launch" resource deletion:

 <figure>
  {{< highlight js >}}
launches:
  ssm-parameter:
    portfolio: self-service-portfolio
    product: ssm-parameter
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

### Committing the manifest file

_Now that we have updated the manifest file we are ready to commit our changes._

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*
- Click the *Commit changes* button:

{{< figure src="/how-tos/invoking-a-lambda-function/commit_changes.png" >}}

When the framework runs, the provisioned resource in the target account will be terminated.

You can verify this by navigating to the target account and checking the termination of resource.


### Notes

You can set the status attribute to "terminated" for the following resources actions to terminate the resources 
previously provisioned:

- launches
- stacks
- workspaces
- apps

If a resource was previously terminated by the solution in future executions the solution will verify the resources are
terminated.