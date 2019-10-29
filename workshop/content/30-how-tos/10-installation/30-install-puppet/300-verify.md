+++
title = "Verify Puppet Installation"
weight = 300
home_region = "eu-west-1"
+++

---

### What have we deployed?
The following AWS resources have just been deployed into your AWS Account:

#### CloudFormation Stacks
The CodeBuild job created 2 CloudFormation Stacks which in turn deployed the resources listed below

> URL: https://{{% param home_region %}}.console.aws.amazon.com/cloudformation/home?region={{% param home_region %}}

{{< figure src="/how-tos/installation/puppet_cloudformation.png" height="200" width="900">}}

#### Puppet CodeCommit Repository
This respository holds the Service Catalog Puppet manifest YAML file which is used to configure provisioning and sharing.

> URL: https://{{% param home_region %}}.console.aws.amazon.com/codesuite/codecommit/repositories?region={{% param home_region %}}

{{< figure src="/how-tos/installation/puppet_codecommit.png" height="200" width="900">}}

#### Puppet CodePipeline
This CodePipeline is triggered by updates to the CodeCommit Repository. When run, it will create the Service Catalog Portfolios and Products defined in the portfolio files. 

> URL: https://{{% param home_region %}}.console.aws.amazon.com/codesuite/codepipeline/pipelines?region={{% param home_region %}}

{{< figure src="/how-tos/installation/puppet_codepipeline.png" height="200" width="900">}}

#### S3 Buckets
Three S3 Buckets were created to store artifacts for Service Catalog Puppet.

> URL: https://s3.console.aws.amazon.com/s3/home?region={{% param home_region %}}

{{< figure src="/how-tos/installation/puppet_s3.png" height="200" width="900">}}

