+++
title = "Task 1"
weight = 100
+++
---

## The ask
Going back to our original requirements list, we have been asked to provide a mechanism to audit the current configuration of their AWS estate. To do this, we will enable AWS Config.

AWS Config is a service that enables you to assess, audit, and evaluate the configurations of your AWS resources. Config continuously monitors and records your AWS resource configurations and allows you to automate the evaluation of recorded configurations against desired configurations.


## The plan
_We are going to create an AWS Service Catalog product and provision it into our account.  This product will enable AWS
Config._

_To do this we will need to use Service Catalog factory to build the product and then we will use Service Catalog
puppet to provision it into the designated account._

This task should give you an understanding of how the service catalog tools are used to both create and then provision AWS Service Catalog products. We'll build on this knowledge in subsequent tasks.


{{% notice note %}}
If you need help at any time please raise your hands in the air like you just don't care.
{{% /notice %}}

{{% children depth="1" showhidden="false" %}}