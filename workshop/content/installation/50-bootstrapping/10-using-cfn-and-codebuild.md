+++
title = "CloudFormation/CodeBuild"
chapter = false
weight = 10

+++

## What are we going to do?

You will need to bootstrap spoke accounts so you can configure them using the Service Catalog Tools.

Bootstrapping a spoke account will create an AWS CloudFormation stack in it.  This stack will contain the Puppet IAM
Role (*PuppetRole*) which is needed by framework to perform actions in the spoke account.

The following steps should be executed using the provided AWS CloudFormation templates and AWS CodeBuild projects which 
are linked to here or available in the home region of your puppet hub account.


### Bootstrapping a spoke

You should log into the account you want to bootstrap as a spoke and navigate to the AWS CloudFormation console in *your 
home* region using your web browser.

You should create an AWS CloudFormation stack with the name `servicecatalog-puppet-spoke` 

using the template 

`https://service-catalog-tools.s3.eu-west-2.amazonaws.com/puppet/latest/servicecatalog-puppet-spoke.template.yaml`

You should set parameter with the name of *PuppetAccountId* to the 12 digit AWS Account Id of your puppet hub account.

### Bootstrapping spokes in OU

If you have enabled AWS Organizations support you may want to bootstrap all spokes within an organizational unit.

Following these steps will allow you to bootstrap all AWS Accounts that exist within the same organizational unit.

In your AWS Account you can find an AWS CodeBuild project named: `servicecatalog-puppet-bootstrap-an-ou`

- Click _Start Build_

- Before you select _Start Build_ again, expand the _Environment variables override_ section. 

- Set *OU_OR_PATH* to the OU path or AWS Organizational Unit ID that contains all of the spokes you want to bootstrap

- Set *IAM_ROLE_NAME* to the name of the IAM Role that is assumable in the spoke accounts - this must be the same name in all accounts

- Set *IAM_ROLE_ARNS* to the ARNs you want to assume before assuming before the *IAM_ROLE_NAME*.  This is should you need to assume a role with cross account permissions.

- Click _Start Build_ again




