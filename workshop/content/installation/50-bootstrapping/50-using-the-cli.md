+++
title = "Command Line Interface"
chapter = false
weight = 50

+++

## What are we going to do?

You will need to bootstrap spoke accounts so you can configure them using the Service Catalog Tools.

Bootstrapping a spoke account will create an AWS CloudFormation stack in it.  This stack will contain the Puppet IAM 
Role (*PuppetRole*) which is needed by framework to perform actions in the spoke account. 

The following steps should be executed using the Service Catalog Puppet CLI which is an application built using Python 3.7.

If you have not already installed the framework you can do so by following these steps:

### Installing

It is good practice to install Python libraries in isolated environments. 

You can create the a virtual environment using the following command:

{{< highlight bash >}}
virtualenv --python=python3.7 venv
source venv/bin/activate
{{< / highlight >}}

Once you have decided where to install the library you can install the package:

{{< highlight bash >}}
pip install aws-service-catalog-puppet
{{< / highlight >}}

This will install the library and all of the dependencies.


### Bootstrapping a spoke

You should export the credentials for the spoke account or set your profile so that AWS CLI commands 
will execute as a role in the spoke account.

Then you can run the following command: 

_Without a permission boundary_
{{< highlight bash >}}
servicecatalog-puppet bootstrap-spoke <ACCOUNT_ID_OF_YOUR_PUPPET>
{{< / highlight >}}


_With a permission boundary_
{{< highlight bash >}}
servicecatalog-puppet bootstrap-spoke <ACCOUNT_ID_OF_YOUR_PUPPET> --permission-boundary arn:aws:iam::aws:policy/AdministratorAccess
{{< / highlight >}}

Ensure you replace *&lt;ACCOUNT_ID_OF_YOUR_PUPPET&gt;* with the AWS Account id of the AWS Account you will be using as your 
puppet account.  


### Bootstrapping a spoke as

If you want to assume a role into the spoke from your currently active role you can use the following command.

_Without a boundary_
{{< highlight bash >}}
servicecatalog-puppet bootstrap-spoke-as <ACCOUNT_ID_OF_YOUR_PUPPET> <ARN_OF_ASSUMABLE_ROLE_IN_SPOKE>
{{< / highlight >}}


_With a boundary_
{{< highlight bash >}}
servicecatalog-puppet bootstrap-spoke-as <ACCOUNT_ID_OF_YOUR_PUPPET> <ARN_OF_ASSUMABLE_ROLE_IN_SPOKE> --permission-boundary arn:aws:iam::aws:policy/AdministratorAccess
{{< / highlight >}}

This will assume the role <ARN_OF_ASSUMABLE_ROLE_IN_SPOKE> before running *boostrap-spoke*.  This is useful if you do not 
want to perform the AWS STS assume-role yourself. 

Ensure you replace *&lt;ACCOUNT_ID_OF_YOUR_PUPPET&gt;* with the account id of the account you will be using as your 
puppet account.  

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



### Bootstrapping spokes in OU

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
