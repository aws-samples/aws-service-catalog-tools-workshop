+++
title = "Install Factory Process"
weight = 200
home_region = "eu-west-1"
home_region_name = "Ireland"
+++

---


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

### Run the CodeBuild Project

The CloudFormation Stack has created an AWS CodeBuild project which when run will install Service Catalog Factory.

- Navigate to the CodeBuild Service
- Select the **servicecatalog-product-factory-initialiser** project and Start Build

{{< figure src="/how-tos/installation/start_factory_codebuild.png" height="150" width="900">}}

- Keep default settings and select Start Build again
- Once the build is complete, the build status will be 'Succeeded'


{{< figure src="/how-tos/installation/factory_codebuild_complete.png" height="400" width="900">}}

{{% notice note%}}
Service Catalog Factory is now installed in your AWS Account, let's verify the resources that have been deployed.
{{% /notice %}}
