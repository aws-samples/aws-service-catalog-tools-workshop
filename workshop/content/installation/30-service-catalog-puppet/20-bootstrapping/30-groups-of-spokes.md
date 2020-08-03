+++
title = "Groups of spokes"
chapter = false
weight = 30

+++

## What are we going to do?

If you have enabled AWS Organizations support you may want to bootstrap all spokes within an organizational unit.

Following these steps will allow you to bootstrap all AWS Accounts that exist within the same organizational unit.

### Using the CodeBuild Project

In your AWS Account you can find an AWS CodeBuild project named: `servicecatalog-puppet-bootstrap-an-ou`

- Click _Start Build_

- Before you select _Start Build_ again, expand the _Environment variables override_ section. 

- Set *OU_OR_PATH* to the OU path or AWS Organizational Unit ID that contains all of the spokes you want to bootstrap

- Set *IAM_ROLE_NAME* to the name of the IAM Role that is assumable in the spoke accounts - this must be the same name in all accounts

- Set *IAM_ROLE_ARNS* to the ARNs you want to assume before assuming before the *IAM_ROLE_NAME*.  This is should you need to assume a role with cross account permissions.

- Click _Start Build_ again

### Using the CLI

The following steps should be executed using the Service Catalog Puppet CLI which is an application built using Python 3.7.

If you have not already installed the framework you can do so by following these steps:

#### Create an isolated Python environment

It is good practice to install Python libraries in isolated environments. 

You can create the a virtual environment using the following command:

{{< highlight bash >}}
virtualenv --python=python3.7 venv
source venv/bin/activate
{{< / highlight >}}

#### Install the package locally

Once you have decided where to install the library you can install the package:

{{< highlight bash >}}
pip install aws-service-catalog-puppet
{{< / highlight >}}

This will install the library and all of the dependencies.

#### Bootstrapping spokes in OU

You should export the credentials for the account that allows you to list accounts in the org and assume an IAM Role in each 
of the spokes.

Then you can run the following command: 

_Without a Permission Boundary_
{{< highlight bash >}}
servicecatalog-puppet bootstrap-spokes-in-ou /dev DevOpsAdminRole
{{< / highlight >}}

In this example /dev is the ou path and DevOpsAdminRole is the name of the assumable role in each spoke account. 

_With a Permission Boundary_
{{< highlight bash >}}
servicecatalog-puppet bootstrap-spokes-in-ou /dev DevOpsAdminRole --permission-boundary arn:aws:iam::aws:policy/AdministratorAccess
{{< / highlight >}}


If your current role does not allow you to list accounts in the AWS Organization or allow you to *assume-role* across AWS accounts you can 
specify an ARN of an IAM role that does. When you do so the framework will assume that IAM Role first and then perform the 
bootstrapping.

{{< highlight bash >}}
servicecatalog-puppet bootstrap-spokes-in-ou /dev DevOpsAdminRole arn:aws:iam::0123456789010:role/OrgRoleThatAllowsListAndAssumeRole
{{< / highlight >}}


You can use the following AWS CloudFormation template to provision the needed role:

{{< highlight yaml >}}
# Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

AWSTemplateFormatVersion: '2010-09-09'
Description: IAM Role needed to use AWS Organizations to assume role into member AWS Accounts.

Parameters:
  ServiceCatalogFactoryAccountId:
    Description: The account you will be installing AWS Service Catalog Factory into
    Type: String

  OrganizationAccountAccessRole:
    Description: Name of the IAM role used to access cross accounts for AWS Orgs usage
    Default: OrganizationAccountAccessRole
    Type: String

Resources:
  RoleForBootstrappingSpokes:
    Type: AWS::IAM::Role
    Description: |
      IAM Role needed by the account vending machine so it can create and move accounts
    Properties:
      Path: /servicecatalog-puppet/
      Policies:
        - PolicyName: Organizations
          PolicyDocument:
            Version: 2012-10-17
            Statement:
              - Effect: Allow
                Action:
                  - sts:AssumeRole
                Resource: !Sub "arn:aws:iam::*:role/${OrganizationAccountAccessRole}"
      AssumeRolePolicyDocument:
        Version: "2012-10-17"
        Statement:
          - Effect: "Allow"
            Principal:
              AWS: !Sub "arn:aws:iam::${ServiceCatalogFactoryAccountId}:root"
            Action:
              - "sts:AssumeRole"

Outputs:
  RoleForBootstrappingSpokesArn:
    Description: The ARN for your Assumable role in root account
    Value: !GetAtt RoleForBootstrappingSpokes.Arn
{{< / highlight >}}
