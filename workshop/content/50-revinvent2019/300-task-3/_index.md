+++
title = "Task 3"
weight = 300
+++
---
## The ask

Now that we have a way to look for non-compliant buckets, we'd like to give users the ability to create S3 buckets that comply with our security policies by default. We have a number of requirements around how these buckets should be created, but we've figured out that we can encode these requirements as configuration for S3 bucket. 

Going forward, we will require users to use our AWS Service Catalog product to create S3 buckets, instead of creating S3 buckets directly.

Can you help us develop a service catalog product that creates buckets with encryption enabled by default?

## The plan

_We are going to create an AWS Service Catalog product and provision it into our account.  This product will allow users to create
S3 buckets that have encryption enabled by default._

_To do this we will need to use Service Catalog factory to build the product and then we will need to use Service Catalog
puppet to provision it into the designated account._


{{% notice note %}}
If you need help at any time please raise your hands in the air like you just don't care.
{{% /notice %}}

{{% children depth="1" showhidden="false" %}}


{{% children depth="1" showhidden="false" %}}