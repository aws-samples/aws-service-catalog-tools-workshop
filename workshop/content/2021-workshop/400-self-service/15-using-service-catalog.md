+++
title = "Using AWS Service Catalog"
weight = 15

home_region = "eu-west-1"
codecommit_repo_name = "subnet" 
codecommit_repo_branch = "main" 
product_name = "subnet"
product_version = "v1"
portfolio_name = "networking-mandatory"

+++
---


## What are we going to do?

We are going to perform the following steps:

- Create a portfolio for sharing products
- Share the portfolio networking-optional into a spoke account


## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Create a portfolio for sharing products

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}}  

- Click on portfolios, then networking.yaml and click "Edit".

- Append the following snippet into the portfolios section whilst updating the role name to the one you are using in the associations section:
 
  <figure>
   {{< highlight js >}}
  - DisplayName: "Optional"
    Description: "Portfolio containing the optional networking components"
    ProviderName: "cloud-engineering"
    Associations:
      - "arn:aws:iam::${AWS::AccountId}:role/<INSERT YOUR ROLE NAME HERE>"
    Tags:
      - Key: "type"
        Value: "governance"
      - Key: "creator"
        Value: "cloud-engineering"
      - Key: "cost-center"
        Value: "governance"
   {{< / highlight >}}
  </figure>

- Add the portfolio of `- "optional"` to the portfolios list for subnet product.


- The file should look like the following:
 

  <figure>
   {{< highlight js >}}
Schema: factory-2019-04-01
Products:
  - Name: "subnet"
    Owner: "networking@example.com"
    Description: "subnet for networking"
    Distributor: "networking team"
    SupportDescription: "Speak to networking@example.com about exceptions and speak to cloud-engineering@example.com about implementation issues"
    SupportEmail: "cloud-engineering@example.com"
    SupportUrl: "https://wiki.example.com/cloud-engineering/networking/subnet"
    Tags:
      - Key: "type"
        Value: "governance"
      - Key: "creator"
        Value: "cloud-engineering"
      - Key: "cost-center"
        Value: "governance"
    Versions:
      - Name: "v1"
        Description: "v1 of subnet"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "subnet"
            BranchName: "main"
    Portfolios:
      - "mandatory"
      - "optional"
Portfolios:
  - DisplayName: "mandatory"
    Description: "Portfolio containing the mandatory networking components"
    ProviderName: "cloud-engineering"
    Associations:
      - "arn:aws:iam::${AWS::AccountId}:role/<INSERT YOUR ROLE NAME HERE>"
    Tags:
      - Key: "type"
        Value: "governance"
      - Key: "creator"
        Value: "cloud-engineering"
      - Key: "cost-center"
        Value: "governance"
  - DisplayName: "Optional"
    Description: "Portfolio containing the optional networking components"
    ProviderName: "cloud-engineering"
    Associations:
      - "arn:aws:iam::${AWS::AccountId}:role/<INSERT YOUR ROLE NAME HERE>"
    Tags:
      - Key: "type"
        Value: "governance"
      - Key: "creator"
        Value: "cloud-engineering"
      - Key: "cost-center"
        Value: "governance"

{{< / highlight >}}
  </figure>


- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}



- Click the *Commit changes* button:

{{< figure src="/tasks/CommitChanges.png" >}}


#### What did we just do?

The YAML file we created in the CodeCommit repository told the framework to create a new portfolio and to add the subnet 
product to that new portfolio.

#### Verify the change worked

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run. If you were very 
quick in making the change, the pipeline may still be running.  If it has not yet started feel free to the hit the 
*Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulFactoryRun.png" >}}


#### Verify the product was added to the portfolio


Now that you have verified the pipeline has run you can go to {{% service_catalog_portfolios_list_link %}} to view your
portfolio.

- Click on *networking-optional*

{{< figure src="/tasks/PortfolioReinventCloudEngineeringGovernance.png" >}}

- Click on the product *_{{% param product_name %}}_*

- Click on the version *_{{% param product_version %}}_*

{{< figure src="/tasks/ClickAwsConfigS3BucketServerSideEncryptionEnabledV1.png" >}}



### Share the portfolio networking-optional into a spoke account
 
- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}} again

- Click on *manifest.yaml*

- Click *Edit*

- Append the following snippet to the end of the main input field:

  <figure>
   {{< highlight js >}}
spoke-local-portfolios:
  networking-optional:
    portfolio: "networking-optional"
    product_generation_method: copy
    depends_on:
      - name: vpc
        type: stack
        affinity: stack
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
   {{< / highlight >}}
  </figure>


- The main input field should look like this (remember to set your account_id):

 <figure>
  {{< highlight js >}}

accounts:
  - account_id: "<YOUR_ACCOUNT_ID_WITHOUT_HYPHENS>"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
    tags:
      - "type:prod"
      - "partition:eu"
stacks:
  delete-default-networking-function:
    name: "delete-default-networking-function"
    version: "v1"
    capabilities:
      - CAPABILITY_NAMED_IAM
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
  vpc:
    name: "vpc"
    version: "v1"
    depends_on:
      - name: "delete-default-networking" 
        type: "lambda-invocation"
        affinity: "lambda-invocation"
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
    outputs:
      ssm: 
        - param_name: "/networking/vpc/account-parameters/${AWS::AccountId}/${AWS::Region}/VPCId"
          stack_output: VPCId
      
lambda-invocations:
  delete-default-networking:
    function_name: DeleteDefaultNetworking
    qualifier: $LATEST
    invocation_type: Event
    depends_on:
      - name: "delete-default-networking-function"
        type: "stack"
        affinity: "stack"
    invoke_for:
      tags:
        - regions: "default_region"
          tag: "type:prod"

assertions:
  assert-no-default-vpcs:
    expected:
      source: manifest
      config:
        value:
          - ""
    actual:
      source: boto3
      config:
        client: 'ec2'
        call: describe_vpcs
        arguments: {}
        use_paginator: true
        filter: Vpcs[?IsDefault==`true`].State
    depends_on:
      - name: "delete-default-networking"
        type: "lambda-invocation"
        affinity: "lambda-invocation"
    assert_for:
      tags:
        - regions: regions_enabled
          tag: type:prod

launches:
  subnet:
    portfolio: "networking-mandatory"
    product: "subnet"
    version: "v1"
    depends_on:
      - name: vpc
        type: stack
        affinity: stack
    parameters:
      VPCID:
        ssm: 
          name: "/networking/vpc/account-parameters/${AWS::AccountId}/${AWS::Region}/VPCId"
      SubnetCIDR:
        default: '10.0.0.0/24'
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"

workspaces:
  subnet:
    name: "subnet"
    version: "v1"
    depends_on:
      - name: vpc
        type: stack
        affinity: stack
    parameters:
      VPCID:
        ssm: 
          name: "/networking/vpc/account-parameters/${AWS::AccountId}/${AWS::Region}/VPCId"
      SubnetCIDR:
        default: '10.0.1.0/24'
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"

spoke-local-portfolios:
  networking-optional:
    portfolio: "networking-optional"
    product_generation_method: copy
    depends_on:
      - name: vpc
        type: stack
        affinity: stack
    deploy_to:
      tags:
        - tag: "type:prod"
          regions: "default_region"
 {{< / highlight >}}
 </figure>


#### Committing the manifest file


- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/tasks/CommitChanges.png" >}}


#### What did we just do?

The changes we made told the framework to make a portfolio in the default region of each spoke with the tag type:prod.
This portfolio will contain copies of the products that exist in the hub account.


#### Verifying the portfolio share

Once you have made your changes the {{% service_catalog_puppet_pipeline_link %}} should have run. If you were quick in 
making the change, the pipeline may still be running.  If it has not yet started feel free to the hit the 
*Release change* button.

As this workshop has been designed to run in a single region of a single account you cannot verify this step.  If the
pipeline ran and each stage has succeeded the share should have taken place.  When sharing a portfolio with the same
account it was created in the framework does not perform any actions.