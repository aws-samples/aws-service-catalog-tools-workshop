+++
title = "Using AWS Organizations"
chapter = false
weight = 10
home_region = 'eu-west-1'
home_region_name = 'Ireland'

+++

You can use Service Catalog Puppet with AWS Organizations.  Using it will allow you describe all accounts within an 
organizational unit as a single entity.  This provides a quicker way to get started and an easier way of managing 
multiple account environments.  You can also use AWS Service Catalog's support for AWS Organizations delegated 
administrator to reduce the number of invites and accepts for portfolio sharing.

## What are we going to do?

When enabling AWS Organizations you will need to provision an IAM Role in the Organization's management account and you 
will then need to provide the ARN of that role to your puppet account as an AWS SSM parameter.  

The role provisioned in the Organizations management account is only used to list accounts.  It has no write access.

You can use the AWS CloudFormation to enable AWS Organizations.

### Using AWS CloudFormation to create the IAM Role

Within your AWS Organizations management account you should create an AWS CloudFormation stack with the following name:

`puppet-organizations-initialization-stack`

Using the template of the URL:

`https://service-catalog-tools.s3.eu-west-2.amazonaws.com/puppet/latest/servicecatalog-puppet-org-master.template.yaml`

This stack will have an output named *PuppetOrgRoleForExpandsArn*.  Take a note of this Arn as you will need it in the
next step.

### Setting the Org IAM role ARN

Once you have created the IAM Role, you need to tell the framework which role you want to use.  You do this by creating
an AWS Systems Manager Parameter Store parameter named `/servicecatalog-puppet/org-iam-role-arn` in the *region* of the 
*account* where you will install puppet and use as your hub account.  You can do this via the console or via the cli.

<figure>
  {{< highlight shell >}}
aws ssm put-parameter --name /servicecatalog-puppet/org-iam-role-arn --type String --value <VALUE-FROM-STEP-ABOVE>  
  {{< / highlight >}}
</figure>