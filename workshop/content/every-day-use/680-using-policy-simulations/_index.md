+++
title = "Using policy simulations"
weight = 680
home_region = "eu-west-1"
+++
---

## What are we going to do?

With policy simulations, you tell the framework to interact with AWS IAM simulate_principal_policy or 
simulate_custom_policy.  Using policy simulations you can verify the configuration of your access management ensuring
IAM roles, users and groups have access to the resources you want them to and do not have permission to those actions for
which they should not have access to.

Using the framework you can run simulations in parallel across many regions of many accounts quickly and easily.

This tutorial will walk you through how to use the "{{% param title %}}" feature.

We will assume you have:
 
 - installed Service Catalog Puppet correctly
 - bootstrapped a spoke
 - created a manifest file
 - added an account to the manifest file
 
We are going to perform the following steps to "{{% param title %}}":

- Adding a principal policy simulation to your manifest file
- Adding a custom policy simulation to your manifest file

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Adding a principal policy simulation to your manifest file

Add the following snippet to your manifest file:

 <figure>
  {{< highlight yaml >}}
simulate-policies:
  explicitDeny-s3-createbucket-for-devops-in-prod:
    simulation_type: "principal"
    policy_source_arn: "arn:aws:iam::${AWS::AccountId}:role/DevOps"
    action_names:
      - "s3:CreateBucket"
    expected_decision: "explicitDeny"
    simulate_for:
      tags:
        - tag: "type:prod"
          regions: "default_region"
{{< / highlight >}}
 </figure>

You will most likely need to update the tag from role:all to whatever you are using in your environment.

#### What did we just do?

In each region of each account in your simulate_for you asked service catalog puppet to do the following:

- assume role into the region of the account
- using an AWS IAM client execute the simulate_principal_policy function using the parameters specified
- verify the EvalDecisionDetails returned was "explicitDeny"

If the EvalDecisionDetails was not "explicitDeny" a failure would occur, anything depending on the simulate policy would
not execute and if AWS OpsCentre support was enabled an OpsIssue would have been created.

### Recommendations 
- It is recommended to add principal simulate policies for critical scenarios in high risk environments.

### Extra notes 
- simulate-policies can be executed in any execution mode

### Going Further 
- The simulation_type can be "principal" or "custom".  These map on to https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/iam.html#IAM.Client.simulate_principal_policy and https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/iam.html#IAM.Client.simulate_custom_policy
- You can pass extra arguments into the either of the calls.  Any parameter in the docs specified as CamelCase should be written as snake_case - eg PermissionsBoundaryPolicyInputList should become permissions_boundary_policy_input_list
  

You have now successfully executed a principal policy simulation!
