+++
title = "Applying Cloud Custodian policies"
weight = 860
home_region = "eu-west-1"
+++
---

## What are we going to do?

Cloud Custodian enables you to manage your cloud resources by filtering, tagging, and then applying actions to them. The 
YAML DSL allows definition of rules to enable well-managed cloud infrastructure that's both secure and cost optimized.

This solution automates the setup of a multi account Cloud Custodian installation allowing you to make use of the AWS 
Serverless services. This solution will set up the AWS EventBridge policies, event buses, event forwarding, cross account
roles, provisioning of the policy AWS Lambda Functions for real time monitoring and the periodic triggering needed for
delayed actions and retrospective monitoring.

### Modes

This solution allows you to write policies in any of the c7n supported modes.

#### Pull 
If you write pull based policies they will be run periodically within an AWS CodeBuild environment on a schedule of your
choosing.  AWS Lambda policies are provisioned within an AWS CodeBuild project run. If you would like to apply the
policies to multiple accounts you will need to specify a value for c7n_org_version in the config: 

 <figure>
  {{< highlight yaml >}}
c7n-aws-lambdas:
  policies-for-132608235283:
    custodian: '132608235283'
    c7n_org_version: "0.6.27"
    policies:
      - name: ebs-mark-unattached-deletion
        resource: ebs
        comments: |
          Mark any unattached EBS volumes for deletion in 30 days.
          Volumes set to not delete on instance termination do have
          valid use cases as data drives, but 99% of the time they
          appear to be just garbage creation.
        filters:
          - Attachments: [ ]
          - "tag:maid_status": absent
        actions:
          - type: mark-for-op
            op: delete
            days: 30
      - name: ebs-unmark-attached-deletion
        resource: ebs
        comments: |
          Unmark any attached EBS volumes that were scheduled for deletion
          if they are currently attached
        filters:
          - type: value
            key: "Attachments[0].Device"
            value: not-null
          - "tag:maid_status": not-null
        actions:
          - unmark
      - name: ebs-delete-marked
        resource: ebs
        comments: |
          Delete any attached EBS volumes that were scheduled for deletion
        filters:
          - type: marked-for-op
            op: delete
        actions:
          - delete
    apply_to:
      tags:
        - tag: 'group:spokes'
          regions: "enabled_regions"
{{< / highlight >}}
 </figure>


### Getting started
To get started you must add a `c7n-aws-lambdas` section to the manifest file and specify the custodian, policies and 
apply_to configurations. 

Here is an example cloudtrail policy:

 <figure>
  {{< highlight yaml >}}
c7n-aws-lambdas:
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

If you want to use delayed actions - for example terminate unused ebs volumes after 30 days then you will need to set a 
schedule_expression.  This will trigger the solution to run c7n as often as you have specified.  You can use AWS Amazon 
EventBridge cron or rate expressions when specifying the value.  You should choose a value that makes sense depending
on your requirements, for example if you wait 30 days before performing actions you could probably use a 24hr schedule
or if you want to be more aggressive with your cost savings or have stricter policies you can set the schedule to run
hourly.  We do not recommend running the schedule in such a way where run N is starting before run N-1 has finished.

Here is an example:

 <figure>
  {{< highlight yaml >}}
c7n-aws-lambdas:
  policies-for-132608235283:
    execution: hub
    custodian: '132608235283'
    schedule_expression: rate(1 day)
    role_path: "/c7nc7n/"
    role_name: "C7NExecutor"
    policies:
      - name: ebs-mark-unattached-deletion
        resource: ebs
        comments: |
          Mark any unattached EBS volumes for deletion in 30 days.
          Volumes set to not delete on instance termination do have
          valid use cases as data drives, but 99% of the time they
          appear to be just garbage creation.
        filters:
          - Attachments: [ ]
          - "tag:maid_status": absent
        actions:
          - type: mark-for-op
            op: delete
            days: 30
      - name: ebs-unmark-attached-deletion
        resource: ebs
        comments: |
          Unmark any attached EBS volumes that were scheduled for deletion
          if they are currently attached
        filters:
          - type: value
            key: "Attachments[0].Device"
            value: not-null
          - "tag:maid_status": not-null
        actions:
          - unmark
      - name: ebs-delete-marked
        resource: ebs
        comments: |
          Delete any attached EBS volumes that were scheduled for deletion
        filters:
          - type: marked-for-op
            op: delete
        actions:
          - delete
    apply_to:
      tags:
        - tag: 'group:hundred'
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
