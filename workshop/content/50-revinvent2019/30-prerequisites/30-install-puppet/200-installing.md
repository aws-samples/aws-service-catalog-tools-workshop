+++
title = "Install Puppet Process"
weight = 200
+++

---


### Navigate to CloudFormation

- Select the CloudFormation Service.

{{< figure src="/select_cloudformation.png" height="450" width="900">}}

{{% notice warning %}}
Confirm you are in the eu-west-1 region.
{{% /notice %}}

### Create a new CloudFormation Stack

- Select 'Create Stack'

{{< figure src="/create_stack_puppet.png" height="200" width="900">}}

{{% notice note %}}
Note that the Factory Initialization Stack has been deployed. If yours has not refer to 'Install Factory Process'
{{% /notice %}}

### Select the pre-configured CloudFormation Template
Service Catalog Puppet can be installed via a pre-created CloudFormation Template stored in S3 under the following URL:
>  `https://service-catalog-tools.s3.eu-west-2.amazonaws.com/puppet/latest/servicecatalog-puppet-initialiser.template.yaml`

- Paste this URL under 'Amazon S3 URL': 
- Hit Next

{{< figure src="/specify_template_puppet.png" height="500" width="900">}}

### Specify Stack Details

- Specify the Stack details as follows:
    - **Stack Name:** `puppet-initialization-stack`
    - **Enable Regions:** `eu-west-1`
    - **OrgIAMRoleArn:** `None` 
    - **ShouldCollectCloudformationEvents:** `false`
    - **ShouldForwardEventsToEventbridge:** `false`
    - **ShouldForwardFailuresToOpscenter:** `false`   
- Hit Next

{{< figure src="/specify_stack_details_puppet.png" height="600" width="900">}}

### Create the Stack

- Leave Defaults for 'Configure Stack Options'
- Hit Next
- Acknowledge that the Stack will create an IAM Role
- Hit 'Create Stack'

{{< figure src="/acknowledge_create.png" height="200" width="900">}}

- You will now see the Stack Status as 'CREATE_IN_PROGRESS'

{{< figure src="/create_in_progress_puppet.png" height="200" width="900">}}

- Wait for the Stack Status to go to CREATE_COMPLETE

{{< figure src="/create_complete_puppet.png" height="200" width="900">}}
