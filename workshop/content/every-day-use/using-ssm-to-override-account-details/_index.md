+++
title = "Using SSM to override account settings"
weight = 840
home_region = "eu-west-1"
+++
---

## What are we going to do?

When you specify an OU within the accounts section each account within the OU is configured in the exact same way. You
can already using AWS Organizations account tags to add tags to individual accounts and you can use override or append
to configure the regions_enabled and default_region.  If you have many accounts that have different default_region or
regions_enabled values it can be cumbersome to maintain this in the manifest file.  With this feature you can specify
default_region and regions_enabled values in SSM per account allowing you to configure this easily at account vending
time.



## Setting account level default_region or regions_enabled values
When defining an OU you must set the external_account_overrides correctly:

<figure>
{{< highlight yaml >}}
accounts:
  - ou: "/dev"
    name: "dev-accounts"
    external_account_overrides:
      default_region:
        source: ssm
      enabled_regions:
        source: ssm
    tags:
      - "type:dev"
{{< / highlight >}}
</figure>

Here we are saying we want default_region and enabled_regions values to come from SSM.

In SSM you must create parameters with the names:

- /servicecatalog-puppet/manifest-external-account-overrides/<account_id>/default_region 
- /servicecatalog-puppet/manifest-external-account-overrides/<account_id>/enabled_regions

where <account_id> is replaced with the 12 character AWS Account Id you want to override the default_region and 
enabled_regions for. 

If an account within the OU is not present within SSM you will get an error unless you set a value for fail_if_missing:

<figure>
{{< highlight yaml >}}
accounts:
  - ou: "/dev"
    name: "dev-accounts"
    external_account_overrides:
      default_region:
        fail_if_missing: false
        source: ssm
      enabled_regions:
        fail_if_missing: false
        source: ssm
    tags:
      - "type:dev"
{{< / highlight >}}
</figure>

