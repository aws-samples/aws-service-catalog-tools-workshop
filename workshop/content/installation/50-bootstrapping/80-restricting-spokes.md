+++
title = "Restricting Spokes"
chapter = false
weight = 80

+++

### Restricting spokes

The *PuppetRole* created by the framework has the *AdministratorAccess* IAM managed policy attached to it.  It is 
reccommended that you can define an 
[IAM Permission Boundary](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) for the 
*PuppetRole* for any production applications of this framework.

The IAM Permission Boundary you provide should permit the *PuppetRole* to interact with AWS Service Catalog to accept 
shares, manage portfolios and to add, provision and terminate products. In addition the IAM Role should allow the use of 
AWS SNS, AWS EventBridge, AWS OpsCenter if you are making use of those features.

In order to use an IAM Permission Boundary you will need to append the following to your commands:

{{< highlight bash >}}
--permission-boundary arn:aws:iam::aws:policy/AdministratorAccess
{{< / highlight >}}

There will be an example of this for each command in these _how tos_.
