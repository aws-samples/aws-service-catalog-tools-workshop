+++
title = "Data governance"
weight = 150
+++
---

## The ask

The customer has recently established a data governance team.  They have recently issued guidance saying encryption 
should be used whenever data is at rest.

From this guidance there are two new requirements:

- ACME Org want to get visibility where encryption at rest is not being used
- The data governance team want to use AWS Service Catalog to distribute best practice for AWS RDS provisioning so teams can easily achieve compliance 


## The plan

We are going to create and deploy a security control using an AWS Config managed rule to ensure the right instance types
are being used. 

{{% children depth="1" showhidden="false" %}}

{{% notice note %}}
If you need help at any time please raise your hand.
{{% /notice %}}
