+++
title = "Service Catalog Puppet"
chapter = false
weight = 30
+++
---

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






