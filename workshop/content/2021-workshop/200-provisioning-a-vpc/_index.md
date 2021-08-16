+++
title = "Provisioning a VPC"
weight = 200
+++
---

## What are we going to do?

By now, you should have created a stack containing a lambda, provisioned it, invoked the lambda and then asserted
the effect of the lambda invocation.

Now the default networking resources are removed, you are ready to provision a new VPC.  The following section will
show you what it is like to create a VPC and storing a stack output in AWS Systems Manager Parameter Store for later
use.

Here are the steps you will need to follow:

{{% children depth="1" showhidden="false" %}}
