+++
title = "Provisioning a VPC"
weight = 200
+++
---

## What are we going to do?

When you create a new AWS account there are some networking resources already provisioned in the account.  If you are
planning on using an AWS Transit Gateway or connecting the AWS account to your local network then these resources may
not be required.

We are going to provision and then execute an AWS Lambda function that will delete the networking resources from any
account we configure.  This task is broken down into the following steps:

{{% children depth="1" showhidden="false" %}}
