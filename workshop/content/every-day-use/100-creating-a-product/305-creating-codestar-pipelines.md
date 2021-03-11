+++
title = "Creating CodeStar pipelines"
weight = 305
home_region = "eu-west-1"
+++
---

## What are we going to do?

We are going to perform the following steps:

- How to use AWS CodeStar Connections as a source for your pipelines (for Github.com/Github Enterprise and BitBucket Cloud)

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

This would have taken your products source code from CodeCommit.  If you are using BitBucket Cloud, Github.com or Github
Enterprise (where you can use AWS CodeStar Connections) you may want to use CodeStar Connections to simplify the creation
of product version pipelines.

To do so, you can specify the following:

 <figure>
  {{< highlight js >}}
    Versions:
      - Name: "v1"
        Description: "v1 of aws-config-enable-config"
        Source:
          Provider: "CodeStarSourceConnection"
          Configuration:
            BranchName: "v1"
            ConnectionArn: "arn:aws:codestar-connections:eu-west-1:0123456789010:connection/eb6703af-6407-0522dc6a6"
            FullRepositoryId: "exampleorg/aws-config-enable-config"
  {{< / highlight >}}
 </figure>
