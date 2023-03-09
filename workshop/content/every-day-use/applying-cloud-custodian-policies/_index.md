+++
title = "Applying Cloud Custodian policies"
weight = 860
home_region = "eu-west-1"
+++
---

## What are we going to do?

Cloud Custodian enables you to manage your cloud resources by filtering, tagging, and then applying actions to them. The 
YAML DSL allows definition of rules to enable well-managed cloud infrastructure that's both secure and cost optimized.

This solution allows you to configure one or more of your accounts as Custodian accounts where Cloud Custodian will be
configured to execute.  The solution allows you to specify add the Cloud Custodian YAML DSL directly into your manifest
file(s) so you can provision resources, share portfolios, execute lambda functions, run tests and now deploy policies
governing your multiaccount environment.

### Cloudtrail mode 

Currently, you can configure policies to run in Cloudtrail mode.  To do so you must specify a custodian account id (where
Cloud Custodian will execute), some policies you want to execute and the accounts you would like to run the policies 
against.

To do this you must add a `c7n-aws-cloudtrails` section to the manifest file and specify the custodian, policies and 
apply_to configurations:


 <figure>
  {{< highlight yaml >}}
c7n-aws-cloudtrails:
  policies-for-132608235283:
    custodian: '132608235283'
    policies:
      - name: stop-all-ec2s
        resource: ec2
        mode:
          type: cloudtrail
          events:
            - RunInstances
        actions:
          - type: mark-for-op
            op: stop
    apply_to:
      tags:
        - tag: 'group:spokes'
          regions: "enabled_regions"
{{< / highlight >}}
 </figure>

#### What does this do?
For the accounts you specify as custodians an Amazon EventBridge EventBus will be provisioned in the default region with 
a bus policy allowing the accounts you are monitoring to put events - cross region and cross account.  For each region 
of each account you monitor an event rule will be provisioned, forwarding events to the custodian account using an IAM 
role provisioned in the account being monitored.

When you specify a policy, Cloud Custodian provisions a specific event rule based on the events you specified that 
trigger an AWS Lamdba function it created for that policy to perform the actions you specified.

#### Adding the policies
Whatever policies you would have written in Cloud Custodian can be pasted into the manifest file 'as is' - you do not
need to make any changes.  If you do not specify a mode: type: cloudtrail it will be added for you.  If you specify a 
mode: type: something-else it will be replaced with mode: type: cloudtrail.  You should not specify a mode: member-role attribute, one 
will be added for you and any you add will be overriden.

#### Customising the permissions and the roles used

You can customise the name of the role, the path and the managed policies attached to the role:

 <figure>
  {{< highlight yaml >}}
c7n-aws-cloudtrails:
  policies-for-132608235283:
    custodian: '132608235283'
    role_path: "/c7nc7n/"
    role_name: "C7NExecutor"
    role_managed_policy_arns:
      - arn:aws:iam::aws:policy/AnotherPolicy
    policies:
      - name: stop-all-ec2s
        resource: ec2
        mode:
          type: cloudtrail
          events:
            - RunInstances
        actions:
          - type: mark-for-op
            op: stop
    apply_to:
      tags:
        - tag: 'group:spokes'
          regions: "enabled_regions"
{{< / highlight >}}
 </figure>

#### Running in spoke execution mode
To reduce the overall execution time you can deploy Cloud Custodian in spoke execution mode by specifying `execution`:

 <figure>
  {{< highlight yaml >}}
c7n-aws-cloudtrails:
  policies-for-132608235283:
    execution: spoke
    custodian: '132608235283'
    policies:
      - name: stop-all-ec2s
        resource: ec2
        mode:
          type: cloudtrail
          events:
            - RunInstances
        actions:
          - type: mark-for-op
            op: stop
    apply_to:
      tags:
        - tag: 'group:spokes'
          regions: "enabled_regions"
{{< / highlight >}}
 </figure>

