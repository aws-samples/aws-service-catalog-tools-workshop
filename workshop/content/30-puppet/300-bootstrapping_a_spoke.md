+++
title = "Bootstrapping a spoke"
weight = 300
+++

# Bootstrapping Spoke Accounts


## What is Bootstrapping and How do I do it?

In the previous sections you setup your Puppet Account so that you could centrally manage the sharing of Portfolio and launch of Products across other Accounts in your estate.

To enable Puppet to interact with other Accounts (called Spoke Accounts throughout the documentation) in your estate we need to bootstrap them with a new IAM Role which can be assumed (via a Trust) by the Puppet Account. This Role has the permissions required to Manage the Portfolios and launch the Products in that Account.

There are 2 methods of bootstrapping available:

**METHOD 1**

Export IAM credentials for an existing Spoke Account and run from the command live within your virtualenv:

    servicecatalog-puppet bootstrap-spoke <12_DIGIT_ID_OF_THE_PUPPET_ACCOUNT>

> NOTE: We will be using Method 1 to Bootstrap our Account

**METHOD 2**

Make use of the [Account Vending Machine](https://github.com/awslabs/aws-service-catalog-products) Product as this allows you to create AWS Accounts and bootstrap them with the PuppetRole. Note that this requires you to be using AWS organizations.
