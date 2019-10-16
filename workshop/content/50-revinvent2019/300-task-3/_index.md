+++
title = "Task 3"
weight = 300
+++
---
## The ask

Today, we have a way to create IAM roles that is managed by our InfoSec team. Over time, we've added hundreds of accounts and subsequently it has become difficult for a single team to create and update roles. We would like developers to have the ability to create roles on their own, but are worried that they may end up creating roles which have too many privileges. As a security focused organization, we want to ensure that roles are least privileged.


Can you help us develop a product that lets users create roles, but ensures that all roles created have a permissions boundary attached? A permissions boundary is an IAM policy which limits the maximum privileges a role or user can have.


## The plan

_We are going to create an AWS Service Catalog product and provision it into our account. This product is a role creator product. It lets users provision new roles for themselves, but limits the maximum privileges that role can have. Users can choose to attach the Administrator policy to their roles, but the permissions boundary will only allow a subset of actions in the Admin policy._

_To do this we will need to use Service Catalog factory to build the product and then we will need to use Service Catalog
puppet to provision it into the designated account._


{{% notice note %}}
If you need help at any time please raise your hands in the air like you just don't care.
{{% /notice %}}

{{% children depth="1" showhidden="false" %}}


{{% children depth="1" showhidden="false" %}}