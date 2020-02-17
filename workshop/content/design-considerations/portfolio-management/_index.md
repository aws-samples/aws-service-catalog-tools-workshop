+++
title = "Portfolio Management"
weight = 200

+++
---

## What are we going to do?

This article will help you understand AWS Service Catalog portfolios, what they are, how they are used by the service and
how you can best make use of them whilst using the Service Catalog Tools.

## What is a portfolio?

Within AWS Service Catalog a portfolio is a logical grouping of products.

It makes sense to group products that provision similar or complimentary resources together, but this may not give you 
the flexibility you need:

- Within AWS Service Catalog you set associations at the portfolio level so by default when you grant access to a portfolio 
all products can be seen.
- Within AWS Service Catalog you can share portfolios with other accounts.  You cannot share just a single product from a 
portfolio. 

## How you can make best use of them

When using the Service Catalog Tools we recommend you think about how your products will be consumed.  If you are going
to offer a 'service catalog' or build a vending machine we recommend grouping those products together into a portfolio.

When using the Service Catalog Tools to provision resources into an account we recommend grouping those products into a 
portfolio.

When you have multiple teams building products we recommend each team having their own portfolios.

This normally results in at least two portfolios per team:

- team a
  - self service offering 
  - other products 
- team b
  - self service offering 
  - other products 
  
The teams we have worked with normally group the products into mandatory products and self service products.  For 
example, if the team using Service Catalog Tools is a cloud engineering / CCOE team they would provision products like
AWS Security Hub Enabler into an account - this would be mandatory.  If the same team had some optional products like
Encrypted S3 Bucket then this would go into an optional portfolio.  This results in the following structure:

- team a
  - mandatory 
  - optional 

The names of the portfolios are for you to chose as you know your audience better than we do but we have found the 
following names work well:

- mandatory
- optional
- vending-machine
- networking-self-service
- well-governed-vending-machine
- well-architected-vending-machine
- compulsory

{{% notice note %}}
If you would like to share your portfolio names raise a [github issue](https://github.com/aws-samples/aws-service-catalog-tools-workshop/issues) to share
{{% /notice %}}
