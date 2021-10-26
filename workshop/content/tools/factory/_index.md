+++
title = "Service Catalog Factory"
chapter = false
weight = 10
+++
---

## What is Service Catalog Factory

**Service Catalog Factory** is the first of the Service Catalog tools.  It is an AWS Solution designed to accelerate
the creation of AWS CodePipelines.  The pipelines it creates take source code, allow you to run static analysis and 
functional tests before packaging and preparing for later use when using **Service Catalog Puppet**

The pipelines you create can package AWS Cloudformation templates to be used in stacks, launches or spoke local 
portfolios when using **Service Catalog Puppet**.  You can also package source code to be used in a workspace or an app 
when using **Service Catalog Puppet**.  Using **Service Catalog Factory** you can package AWS CloudFormation, AWS CDK or 
Hashicorp based git repositories.

## Overview

When installing **Service Catalog Factory** you create a pipeline named servicecatalog-factory-pipeline.  This pipeline
can use AWS CodeStar connections, Amazon S3 or AWS CodeCommit as its source.  The source contains descriptions of the 
different pipelines you want to create.

When the pipeline runs it will verify all existing pipelines that were previously created are configured correctly and 
it will create pipelines for the newly declared pipelines:

{{< figure src="/images/factory/factory-conceptual.png" >}}

When you are using portfolios in your git repository the pipeline will also create the AWS Service Catalog products in 
each of your enabled regions.  If you add an additional region you will need to rerun the pipeline for changes to be 
made.

## What Do The Pipelines Look Like

The pipelines comprise of the following stages:

{{< figure src="/images/factory/factory-pipelines.png" >}}

### Source
The source stage listens to changes in your specified source code management system and triggers the pipeline when there
are changes.  The source git repository can be AWS CodeStar connections, Amazon S3, AWS CodeCommit or a custom source 
action.

### Build
The build stage is optional.  You can specify a build stage by providing your own buildspec and specifying which AWS 
CodeBuild environment you would like to use.  This is useful when you are using code generation tools to generate your 
AWS Cloudformation template - eg. when using Troposphere.

### Test
The test stage fans out to make use of parallel steps in AWS CodePipeline.  Each step in the phase needs to complete 
successfully for the operation to fan back in and continue to the package stage.

The framework provided test stage steps vary depending on which type of source code you are using:

#### Stacks
- Validate - An AWS Cloudformation validate is performed on the provided template.  This cannot be disabled.
- CFN Nag - CFN Nag is run on the provided template.  This is disabled by default.
- CloudFormation RSpec - the tests you provide in your git repo are executed using CloudFormation RSpec.  This is disabled by default.

#### Portfolios
- Validate - An AWS Cloudformation validate is performed on the provided template.  This cannot be disabled.
- CFN Nag - CFN Nag is run on the provided template.  This is disabled by default.
- CloudFormation RSpec - the tests you provide in your git repo are executed using CloudFormation RSpec.  This is disabled by default.

#### Workspaces
- There are no framework provided steps for workspaces.

#### Apps
- There are no framework provided steps for apps.

### Package
The package stage takes your input and makes it available for each region you operate in.  If you are using local 
resources like source code in an AWS Lambda function the package stage can be used to execute an AWS Cloudformation 
package command for each region you operate in.  If you are using workspaces or apps the package stage will zip your 
source code.  A default package stage is provided for you.

### Deploy
The deploy stage takes your prepared artefact and submits it to the corresponding repository:

| Type | Repository |
| ----- | --------- |
| stacks | Amazon S3 |
| portfolios | AWS Service Catalog |
| workspaces | Amazon S3 |
| apps | Amazon S3 |

#### Regions without AWS Codepipeline support
If you are using a region without AWS Codepipeline support the framework will detect this and use an AWS CodeBuild project to perform the cross region deployment.  