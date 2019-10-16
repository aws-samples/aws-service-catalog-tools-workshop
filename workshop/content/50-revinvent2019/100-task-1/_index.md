+++
title = "Task 1"
weight = 100
+++
---

## The ask
Our users love to use S3 to build innovative solutions. As we are a regulated industry, we are required to check that they do so with the right security controls in place. Today, we don't know if all our users are using server-side encryption to ensure that we comply with our internal security policies. We want to identify S3 buckets that are in use today that don't use S3 server side encryption and notify users so that they can enforce it by default.

In the past, we've had our wizards from the InfoSec team log in to various accounts and check if resources are compliant with security policies. As we've grown, this is becoming time consuming and error prone to do at scale. We would like to do checks like these automatically, and leave our InfoSec team to work on more challenging problems.

Can you help us develop an automated mechanism to check for non-compliant S3 buckets?


## The plan
_We are going to create an AWS Service Catalog product and provision it into our account.  This product will enable an 
AWS Config managed rule that will check if server side encryption is enabled on the AWS S3 buckets in our account._

_To do this we will need to use Service Catalog factory to build the product and then we will need to use Service Catalog
puppet to provision it into the designated account._


{{% notice note %}}
If you need help at any time please raise your hands in the air like you just don't care.
{{% /notice %}}

{{% children depth="1" showhidden="false" %}}