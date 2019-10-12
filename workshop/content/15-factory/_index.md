+++
title = "Service Catalog Factory"
chapter = false
weight = 15
+++
---

## What is Service Catalog Factory

**Service Catalog Factory** is part of a suite of open source Tools which have been built to compliment the AWS Service Catalog Service.

Service Catalog Factory enables you to quickly build AWS CodePipelines that will create Service Catalog portfolios and populate them with products across multiple regions of your AWS Account.  You specify where in git the source code is for your products and you specify which regions you would like your products to exist and the framework will perform all of the undifferentiated heavy lifting for you.  

In addition, the pipelines the framework creates can perform functional tests and static
analysis on your templates to help you with your SDLC.


## How does Service Catalog Factory Work?

Service Catalog Factory allows you to define Service Catalog portfolios and products using YAML. You can version your products and specify where the source
code for them can be found. 

You can configure the frameowrk to publish the portfolios, products and versions in each of your required AWS Regions.

## High level architecture diagram

You build products in a central hub account using AWS CodePipeline and AWS CodeBuild, you then deploy them into AWS 
Service Catalog in every enabled region of your hub account using AWS CodePipeline and AWS CloudFormation. 

{{< figure src="/sc_factory.png" height="600" width="700">}}


