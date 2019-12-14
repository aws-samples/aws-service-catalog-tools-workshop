+++
title = "Single spokes"
chapter = false
weight = 20

+++

## What are we going to do?

You will need to bootstrap spoke accounts so you can share portfolios with them and provision products into them.

Bootstrapping a spoke account will create an AWS CloudFormation stack in it.  This stack will contain the PuppetRole 
which is needed by framework to perform actions in the spoke account.  

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

### Restricting spokes

The PuppetRole created by the framework has an *AdministratorAccess* IAM managed policy attached to it.  If you are not 
happy you can provide an IAM Boundary for the Puppet role.

This permission boundary you provide should permit the PuppetRole to interact with AWS Service Catalog to accept shares, 
manage portfolios and to add, provision and terminate products. In addition the role should allow the use of AWS SNS, 
AWS EventBridge, AWS OpsCenter if you are making use of those features.  

Providing your own permission boundary is recommend for experienced users only.

In order to use a permission boundary you will need to append the following to your commands:

{{< highlight bash >}}
--permission-boundary arn:aws:iam::aws:policy/AdministratorAccess
{{< / highlight >}}

There will be an example of this for each command in these how tos.

### Bootstrapping a spoke

You should export the credentials for the spoke account or set your profile so that AWS CLI commands 
will execute as a role in the spoke account.

Then you can run the following command: 

_Without a boundary_
{{< highlight bash >}}
servicecatalog-puppet bootstrap-spoke <ACCOUNT_ID_OF_YOUR_PUPPET>
{{< / highlight >}}


_With a boundary_
{{< highlight bash >}}
servicecatalog-puppet bootstrap-spoke <ACCOUNT_ID_OF_YOUR_PUPPET> --permission-boundary arn:aws:iam::aws:policy/AdministratorAccess
{{< / highlight >}}

Ensure you replace *&lt;ACCOUNT_ID_OF_YOUR_PUPPET&gt;* with the account id of the account you will be using as your 
puppet account.  


### Bootstrapping a spoke as

If you want to assume a role into the spoke from your currently active role you can use the following command:

_Without a boundary_
{{< highlight bash >}}
servicecatalog-puppet bootstrap-spoke-as <ACCOUNT_ID_OF_YOUR_PUPPET> <ARN_OF_ASSUMABLE_ROLE_IN_SPOKE>
{{< / highlight >}}


_With a boundary_
{{< highlight bash >}}
servicecatalog-puppet bootstrap-spoke-as <ACCOUNT_ID_OF_YOUR_PUPPET> <ARN_OF_ASSUMABLE_ROLE_IN_SPOKE> --permission-boundary arn:aws:iam::aws:policy/AdministratorAccess
{{< / highlight >}}

This will assume the role <ARN_OF_ASSUMABLE_ROLE_IN_SPOKE> before running boostrap-spoke.  This is useful if you do not 
want to perform the STS assume-role yourself. 

Ensure you replace *&lt;ACCOUNT_ID_OF_YOUR_PUPPET&gt;* with the account id of the account you will be using as your 
puppet account.  
