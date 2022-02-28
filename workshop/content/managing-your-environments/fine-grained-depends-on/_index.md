+++
title = "Fine grained depends_on"
weight = 150
aliases = [
    "/design-considerations/fine-grained-depends-on.html",
]
+++
---

## What are we going to do?

This article will explain how the depends_on clause works within service catalog puppet and how fine tune its use to 
achieve better saturation of workers as well reducing the impact of failures when managing your multi account. 


## What is depends_on?

Within service catalog puppet you can provision AWS Service Catalog products, share Service Catalog portfolios, execute
AWS Lambda functions, run AWS CodeBuild projects and run assertions to verify the effects of your configurations.

When configuring service catalog puppet you may want to specify the order in which these things happen.  For example,
when building out your networking capability, you may want to provision a Service Catalog product containing a lambda 
function that can remove any default networking resources in your AWS account (default VPC, subnet, security group etc).  
Once you have provisioned that, you may want to execute it and then assert that the networking resources are removed 
before provisioning a new VPC and then Subnets.  Once all that provisioning is completed, you may then want to share a 
portfolio that allows users to provision an EKS cluster into the newly created networking stacks.

The basic building blocks for ordering these things is a depends_on clause which you can use in the following sections 
of the manifest file:

- launches
- spoke-local-portfolios
- lambda-executions
- code-build-runs
- assertions

Here is an example:

 <figure>
  {{< highlight yaml >}}
launches:
  networking:
    portfolio: "networking"
    product: "vpc"
    version: "v1"
    depends_on:
      - name: terminate-default-networking
        type: lambda-execution
    parameters:
      cidr:
        default: "10.0.0.1/24"
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
  {{< / highlight >}}
 </figure>

In this example before any provisioning occurs for the networking launch every lambda-executions for 
terminate-default-networking must have completed successfully across all regions of all accounts.  If any fail the
launch will not be scheduled.


## Fine tuning depends_on

When you configure service catalog puppet you are building a workflow that is executed by a set of workers.  You can 
configure the number of workers in the workflow and you can configure the shape and size of the workflow by modifying 
the manifest file.

When you use the default configuration of depends_on a natural choke point is created.  By saying B depends on A, you 
are saying everything within A must complete before B can begin.  You can reduce the impact of this by configuring the 
depends_on affinity value.

### Region

You can set the affinity to region: 

 <figure>
  {{< highlight yaml >}}
launches:
  networking:
    portfolio: "networking"
    product: "vpc"
    version: "v1"
    depends_on:
      - name: terminate-default-networking
        type: lambda-execution
        affinity: region
    parameters:
      cidr:
        default: "10.0.0.1/24"
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
  {{< / highlight >}}
 </figure>

In this example before any provisioning occurs for the networking launch in us-east-1 every lambda-executions for
terminate-default-networking in us-east-1 across all accounts must have completed successfully.  If any lambda-execution
for terminate-default-networking in any account in us-east-1 fails then no launches for networking in us-east-1 will be 
scheduled.

This is useful when you are building product sets that should be provisioned in hub and spoke accounts and rely on 
regional resources like networking.


### Account

You can set the affinity to account:

 <figure>
  {{< highlight yaml >}}
launches:
  networking:
    portfolio: "networking"
    product: "vpc"
    version: "v1"
    depends_on:
      - name: terminate-default-networking
        type: lambda-execution
        affinity: account
    parameters:
      cidr:
        default: "10.0.0.1/24"
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
  {{< / highlight >}}
 </figure>

In this example before any provisioning occurs for the networking launch in account 2 every lambda-executions for
terminate-default-networking in account 1 across all regions must have completed successfully.  If any lambda-execution
for terminate-default-networking in any region in account 1 fails then no launches for networking in account 2 will be 
scheduled.

This is useful when you are building product sets that should be provisioned in hub and spoke accounts and rely on
global resources like IAM.


### Account and region

You can set the affinity to account:

 <figure>
  {{< highlight yaml >}}
launches:
  networking:
    portfolio: "networking"
    product: "vpc"
    version: "v1"
    depends_on:
      - name: terminate-default-networking
        type: lambda-execution
        affinity: account-and-region
    parameters:
      cidr:
        default: "10.0.0.1/24"
    deploy_to:
      tags:
        - tag: "type:spoke"
          regions: "default_region"  
  {{< / highlight >}}
 </figure>

In this example before any provisioning occurs for the networking launch in us-east-1 of account 2 every lambda-executions for
terminate-default-networking in account 1 in us-east-1 must have completed successfully.  If any lambda-execution
for terminate-default-networking in us-east-1 in account 1 fails then no launches for networking in account 2 will be scheduled.

This is useful when you are building products sets that should be provisioned into accounts in order into multiple spoke 
accounts, for example VPCs, Subnets and NACLs.
