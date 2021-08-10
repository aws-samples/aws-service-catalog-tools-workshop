+++
title = "Removing the default networking"
weight = 100
+++
---

## What are we going to do?

When you create a new AWS account there are some networking resources already provisioned in the account.  If you are
planning on using an AWS Transit Gateway or connecting the AWS account to your local network then these resources may
not be required.  

We are going to create a pipeline that takes an AWS CloudFormation template to create a 'stack' in Amazon S3.  We will
then provision the stack containing an AWS Lambda function into our account using a 'stack' in our manifest file before
invoking it using a 'lambda-invocation' again using our manifest file.  Finally, we will verify the resources are no
longer present using an assertion.


## How are we going to do it?

This task is broken down into the following steps:

{{% children depth="1" showhidden="false" %}}
