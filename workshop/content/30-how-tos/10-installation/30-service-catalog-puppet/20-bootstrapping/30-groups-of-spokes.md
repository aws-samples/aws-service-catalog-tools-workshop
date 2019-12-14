+++
title = "Groups of spokes"
chapter = false
weight = 30

+++

## What are we going to do?

If you have enabled AWS Organizations support you may want to bootstrap all spokes within an organizational unit.

Following these steps will allow you to bootstrap all accounts that exist within the same organizational unit.

### Using the CodeBuild Project

In your account you can find an AWS CodeBuild project named: servicecatalog-puppet-bootstrap-an-ou

- Click start build

- Before you select start build again, expand the _Environment variables override_ section. 

- Set OU_OR_PATH to the OU path or organizational unit id that contains all of the spokes you want to bootstrap

- Set IAM_ROLE_NAME to the name of the IAM Role that is assumable in the spoke accounts - this must be the same name in all accounts

- Set IAM_ROLE_ARNS to the ARNs you want to assume before assuming before the IAM_ROLE_NAME.  This is should you need to assume a role with cross account permissions.

- Click start build again

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

#### Bootstrapping spokes in ou

You should export the credentials for the account that allows you to list accounts in the org and assume a role in each 
of the spokes.

Then you can run the following command: 

_Without a boundary_
{{< highlight bash >}}
servicecatalog-puppet bootstrap-spokes-in-ou /dev DevOpsAdminRole
{{< / highlight >}}

In this example /dev is the ou path and DevOpsAdminRole is the name of the assumable role in each spoke account. 

_With a boundary_
{{< highlight bash >}}
servicecatalog-puppet bootstrap-spokes-in-ou /dev DevOpsAdminRole --permission-boundary arn:aws:iam::aws:policy/AdministratorAccess
{{< / highlight >}}


If your current role does not allow you to list accounts in the org or allow you to assume role cross account you can 
specify an ARN of a role that does. When you do so the framework will assume that role first and then perform the 
bootstrapping.

{{< highlight bash >}}
servicecatalog-puppet bootstrap-spokes-in-ou /dev DevOpsAdminRole arn:aws:iam::0123456789010:role/OrgRoleThatAllowsListAndAssumeRole
{{< / highlight >}}