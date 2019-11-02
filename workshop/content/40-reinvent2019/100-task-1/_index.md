+++
title = "Budget & cost governance"
weight = 100
+++
---

## The ask

Cloud usage within the organization has picked up significantly and a number of teams are now using EC2 instances in innovative ways. The customer has noticed that teams are often not sure which EC2 instance types to use for their applications and this is leading to underutilized EC2 instances that are run on-demand. To bring down costs, the customer has purchased a set of EC2 reserved instances, based on common workload profiles, and we need to ensure the teams are using them for long running applications.

To help the customer, we will design and then deploy a control that gives them visibility into which EC2 instance types are being used within an AWS account.

## The plan

We are going to create and deploy a governance control using an AWS Config managed rule to ensure the right instance types are being used.

You can follow these steps to do this:

{{% children depth="1" showhidden="false" %}}

Future work will involve mandating that teams use only approved instance types. To start, we will gather data via AWS Config.

{{% notice note %}}
If you need help at any time please raise your hand.
{{% /notice %}}
