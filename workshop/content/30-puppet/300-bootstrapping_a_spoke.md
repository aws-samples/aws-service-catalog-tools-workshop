+++
title = "Bootstrapping a spoke"
weight = 300
+++


## What is Bootstrapping and How do I do it?

To enable Puppet to interact with other Accounts (called Spoke Accounts throughout the documentation) in your estate we need to bootstrap them with a new IAM Role which can be assumed (via a Trust) by the Puppet Account. This Role has the permissions required to Manage the Portfolios and launch the Products in that Account.

There are 2 methods 2 do this outlined in the [service catalog puppet documentation](https://aws-service-catalog-puppet.readthedocs.io/en/latest/puppet/getting_up_and_running.html#bootstrap-your-spokes). However, for the purpose of the Workshop and since we are only using one Account, the CloudFormation which you deployed in the previous section, bootstrapped the Account for you.

{{% notice note%}}
The Account you are using as part of this workshop has been bootstrapped as part of the installtion process in the previous section.
{{% /notice %}}