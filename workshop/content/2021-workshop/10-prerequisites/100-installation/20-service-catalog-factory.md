+++
title = "Service Catalog Factory"
chapter = false
weight = 20
home_region = 'eu-west-1'
home_region_name = 'Ireland'
+++

### Select the pre-configured CloudFormation Template

Service Catalog Factory can be installed via a pre-created AWS CloudFormation template stored in Amazon S3. There are 
many configuration options for you to customise your installation.  For this workshop we will be using the following 
quick link which has the settings already preconfigured for you:

- <a target="_blank" href="https://eu-west-1.console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/quickcreate?templateUrl=https%3A%2F%2Fservice-catalog-tools.s3.eu-west-2.amazonaws.com%2Ffactory%2Flatest%2Fservicecatalog-factory-initialiser.template.yaml&stackName=factory-initialization-stack&param_EnabledRegions=eu-west-1&param_SCMBranchName=main&param_SCMBucketName=&param_SCMConnectionArn=&param_SCMFullRepositoryId=&param_SCMObjectKey=&param_SCMRepositoryName=ServiceCatalogFactory&param_SCMShouldCreateRepo=true&param_SCMSourceProvider=CodeCommit&param_ShouldValidate=true&param_Version=aws-service-catalog-factory">Create the initialisation stack</a>
- Check the box labeled "I acknowledge that AWS CloudFormation might create IAM resources with custom names."
- Hit Create stack
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

{{% notice note%}}
The pipeline execution will show as failing at this point.  This is expected. 
{{% /notice %}}

#### Amazon S3 Buckets
An Amazon S3 Bucket was created to store artifacts for Service Catalog factory.

> URL: https://s3.console.aws.amazon.com/s3/home?region={{% param home_region %}}

{{< figure src="/how-tos/installation/puppet_s3.png" height="200" width="900">}}
