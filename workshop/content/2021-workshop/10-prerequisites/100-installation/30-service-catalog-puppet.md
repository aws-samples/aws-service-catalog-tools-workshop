+++
title = "Service Catalog Puppet"
chapter = false
weight = 30
home_region = 'eu-west-1'
home_region_name = 'Ireland'

+++


### Select the pre-configured AWS CloudFormation template
Service Catalog Puppet can be installed via a pre-created AWS CloudFormation template stored in Amazon S3. There are 
many configuration options for you to customise your installation.  For this workshop we will be using the following 
quick link which has the settings already preconfigured for you:

- <a target="_blank" href="https://eu-west-1.console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/quickcreate?templateUrl=https%3A%2F%2Fservice-catalog-tools.s3.eu-west-2.amazonaws.com%2Fpuppet%2Flatest%2Fservicecatalog-puppet-initialiser.template.yaml&stackName=puppet-initialization-stack&param_CloudFormationDeployRolePermissionsBoundary=arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAdministratorAccess&param_DeployEnvironmentComputeType=BUILD_GENERAL1_SMALL&param_DeployNumWorkers=10&param_EnabledRegions=eu-west-1&param_PuppetCodePipelineRolePermissionBoundary=arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAdministratorAccess&param_PuppetDeployRolePermissionBoundary=arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAdministratorAccess&param_PuppetGenerateRolePermissionBoundary=arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAdministratorAccess&param_PuppetProvisioningRolePermissionsBoundary=arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAdministratorAccess&param_PuppetRoleName=PuppetRole&param_PuppetRolePath=%2Fservicecatalog-puppet%2F&param_PuppetRolePermissionBoundary=arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAdministratorAccess&param_SCMBranchName=main&param_SCMBucketName=&param_SCMConnectionArn=&param_SCMFullRepositoryId=&param_SCMObjectKey=&param_SCMRepositoryName=ServiceCatalogPuppet&param_SCMShouldCreateRepo=true&param_SCMSourceProvider=CodeCommit&param_ShouldCollectCloudformationEvents=false&param_ShouldDeleteRollbackCompleteStacks=true&param_ShouldForwardEventsToEventbridge=false&param_ShouldForwardFailuresToOpscenter=true&param_ShouldUseStacksServiceRole=true&param_ShouldValidate=true&param_SourceRolePermissionsBoundary=arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAdministratorAccess&param_Version=aws-service-catalog-puppet">Create stack</a>
- Check the box labeled "I acknowledge that AWS CloudFormation might create IAM resources with custom names."
- Hit Create stack
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

{{% notice note%}}
The pipeline execution will show as failing at this point.  This is expected. 
{{% /notice %}}

#### Amazon S3 buckets
Three Amazon S3 buckets were created to store artifacts for Service Catalog Puppet.

> URL: https://s3.console.aws.amazon.com/s3/home?region={{% param home_region %}}

{{< figure src="/how-tos/installation/puppet_s3.png" height="200" width="900">}}
