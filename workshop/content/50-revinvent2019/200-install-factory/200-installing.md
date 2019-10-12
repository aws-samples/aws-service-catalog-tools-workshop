+++
title = "Install Factory Process"
weight = 200
+++

---


### Navigate to CloudFormation

- Select the CloudFormation Service.

{{< figure src="/select_cloudformation.png" height="300" width="900">}}

{{% notice tip %}}
Confirm you are in the eu-west-1 region.
{{% /notice %}}

### Create a new CloudFormation Stack

- Select 'Create Stack'

{{< figure src="/create_stack.png" height="300" width="900">}}

### Select the pre-configured CloudFormation Template
Service Catalog Puppet can be installed via a pre-created CloudFormation Template stored in S3 under the following URL:
> https://service-catalog-tools.s3.eu-west-2.amazonaws.com/factory/0.25.0/servicecatalog-factory-initialiser.template.yaml

- Paste this URL under 'Amazon S3 URL': 
- Hit Next

{{< figure src="/specify_template.png" height="400" width="900">}}

### Specify Stack Details

- Specify the Stack details as follows:
    - **Stack Name:** puppet-initialization-stack
    - **Enable Regions:** eu-west-1
    - **Version:** 0.25.0
- Hit Next

{{< figure src="/stack_details.png" height="400" width="900">}}

### Create the Stack

- Leave Defaults for 'Configure Stack Options'
- Hit Next
- Acknowledge that the Stack will create an IAM Role
- Hit 'Create Stack'

{{< figure src="/acknowledge_create.png" height="250" width="900">}}

- You will now see the Stack Status as 'CREATE_IN_PROGRESS'

{{< figure src="/create_in_progress_factory.png" height="250" width="900">}}

- Wait for the Stack Status to go to CREATE_COMPLETE

{{< figure src="/create_complete_factory.png" height="250" width="900">}}

