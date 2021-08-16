+++
title = "Removing the default networking"
weight = 100
+++
---

## What are we going to do?

When you create a new AWS account there are some networking resources already provisioned in the account.  If you are
planning on using an AWS Transit Gateway or connecting the AWS account to your local network then these resources may
not be required.  

We are going to create an AWS Lambda function that assumes role into an AWS account to remove the networking resources.
We will use a Service Catalog tools stack for this.  To do this we will create a pipeline that will create the stack and 
then we will provision the stack.  Once the stack is provisioned we will invoke the lambda function so that the 
resources are removed. Finally, we will verify the resources are no longer present using an assertion.


## How are we going to do it?

This task is broken down into the following steps:

{{% children depth="1" showhidden="false" %}}
