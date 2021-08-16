+++
title = "Running yourself"
weight = 100
home_region = "eu-west-1"
aliases = [
    "/40-reinvent2019/30-prerequisites/100-running-yourself.html",
]
+++
---

## What are we going to do?

We are going to perform the following steps:

- Enable AWS Config
- Install the tools
- Create an IAM Role

In order to run the workshop in your own account you will need to enable AWS Config and create an IAM Role named
TeamRole which you must then assume in order to complete the activities. 

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Enable AWS Config

- You should save the following into a file named _enable-aws-config.template.yaml_:
 
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

 
- You should then use AWS CloudFormation to create a stack named _enable-aws-config_ using the template you just created

#### What did we just do?

- You created an AWS CloudFormation template
- You used the template to create a stack
- The stack you created enabled AWS Config


### Install the tools

- You should save the following into a file named _install-the-tools.template.yaml_:

 <figure>
  {{< highlight js >}}
AWSTemplateFormatVersion: 2010-09-09
Description: "This template uses Stack Resource to install Service Catalog Factory and Puppet"

Resources:
  FactoryInstall:
    Type: AWS::CloudFormation::Stack
    Properties: 
      Parameters:
        EnabledRegions: eu-west-1
      TemplateURL: "https://service-catalog-tools.s3.eu-west-2.amazonaws.com/factory/latest/servicecatalog-factory-initialiser.template.yaml"
      TimeoutInMinutes: 30
  PuppetInstall:
    Type: AWS::CloudFormation::Stack
    Properties: 
      Parameters:
          EnabledRegions: eu-west-1
          ShouldCollectCloudformationEvents: False
          ShouldForwardEventsToEventbridge: False
          ShouldForwardFailuresToOpscenter: False
      TemplateURL: "https://service-catalog-tools.s3.eu-west-2.amazonaws.com/puppet/latest/servicecatalog-puppet-initialiser.template.yaml"
      TimeoutInMinutes: 30
  {{< / highlight >}}
 </figure>
 
 - You should then use AWS CloudFormation to create a stack named _install-the-tools.template_ using the template you just created

#### What did we just do?

- You created an AWS CloudFormation template
- You used the template to create a stack named _install-the-tools_
- The stack you created installed the service catalog tools with the correct configuration for the workshop to run


### Create an IAM Role

- You should save the following into a file named _create-iam-role.template.yaml_:

 <figure>
  {{< highlight js >}}
AWSTemplateFormatVersion: "2010-09-09"
Description: |
  Template used to create an IAM role to be used for the service catalog tools workshop

Resources:
  TeamRole:
    Type: AWS::IAM::Role
    Properties:
      RoleName: TeamRole      
      AssumeRolePolicyDocument:
        Version: "2012-10-17"
        Statement:
          - Effect: "Allow"
            Principal:
              AWS: !Sub "arn:aws:iam::${AWS::AccountId}:root"
            Action:
              - "sts:AssumeRole"
      ManagedPolicyArns:
        - arn:aws:iam::aws:policy/AdministratorAccess
  {{< / highlight >}}
 </figure>

- You should then use AWS CloudFormation to create a stack named _create-iam-role.template_ using the template you just created

- You should then assume that role in order to start the workshop


#### What did we just do?

- You created an AWS CloudFormation template
- You used the template to create a stack named _create-iam-role_
- You then assumed the role so you have the correct permissions needed and have the correct role name
