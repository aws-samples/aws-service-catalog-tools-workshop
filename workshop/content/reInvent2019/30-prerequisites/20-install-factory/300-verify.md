+++
title = "Verify Factory Installation"
weight = 300
home_region = "eu-west-1"
+++

---

### What have we deployed?
The following AWS resources have just been deployed into your AWS Account:

#### CloudFormation Stacks
The CodeBuild job created 2 CloudFormation Stacks which in turn deployed the resources listed below:

> URL: https://{{% param home_region %}}.console.aws.amazon.com/cloudformation/home?region={{% param home_region %}}

{{< figure src="/factory_cloudformation.png" height="200" width="900">}}

#### Factory CodeCommit Repository
This respository holds the Service Catalog Factory YAML files which are used to configure AWS Service Catalog Portfolios and Products.

> URL: https://{{% param home_region %}}.console.aws.amazon.com/codesuite/codecommit/repositories?region={{% param home_region %}}

{{< figure src="/factory_codecommit.png" height="200" width="900">}}

#### Factory CodePipeline
This CodePipeline is triggered by updates to the CodeCommit Repository. When run, it will create the Service Catalog Portfolios and Products defined in the portfolio files. 

> URL: https://{{% param home_region %}}.console.aws.amazon.com/codesuite/codepipeline/pipelines?region={{% param home_region %}}

{{< figure src="/factory_codepipeline.png" height="200" width="900">}}

#### S3 Buckets
An S3 Bucket was created to store artifacts for Service Catalog factory.

> URL: https://s3.console.aws.amazon.com/s3/home?region={{% param home_region %}}

{{< figure src="/puppet_s3.png" height="200" width="900">}}

{{% notice note%}}
If everything was deployed correctly, proceed to **'Install Puppet'**. If not, don't worry, speak to one of the AWS helpers and we can help.
{{% /notice %}}
