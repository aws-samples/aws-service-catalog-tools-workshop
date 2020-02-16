+++
title = "Portfolio Management"
weight = 200

+++
---

## What are we going to do?

This article will help you understand AWS Service Catalog portfolios, what they are, how they are used by the service and
how you can best make use of them whilst using the Service Catalog Tools.

## Selecting how many factory accounts to have

Currently, you can only have one factory per account but you can create multiple accounts each with their own factory.

If multiple teams want to make use of Service Catalog Factory the default recommendation would be that each team have 
their own instance.  The teams are then independent and can operate without impact of each other.  There is also a 
separation of concerns if there is a security factory account and a networking factory account.  This reduces the blast
radius should there be an incident and it enables easier billing calculations.

If your organization has a central cloud engineering team who work to deliver the requirements of these other teams it 
may be easier to manage all of the provisioning from a single factory account.


## Selecting a factory account


In order to select a factory account we need to consider how you are going to be using the framework.

A common use case is where teams use the framework to build and provision security controls into 

