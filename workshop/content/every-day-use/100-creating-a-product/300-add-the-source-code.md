+++
title = "Add the source code"
weight = 300
home_region = "eu-west-1"
+++
---

## What are we going to do?

We are going to perform the following steps:

- Add the source code for the version of the product we have just created


## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"


### Add the source code for your product
When you configured your product version, you specified the following: 

 <figure>
  {{< highlight js >}}
    Versions:
      - Name: "v1"
        Description: "v1 of aws-config-enable-config"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "aws-config-enable-config"
            BranchName: "master"
  {{< / highlight >}}
 </figure>


We now need to create the CodeCommit repository and add the AWS CloudFormation template we are going to use for our
product into that repository.

- Navigate to {{% codecommit_link %}}

- Click *Create repository*

{{< figure src="/how-tos/creating-and-provisioning-a-product/CreateRepository.png" >}}


- Input the name `aws-config-enable-config`

{{< figure src="/how-tos/creating-and-provisioning-a-product/InputTheName.png" >}}

- Click *Create*

{{< figure src="/how-tos/creating-and-provisioning-a-product/ClickCreate.png" >}}

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/how-tos/creating-and-provisioning-a-product/create_file.png" >}}

- Copy the following snippet into the main input field:
 
  <figure>
   {{< highlight js >}}
AWSTemplateFormatVersion: 2010-09-09
Description: |
  This template creates a Config Recorder and an Amazon S3 bucket where logs are published.

Resources:
  ConfigRole:
    Type: 'AWS::IAM::Role'
    Description: The IAM role used to configure AWS Config
    Properties:
      AssumeRolePolicyDocument:
        Version: 2012-10-17
        Statement:
          - Effect: Allow
            Principal:
              Service:
                - config.amazonaws.com
            Action:
              - 'sts:AssumeRole'
      ManagedPolicyArns:
        - arn:aws:iam::aws:policy/service-role/AWSConfigRole
      Policies:
        - PolicyName: root
          PolicyDocument:
            Version: 2012-10-17
            Statement:
              - Effect: Allow
                Action: 's3:GetBucketAcl'
                Resource: !Sub arn:aws:s3:::${S3ConfigBucket}
              - Effect: Allow
                Action: 's3:PutObject'
                Resource: !Sub arn:aws:s3:::${S3ConfigBucket}/AWSLogs/${AWS::AccountId}/${AWS::Region}
                Condition:
                  StringEquals:
                    's3:x-amz-acl': bucket-owner-full-control
              - Effect: Allow
                Action: 'config:Put*'
                Resource: '*'
  ConfigRecorder:
    Type: 'AWS::Config::ConfigurationRecorder'
    DependsOn: ConfigRole
    Properties:
      Name: default
      RoleARN: !GetAtt ConfigRole.Arn

  DeliveryChannel:
    Type: 'AWS::Config::DeliveryChannel'
    Properties:
      ConfigSnapshotDeliveryProperties:
        DeliveryFrequency: Six_Hours
      S3BucketName: !Ref S3ConfigBucket

  S3ConfigBucket:
    DeletionPolicy: Retain
    Description: S3 bucket with AES256 Encryption set
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Sub config-bucket-${AWS::AccountId}
      PublicAccessBlockConfiguration:
        BlockPublicAcls: True
        BlockPublicPolicy: True
        IgnorePublicAcls: True
        RestrictPublicBuckets: True
      BucketEncryption:
        ServerSideEncryptionConfiguration:
          - ServerSideEncryptionByDefault:
              SSEAlgorithm: AES256

  S3ConfigBucketPolicy:
    Type: AWS::S3::BucketPolicy
    Description: S3 bucket policy
    Properties:
      Bucket: !Ref S3ConfigBucket
      PolicyDocument:
        Version: 2012-10-17
        Statement:
          - Sid: AWSBucketPermissionsCheck
            Effect: Allow
            Principal:
              Service:
                - config.amazonaws.com
            Action: s3:GetBucketAcl
            Resource:
              - !Sub "arn:aws:s3:::${S3ConfigBucket}"
          - Sid: AWSBucketDelivery
            Effect: Allow
            Principal:
              Service:
                - config.amazonaws.com
            Action: s3:PutObject
            Resource: !Sub "arn:aws:s3:::${S3ConfigBucket}/AWSLogs/*/*"

Outputs:
  ConfigRoleArn:
    Value: !GetAtt ConfigRole.Arn
  S3ConfigBucketArn:
    Value: !GetAtt S3ConfigBucket.Arn
   {{< / highlight >}}
  </figure>


- Set the *File name* to `product.template.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

Creating that file should trigger your 
{{% codepipeline_pipeline_link "aws-config-enable-config-v1-pipeline" %}}.  

Once the pipeline has completed it should show the *Source*, *Package* and *Deploy* stages in green to indicate they have 
completed successfully:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SuccessfulFactoryProductRun.png" >}}

{{% notice tip %}}
You should see your commit message on this screen, it will help you know which version of ServiceCatalogFactory repository the 
pipeline is processing.
{{% /notice %}}

Once you have verified the pipeline has run you can go to {{% service_catalog_products_list_link %}} to view your newly
created version.

You should see the product you created listed:

{{< figure src="/how-tos/creating-and-provisioning-a-product/SeeYourTask1Product.png" >}}

Click on the product and verify *v1* is there

{{< figure src="/how-tos/creating-and-provisioning-a-product/SeeYourTask1ProductVersion1.png" >}}

You have now successfully created a version for your product!  
