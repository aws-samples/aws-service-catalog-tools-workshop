+++
title = "Service Catalog Tools"
chapter = false
weight = 11
+++
---

## What are the Service Catalog Tools

The Service Catalog Tools are a collection of open source tools authored to accelerate your use as AWS Service Catalog.

To find out more about the tools please read through the following:


## What is Service Catalog Factory

**Service Catalog Factory** is part of a suite of open source Tools which have been built to compliment the AWS Service Catalog Service.

Service Catalog Factory enables you to quickly build AWS CodePipelines that will create Service Catalog portfolios and populate them with products across multiple regions of your AWS Account.  You specify where in git the source code is for your products and you specify which regions you would like your products to exist and the framework will perform all of the undifferentiated heavy lifting for you.  

In addition, the pipelines the framework creates can perform functional tests and static
analysis on your templates to help you with your SDLC.


Service Catalog Factory allows you to define Service Catalog portfolios and products using YAML. You can version your products and specify where the source
code for them can be found. 

You can configure the frameowrk to publish the portfolios, products and versions in each of your required AWS Regions.

## High level architecture diagram

You build products in a central hub account using AWS CodePipeline and AWS CodeBuild, you then deploy them into AWS 
Service Catalog in every enabled region of your hub account using AWS CodePipeline and AWS CloudFormation. 

{{< figure src="/sc_factory.png" height="600" width="700">}}

User interaction with the Framework is via a YAML file. The YAML file contains the definition of the Portfolios and Products you want to manage. Updates to the YAML file in AWS CodeCommit triggers the AWS CodePipeline to manage execute the tasks required.


## What is Service Catalog Puppet

**Service Catalog Puppet** is part of a suite of open source Tools which have been built to compliment the AWS Service Catalog Service.

Service Catalog Puppet enables you to provision AWS Service Catalog Products into multiple Accounts and Regions across your AWS Estate.

The Tool reduces the Operational burden of engineering a solution to support Portfolio Sharing and Product Launches across a large Enterprise and allows you to focus on writing the Products you require to support your Organizations needs.

Service Catalog Puppet makes use of a number of AWS Services including AWS CodePipeline, AWS CodeBuild and AWS CloudFormation to manage this for you.

## High-Level Architecture Diagram

You use an AWS CodeBuild project in a central _hub_ account that provisions AWS
Service Catalog Products into _spoke_ accounts on your behalf.  The framework
takes care of cross account sharing and cross region product replication for
you.

{{< figure src="/sc_puppet.png" height="600" width="800">}}

User interaction with the Framework is via a YAML file. The YAML file contains the definition of the AWS Accounts you want to manage (using tags), the portfolios you want to share and the Products you want to launch.






