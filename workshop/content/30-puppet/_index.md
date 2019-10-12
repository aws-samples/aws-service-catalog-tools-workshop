+++
title = "Service Catalog Puppet"
chapter = false
weight = 30
+++
---

## What is Service Catalog Puppet

**Service Catalog Factory** is part of a suite of open source Tools which have been built to compliment the AWS Service Catalog Service.

Service Catalog Puppet enables you to provision AWS Service Catalog Products into multiple Accounts and Regions across your AWS Estate.

The Tool reduces the Operational burden of engineering a solution to support Product Provisioning across a large Enterprise and allows you to focus on writing the Products you require to support 
your Organizations needs.

## How does Service Catalog Puppet Work?

User interaction with the Framework is via a YAML file. The YAML file is used to describe your AWS Accounts as:

- Individual AWS Account Ids
- A set of AWS Accounts under a given AWS Organizational OU Path (Requires AWS organizations)

The Descriptions of those Accounts can then be tagged and used to 'Share' Portfolios and 'Launch' Products into them. The initial creation of the Portfolios and products can either be done manually or using the `Service Catalog Factory Toolset'

Under the covers, Service Catalog Puppet is converting requests into a workflow which is executed in your AWS Account using AWS CodePipeline, AWS CodeBuild and AWS CloudFormation.

## High-Level Architecture Diagram

You use an AWS CodeBuild project in a central _hub_ account that provisions AWS
Service Catalog Products into _spoke_ accounts on your behalf.  The framework
takes care of cross account sharing and cross region product replication for
you.

{{< figure src="/sc_puppet.png" height="600" width="800">}}





