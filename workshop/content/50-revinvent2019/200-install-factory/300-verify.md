+++
title = "Verify Factory Installation"
weight = 300
+++

---

### What have we deployed?
The following AWS Resources have just been deployed into your AWS Account:

#### CloudFormation Stacks
The CodeBuild job created 2 CloudFormation Stacks which in turn deployed the Resources listed below

> URL: https://eu-west-1.console.aws.amazon.com/cloudformation/home?region=eu-west-1

{{< figure src="/factory_cloudformation.png" height="200" width="900">}}

#### Factory CodeCommit Repository
This respository holds the Service Catalog Factory YAML files which are used to configure the portfolios and products.

> URL: https://eu-west-1.console.aws.amazon.com/codesuite/codecommit/repositories?region=eu-west-1

{{< figure src="/factory_codecommit.png" height="200" width="900">}}

#### Factory CodePipeline
This CodePipeline is triggered by updates to the CodeCommit Repository. When run, it will create the Service Catalog Portfolios and Products defined in the portfolio files. 

> URL: https://eu-west-1.console.aws.amazon.com/codesuite/codepipeline/pipelines?region=eu-west-1

{{< figure src="/factory_codepipeline.png" height="200" width="900">}}

#### S3 Buckets
3 S3 Buckets were created to store artefacts for Service Catalog and Factory.

> URL: https://s3.console.aws.amazon.com/s3/home?region=eu-west-1

{{< figure src="/factory_s3.png" height="200" width="900">}}

{{% notice note%}}
If everything was deployed correctly, proceed to **'Install Puppet'**. If not, don't worry, speak to one of the Workshop Team and we can help.
{{% /notice %}}