+++
title = "Multi Organization usage"
weight = 900
home_region = "eu-west-1"
+++
---

## What support is there for multiple AWS Organizations?

When writing your manifest you can specify accounts or ou within the accounts section.  Accounts can belong to any
AWS Organization and the solution will manage sharing on your behalf so long as you have bootstrapped the spoke
correctly.  Currently, spokes can only easily be bootstrapped for one AWS Organization at a time.  The OUs you specify
in the manifest file have to exist within the same AWS Organization where you have installed this solution.

When you configure your installations of this solution you specify the git source where your manifest file resides.  You
can choose to have a single git repo for many installs of this solution.  You can then use a branch for each install
or you could use intrinsic functions and conditions within your manifest file to manage variance between the different
installs.

If the configuration between your installs is significant we recommend using differnet git repositories or different
branches for each install.  If there is minimal different then you can use intrinsic functions, conditions and manifest
properties to reduce the duplicated configuration.

## Intrinsic Functions

There is a built in intrinsic function ${AWS::PuppetAccountId} that you can use anywhere within your manifest file.  
When your manifest file being expanded the string ${AWS::PuppetAccountId} will be replace with the value of the account 
id.  This allows you avoid hard coding the account id of the hub account.

  <figure>
   {{< highlight js >}}
accounts:
  - account_id: "${AWS::PuppetAccountId}"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
      - "eu-west-2"
    tags:
      - "type:prod"
      - "partition:eu"
   {{< / highlight >}}
  </figure>

You can specify your own functions within a file named intrinsic-functions.properties within the root of your 
ServiceCatalogPuppet repository.  Within this you can specify name value pairs:


  <figure>
   {{< highlight ini >}}
SecurityToolingAccountId=012345678910
   {{< / highlight >}}
    </figure>

You can then use these within your manifest file anywhere using ${Custom::<THE_NAME_YOU_SPECIFIED>}:

  <figure>
   {{< highlight js >}}
accounts:
  - account_id: "${Custom::SecurityToolingAccountId}"
    name: "puppet-account"
    default_region: "eu-west-1"
    regions_enabled:
      - "eu-west-1"
      - "eu-west-2"
    tags:
      - "type:prod"
      - "partition:eu"
   {{< / highlight >}}
  </figure>

To improve readability we recommend you use the functions to set global parameters and use YAML alias and anchors to 
reduce the size and complexity of your expanded manifest file by removing duplication.

If you want to specify different values for different installs you can override values in an 
intrinsic-functions-0123456789010.properties file.  In this example when the manifest file is expanded in account
0123456789010 any values in intrinsic-functions-0123456789010.properties will override values set in the 
intrinsic-functions.properties file.

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

### Manifest properties

If you are using puppet to manage multiple environments you may find it easier to keep the versions of your launches in 
properties files instead of the manifest.yaml files. To do this you create a file named manifest.properties in the same 
directory as your manifest.yaml file. Within this file you can specify the following:

  <figure>
   {{< highlight ini >}}
[launches]
IAM-1.version = v50
{{< / highlight >}}
    </figure>

This will set the version for the launch with the name IAM-1 to v50.

Please note this will overwrite the values specified in the manifest.yaml files with no warning.

If you are using multiple instances of puppet you can also create a file named manifest-<puppet-account-id>.properties. 
Values in this file will overwrite all other values making the order of reading:

1. manifest.yaml 
2. other manifest files (eg in manifests/) 
3. manifest.properties 
4. manifest-<<puppet-account-id>>.properties