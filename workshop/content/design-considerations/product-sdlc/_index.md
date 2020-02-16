+++
title = "Product SDLC"
weight = 400

+++
---

## What are we going to do?

This article will explain how productive teams have been structuring their AWS accounts and how they have been managing
their source code whilst working with the Service Catalog Tools.

## AWS Account structure

Testing the provisioning of a single resource in AWS can be achieved using CloudFormation RSpec, awspec and others.
Testing the provisioning of a single resource or even a single AWS CloudFormation stack is valuable and will give you 
confidence that your change will behave in the way you think without any side effects.  When you have multiple developers
working on the same code base, or develop over time or have different developers provisioning different stacks that must
work with each other it can be difficult to manage and changes that introduce unexpected side effects can easily sneak
through.

We do not recommend you create a whole test installation of the Service Catalog Tools for the development of products.  
The management overhead of the installation and the complexity and delay it creates in your SDLC should be avoided and 
instead you should invest that effort into better automated testing so you can scale.   

We recommend you have at least a single canary account where you can provision products that will work together.  You 
can use *actions* from the Service Catalog Tools to automate the testing and promotion of products across your accounts 
including a mandatory provisioning into the canary account.

## Managing source code

We recommend you do not modify a product version that you have shared or provisioned.  If you make a change to a product
then you should change the version name.

We have seen gitflow working well with product development.  Whilst building a product the developer uses a develop
branch in git.  That develop version gets provisioned into the canary account for testing.  Once the testing is complete
the branch in merged to master and then rebranched from master to create a new version.  This worked well for teams
where a single developer was building a single product.  If you have a product that is too big for a single developer
then maybe the product needs to be split into smaller pieces.  There are features in the tools that allow you split
products into smaller pieces.

{{% notice note %}}
If you would like to share your SDLC process please raise a github issue to share
{{% /notice %}}
