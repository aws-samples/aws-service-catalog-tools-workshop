+++
title = "Conditions"
weight = 120
home_region = "eu-west-1"
aliases = [
    "/every-day-use/900-multi-org-usage.html",
]
+++
---

### Conditions

You can create conditions within your manifest file.  These conditions work just like the AWS CloudFormation conditions
and can be used to decide whether actions occur or not:

  <figure>
   {{< highlight js >}}
conditions:
  IsDev: !Equals
    - 156551640785
    - ${AWS::PuppetAccountId}
  IsProd: !Not
    - !Equals
      - 156551640785
      - ${AWS::PuppetAccountId}
{{< / highlight >}}
  </figure>

At the moment you can use Equals and Not functions to create conditions.  Then you can specify conditions for your
stacks and other actions:

  <figure>
   {{< highlight js >}}
stacks:
  amazon-guardduty-multi-account-prereqs-orgs-account:
    condition: IsDev
    name: amazon-guardduty-multi-account-prereqs-orgs-account
    version: v1
    execution: hub
    capabilities:
      - CAPABILITY_NAMED_IAM
    deploy_to:
      tags:
        - tag: 'role:org_management'
          regions: default_region
    outputs:
      ssm:
        - param_name: "/foundational/GuardDutyMultiAccount/GuardDutyMultiAccountDelegateAdminRoleArn"
          stack_output: GuardDutyMultiAccountDelegateAdminRoleArn
{{< / highlight >}}
  </figure>

When you use conditions you are responsible for ensuring that all actions referenced within the depends_on have the same
conditions.
