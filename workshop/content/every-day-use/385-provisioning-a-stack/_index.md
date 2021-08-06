+++
title = "Provisioning a Stack"
weight = 385
home_region = "eu-west-1"
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

We will assume you are comfortable:
 - making changes your portfolios files
 - making changes your manifest file
 
We are going to perform the following steps to "{{% param title %}}":

- creating a stack using Service Catalog Factory
- provision a stack using Service Catalog Puppet


## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Things to note, before we start

- This feature was added in version 0.63.0 of Service Catalog Factory.  You will need to be using this version (or later)
- This feature was added in version 0.109.0 of Service Catalog Puppet.  You will need to be using this version (or later)
- Stacks can use parameters, deploy_to and outputs
- Stacks can be used in spoke execution mode
- Stacks can be used in dry-runs
- Stacks can be provisioned in spoke execution mode (since Service Catalog Puppet version 0.109.0)
- Stacks do not appear in list-launches (they are not a launch)

## Creating a stack using Service Catalog Factory

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}} 

- click _Add file_ and then _Create file_

- Paste the following into the main input window:

- In the _File name_ field enter the following `stacks/example.yaml`

 <figure>
  {{< highlight js >}}
Schema: factory-2019-04-01
Stacks:
  - Name: "ssm-parameter"
    Versions:
      - Name: "v1"
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "ssm-parameter-stack"
            BranchName: "main"
  {{< / highlight >}}
 </figure>

- Please note the file name is not significant but it must have the extension `.yaml` and it must be in a directory named `stacks`

- Fill in the other fields and save the file.  Once you do the pipeline `servicecatalog-factory-pipeline` will run.  

- Once the pipeline is complete you will have a new pipeline named `stack--ssm-parameter-v1-pipeline`

- You should navigate to AWS CodeCommit, create a repo named `ssm-parameter-stack` and add a file named `stack.template.yaml` with the following content on the `main` branch:

 <figure>
  {{< highlight js >}}
Parameters:
  Name:
    Type: String
  Value:
    Type: String

Resources:
  Parameter:
    Type: AWS::SSM::Parameter
    Properties:
      Name: !Ref Name
      Type: String
      Value: !Ref Value

Outputs:
  Value:
    Value: !GetAtt Parameter.Value
{{< / highlight >}}
 </figure>

- Once you have added the file the pipeline `stack--ssm-parameter-v1-pipeline` will run.  It will take the source code and add will add it to Amazon S3 so you can use it in Service Catalog Puppet in the step below. 


## Provision a stack using Service Catalog Puppet

_Now we are ready to add a lambda invocation to the manifest file._

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}

- Click the *ServiceCatalogPuppet* repository

- Click the link to the *manifest.yaml* file, and then click the *Edit* button

- Add the following snippet to the end of the main input field:

 <figure>
  {{< highlight js >}}
stacks:
  ssm-parameter:
    name: ssm-parameter
    version: v1
    parameters:
      Name:
        default: "hello"
      Value:
        default: "world"
    deploy_to:
      tags:
        - tag: role:spoke
          regions: regions_enabled
  {{< / highlight >}}
 </figure>


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
