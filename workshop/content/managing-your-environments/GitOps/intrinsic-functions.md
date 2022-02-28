+++
title = "Intrinsic functions"
weight = 110
home_region = "eu-west-1"
aliases = [
    "/every-day-use/900-multi-org-usage.html",
]
+++
---

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
