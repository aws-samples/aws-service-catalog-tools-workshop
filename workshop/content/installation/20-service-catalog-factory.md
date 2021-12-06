+++
title = "Service Catalog Factory"
chapter = false
weight = 20
home_region = 'eu-west-1'
home_region_name = 'Ireland'
aliases = [
    "/30-how-tos/10-installation/20-service-catalog-factory.html",
    "/installation/20-service-catalog-factory.html"
]
+++

## Create a new AWS CloudFormation stack

- Select the AWS CloudFormation Service.

{{< figure src="/how-tos/installation/select_cloudformation.png" height="450" width="900">}}

{{% notice warning %}}
If you are installing Service Catalog Puppet it will need to be installed into the same account as Service Catalog Factory.
{{% /notice %}}

- Select 'Create Stack'

Service Catalog Factory can be installed via a pre-created AWS CloudFormation template stored in Amazon S3 under the following URL:
> `https://service-catalog-tools.s3.eu-west-2.amazonaws.com/factory/latest/servicecatalog-factory-initialiser.template.yaml`

- Paste this URL under 'Amazon S3 URL': 
- Hit Next

### Specify Stack details

- Specify the Stack details as follows:
    - **Stack Name:** `factory-initialization-stack`

You should fill in the details depending on which source code management system you want to use:

#### CodeCommit

You need to set **SCMSourceProvider** to **CodeCommit**.

You should also set the following:

- SCMRepositoryName - this is the name of the git repo to use
- SCMBranchName - this is the branch you want to use
- SCMShouldCreateRepo - set this to true if you want the tools to create the repo for you


#### Github.com / Github Enterprise / Bitbucket Cloud

You should have a read through the following guide: https://docs.aws.amazon.com/dtconsole/latest/userguide/connections.html

You need to set **SCMSourceProvider** to **CodeStarSourceConnection**.

You should also set the following:

- SCMConnectionArn - this is the Arn of the connection you created in the console
- SCMFullRepositoryId - the value for this is dependant on which SCM you use
- SCMBranchName - this is the branch you want to use


#### S3

You need to set **SCMSourceProvider** to **S3**.

You should also set the following:

- SCMBucketName - this is the name of the S3 bucket you want to use
- SCMObjectKey - this is the name of the object key you will be uploading your zip file as to trigger pipeline runs
- SCMShouldCreateRepo - set this to true if you want the tools to create the repo for you

### Configure Stack Options

- Set the common tags you want to use for the resources created by the framework.  These may be cost management tags or RBAC/ABAC required tags.
- Hit Next
- Acknowledge that the Stack will create an IAM Role
- Hit 'Create Stack'

{{< figure src="/how-tos/installation/acknowledge_create.png" height="250" width="900">}}

- You will now see the stack status as *CREATE_IN_PROGRESS*

{{< figure src="/how-tos/installation/create_in_progress_factory.png" height="200" width="900">}}

- Wait for the stack status to go to *CREATE_COMPLETE*

{{< figure src="/how-tos/installation/create_complete_factory.png" height="200" width="900">}}

### What have we deployed?
The following AWS resources have just been deployed into your AWS Account:

#### AWS CloudFormation stacks
The AWS CodeBuild job created two AWS CloudFormation stacks which in turn deployed the resources listed below:

> URL: https://{{% param home_region %}}.console.aws.amazon.com/cloudformation/home?region={{% param home_region %}}

{{< figure src="/how-tos/installation/factory_cloudformation.png" height="200" width="900">}}

#### Factory AWS CodeCommit repository
This repository holds the Service Catalog Factory YAML files which are used to configure AWS Service Catalog portfolios and products.

> URL: https://{{% param home_region %}}.console.aws.amazon.com/codesuite/codecommit/repositories?region={{% param home_region %}}

{{< figure src="/how-tos/installation/factory_codecommit.png" height="200" width="900">}}

#### Factory AWS CodePipeline
This AWS CodePipeline is triggered by updates to the AWS CodeCommit repository. When run, it will create the AWS Service Catalog portfolios and products defined in the portfolio files. 

> URL: https://{{% param home_region %}}.console.aws.amazon.com/codesuite/codepipeline/pipelines?region={{% param home_region %}}

{{< figure src="/how-tos/installation/factory_codepipeline.png" height="200" width="900">}}

#### Amazon S3 Buckets
An Amazon S3 Bucket was created to store artifacts for Service Catalog factory.

> URL: https://s3.console.aws.amazon.com/s3/home?region={{% param home_region %}}

{{< figure src="/how-tos/installation/puppet_s3.png" height="200" width="900">}}
