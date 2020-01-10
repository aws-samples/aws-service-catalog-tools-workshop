+++
title = "Using AWS Organizations"
chapter = false
weight = 10
home_region = 'eu-west-1'
home_region_name = 'Ireland'

+++

You can use Service Catalog Puppet with AWS Organizations.  Using it will allow you describe all accounts within an 
organizational unit as a single entity.  This provides a quicker way to get started and an easier way of managing 
multiple account environments.

If you do not want to use Organizations please skip to the next section of this how to.

## What are we going to do?

When enabling AWS Organizations you will need to provision an IAM Role in the Organizations master account and you will 
then need to provide the ARN of that role to your puppet account as an AWS SSM parameter.  

The role provisioned in the Organizations master account is only used to list accounts.  It has no write access.

You can use the CLI to enable AWS Organizations.

### Using the CLI

The following steps should be executed using the Service Catalog Puppet CLI which is an application built using Python 3.

If you have not already installed the framework you can do so by following these steps:

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

### Creating the PuppetOrgRoleForExpands IAM Role

You should export the credentials for your organizations master account or set your profile so that AWS CLI commands 
will execute as a role in your organization master account.

Then you can run the following command: 

{{< highlight bash >}}
servicecatalog-puppet bootstrap-org-master <ACCOUNT_ID_OF_YOUR_PUPPET>
{{< / highlight >}}

Ensure you replace *&lt;ACCOUNT_ID_OF_YOUR_PUPPET&gt;* with the account id of the account you will be using as your 
puppet account.  Please note you can have multiple puppet accounts in your organization.

Running this command will return an ARN.  This ARN should be used when setting the Org IAM role ARN.

### Setting the Org IAM role ARN

You should export the credentials for your puppet account or set your profile so that AWS CLI commands will execute as a
role in your puppet account.

{{< highlight bash >}}
servicecatalog-puppet set-org-iam-role-arn <THE_ARN_YOU_WANT_TO_USE>
{{< / highlight >}}

Ensure you replace *&lt;THE_ARN_YOU_WANT_TO_USE&gt;* with the ARN returned when you created the *PuppetOrgRoleForExpands* 

