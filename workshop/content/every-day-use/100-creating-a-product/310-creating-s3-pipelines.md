+++
title = "Creating S3 pipelines"
weight = 310
home_region = "eu-west-1"
+++
---

## What are we going to do?

We are going to perform the following steps:

- How to use S3 as a source for your pipelines


## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"


### Add the source code for your product
When you configured your product version, you may have specified the following: 

 <figure>
  {{< highlight js >}}
    Versions:
      - Name: "v1"
        Description: "v1 of aws-config-enable-config"
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "aws-config-enable-config"
            BranchName: "v1"
  {{< / highlight >}}
 </figure>

This would have taken your products source code from CodeCommit.  If you are using BitBucket Server or an SCM solution
where you cannot use AWS CodeStar Connections you may want to configure your pipelines source your products from 
AWS S3 and then use another solution to put the source code there.  To do so, you can specify the following:

 <figure>
  {{< highlight js >}}
    Versions:
      - Name: "v1"
        Description: "v1 of aws-config-enable-config"
        Source:
          Provider: "S3"
          Configuration:
            BucketName: "incomingproductchanges"
            S3ObjectKey: "aws-config-enable-config/v1/product.zip"
  {{< / highlight >}}
 </figure>

Please note, if you create S3 sourced pipelines you will be responsible for the creation of the AWS S3 Bucket.

Since version 0.64.0 you can use intrinsic functions in the BucketName and S3ObjectKey values.  The resultant AWS
CloudFormation template that is generated to provision the AWS CodePipeline uses the Sub intrinsic function so you can
now do the following:

 <figure>
  {{< highlight js >}}
    Versions:
      - Name: "v1"
        Description: "v1 of aws-config-enable-config"
        Source:
          Provider: "S3"
          Configuration:
            BucketName: "incomingproductchanges-for${AWS::AccountId}"
            S3ObjectKey: "aws-config-enable-config/v1-${AWS::AccountId}/product.zip"
  {{< / highlight >}}
 </figure>

This is useful when creating configuration files that will be shared across different AWS Organizations.