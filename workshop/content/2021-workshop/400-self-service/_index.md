+++
title = "Self service"
weight = 400
+++
---

## What are we going to do?

We have now removed the default networking resources, created a VPC and two subnets.

As we build out a multi account environment we may want to allow our end user to decide how many subnets they need, 
what sizes they are or which VPC they should be attached to.  AWS Service Catalog is a great way to achieve this.  You
can create a product, add it to a portfolio and then allow your users to provision the product with limited options.

The following steps will show you how to make a product and share it with an account:

{{% children depth="1" showhidden="false" %}}
