+++
title = "Install Puppet Process"
weight = 200
+++
---


### Navigate to CloudFormation

- Select the CloudFormation Service.

{{< figure src="/select_cloudformation.png" height="275" width="800">}}

{{% notice tip %}}
Confirm you are in the eu-west-1 region.
{{% /notice %}}

### Create a new CloudFormation Stack

- Select 'Create Stack'

{{< figure src="/create_stack.png" height="275" width="800">}}

### Select the pre-configured CloudFormation Template
Service Catalog Puppet can be installed via a pre-created CloudFormation Template stored in S3 under the following URL:
> https://service-catalog-tools.s3.eu-west-2.amazonaws.com/puppet/0.37.2/servicecatalog-puppet-initialiser.template.yaml

- Paste this URL under 'Amazon S3 URL': 
- Hit Next

{{< figure src="/specify_template.png" height="400" width="900">}}

### Specify Stack Details

- Specify the Stack details as follows:
    - **Stack Name:** sc-puppet-install
    - **Enable Regions:** eu-west-1,eu-west-2
    - **Version:** 0.25.0
- Hit Next

{{< figure src="/stack_details.png" height="400" width="900">}}

### Create the Stack

- Leave Defaults for 'Configure Stack Options'
- Hit Next
- Acknowledge that the Stack will create an IAM Role
- Hit 'Create Stack'

{{< figure src="/confirm_create_stack.png" height="250" width="900">}}