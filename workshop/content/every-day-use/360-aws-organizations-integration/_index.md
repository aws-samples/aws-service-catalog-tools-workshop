+++
title = "AWS Organizations Integration"
weight = 360
+++
---

This tutorial will walk you through "{{% param title %}}" with Service Catalog Tools.

We will assume you have:

 - installed Service Catalog Puppet correctly
 - [setup AWS Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_tutorials_basic.html) including: 
   - a [Management Account](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html)
   - [Member Account(s)](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html) in an [Organizational Unit (OU)](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html)
 - [setup an IAM Role for AWS Organizations]({{< ref "/installation/30-service-catalog-puppet/10-using-aws-organizations" >}} "Setup Organizations")
 - bootstrapped a spoke
 - created a product
 - created a portfolio

In the tutorial you will look at:

{{% children depth="1" showhidden="false" %}}

During this process you will check your progress by verifying what the framework is doing. 


