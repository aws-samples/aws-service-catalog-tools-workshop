+++
title = "Service Catalog Factory"
chapter = false
weight = 20
home_region = 'eu-west-1'
home_region_name = 'Ireland'
+++



### Navigate to CloudFormation

- Select the CloudFormation Service.

{{< figure src="/how-tos/installation/select_cloudformation.png" height="450" width="900">}}

{{% notice warning %}}
Confirm that you are in the {{% param home_region %}} ({{% param home_region_name %}}) region.
{{% /notice %}}

### Create a new CloudFormation Stack

- Select 'Create Stack'

{{< figure src="/how-tos/installation/create_stack.png" height="300" width="900">}}

### Select the pre-configured CloudFormation Template
Service Catalog Factory can be installed via a pre-created CloudFormation template stored in S3 under the following URL:
> `https://service-catalog-tools.s3.eu-west-2.amazonaws.com/factory/latest/servicecatalog-factory-initialiser.template.yaml`

- Paste this URL under 'Amazon S3 URL': 
- Hit Next

{{< figure src="/how-tos/installation/specify_template.png" height="400" width="900">}}

### Specify Stack Details

- Specify the Stack details as follows:
    - **Stack Name:** `factory-initialization-stack`
    - **Enable Regions:** `{{% param home_region %}}`
- Hit Next

{{< figure src="/how-tos/installation/stack_details_factory.png" height="400" width="900">}}

### Create the Stack

- Leave Defaults for 'Configure Stack Options'
- Hit Next
- Acknowledge that the Stack will create an IAM Role
- Hit 'Create Stack'

{{< figure src="/how-tos/installation/acknowledge_create.png" height="250" width="900">}}

- You will now see the Stack Status as 'CREATE_IN_PROGRESS'

{{< figure src="/how-tos/installation/create_in_progress_factory.png" height="200" width="900">}}

- Wait for the Stack Status to go to CREATE_COMPLETE

{{< figure src="/how-tos/installation/create_complete_factory.png" height="200" width="900">}}

### What have we deployed?
The following AWS resources have just been deployed into your AWS Account:

#### CloudFormation Stacks
The CodeBuild job created 2 CloudFormation Stacks which in turn deployed the resources listed below:

> URL: https://{{% param home_region %}}.console.aws.amazon.com/cloudformation/home?region={{% param home_region %}}

{{< figure src="/how-tos/installation/factory_cloudformation.png" height="200" width="900">}}

#### Factory CodeCommit Repository
This respository holds the Service Catalog Factory YAML files which are used to configure AWS Service Catalog Portfolios and Products.

> URL: https://{{% param home_region %}}.console.aws.amazon.com/codesuite/codecommit/repositories?region={{% param home_region %}}

{{< figure src="/how-tos/installation/factory_codecommit.png" height="200" width="900">}}

#### Factory CodePipeline
This CodePipeline is triggered by updates to the CodeCommit Repository. When run, it will create the Service Catalog Portfolios and Products defined in the portfolio files. 

> URL: https://{{% param home_region %}}.console.aws.amazon.com/codesuite/codepipeline/pipelines?region={{% param home_region %}}

{{< figure src="/how-tos/installation/factory_codepipeline.png" height="200" width="900">}}

#### S3 Buckets
An S3 Bucket was created to store artifacts for Service Catalog factory.

> URL: https://s3.console.aws.amazon.com/s3/home?region={{% param home_region %}}

{{< figure src="/how-tos/installation/puppet_s3.png" height="200" width="900">}}
