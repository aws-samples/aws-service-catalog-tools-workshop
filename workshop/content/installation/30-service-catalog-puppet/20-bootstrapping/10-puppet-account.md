+++
title = "Puppet account"
chapter = false
weight = 10
home_region = 'eu-west-1'
home_region_name = 'Ireland'

+++

### Navigate to CloudFormation

- Select the AWS CloudFormation service.

{{< figure src="/how-tos/installation/select_cloudformation.png" height="450" width="900">}}

{{% notice warning %}}
Confirm you are in the {{% param home_region %}} ({{% param home_region_name %}}) region.
{{% /notice %}}

### Create a new AWS CloudFormation stack

- Select 'Create Stack'

{{< figure src="/how-tos/installation/create_stack_puppet.png" height="200" width="900">}}

{{% notice note %}}
Note that the Factory Initialization Stack has been deployed. If yours has not refer to 'Install Factory Process'
{{% /notice %}}

### Select the pre-configured AWS CloudFormation template
Service Catalog Puppet can be installed via a pre-created AWS CloudFormation template stored in Amazon S3 under the following URL:
>  `https://service-catalog-tools.s3.eu-west-2.amazonaws.com/puppet/latest/servicecatalog-puppet-initialiser.template.yaml`


- Paste this URL under 'Amazon S3 URL': 
- Hit Next

{{< figure src="/how-tos/installation/specify_template_puppet.png" height="500" width="900">}}

### Specify AWS CloudFormation stack details

- Specify the AWS CloudFormation stack details as follows:
    - **Stack Name:** `puppet-initialization-stack`
    - **Enable Regions:** `{{% param home_region %}}`
    - **OrgIAMRoleArn:** `None` 
    - **ShouldCollectCloudformationEvents:** `false`
    - **ShouldForwardEventsToEventbridge:** `false`
    - **ShouldForwardFailuresToOpscenter:** `false`   
- Hit Next

{{< figure src="/how-tos/installation/specify_stack_details_puppet.png" height="600" width="900">}}

### Create the AWS CloudFormation stack

- Leave Defaults for 'Configure Stack Options'
- Hit Next
- Acknowledge that the Stack will create an IAM Role
- Hit 'Create Stack'

{{< figure src="/how-tos/installation/acknowledge_create.png" height="200" width="900">}}

- You will now see the stack status as *CREATE_IN_PROGRESS*

{{< figure src="/how-tos/installation/create_in_progress_puppet.png" height="200" width="900">}}

- Wait for the stack status to go to *CREATE_COMPLETE*

{{< figure src="/how-tos/installation/create_complete_puppet.png" height="200" width="900">}}

### What have we deployed?
The following AWS resources have just been deployed into your AWS Account:

#### AWS CloudFormation stacks
The AWS CodeBuild job created two AWS CloudFormation stacks which in turn deployed the resources listed below

> URL: https://{{% param home_region %}}.console.aws.amazon.com/cloudformation/home?region={{% param home_region %}}

{{< figure src="/how-tos/installation/puppet_cloudformation.png" height="200" width="900">}}

#### Puppet AWS CodeCommit repository
This respository holds the Service Catalog Puppet manifest YAML file which is used to configure provisioning and sharing.

> URL: https://{{% param home_region %}}.console.aws.amazon.com/codesuite/codecommit/repositories?region={{% param home_region %}}

{{< figure src="/how-tos/installation/puppet_codecommit.png" height="200" width="900">}}

#### Puppet AWS CodePipeline
This AWS CodePipeline is triggered by updates to the AWS CodeCommit repository. When run, it will create the Service Catalog portfolios and products defined in the portfolio files. 

> URL: https://{{% param home_region %}}.console.aws.amazon.com/codesuite/codepipeline/pipelines?region={{% param home_region %}}

{{< figure src="/how-tos/installation/puppet_codepipeline.png" height="200" width="900">}}

#### Amazon S3 buckets
Three Amazon S3 buckets were created to store artifacts for Service Catalog Puppet.

> URL: https://s3.console.aws.amazon.com/s3/home?region={{% param home_region %}}

{{< figure src="/how-tos/installation/puppet_s3.png" height="200" width="900">}}
