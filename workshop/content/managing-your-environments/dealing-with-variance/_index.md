+++
title = "Dealing With Variance"
weight = 113
+++
---

## What are we going to do?
This article will help you to understand how you can deal with variance in your AWS Organization

## Why is this important
When defining your AWS accounts using this solution you can specify accounts one-by-one or you can specify an OU.  There
are many instances where customers would like to generally refer to an OU but have a single account (or two) within the 
OU that they would like to treat differently.

## Using Overwrite or append
When you describe an OU you can additionally describe an account that is within the OU so long as you added an overwrite
or append attribute:

  <figure>
   {{< highlight js >}}
accounts:
  - ou: '/sharedservices'
    name: 'sharedservices'
    default_region: eu-west-1
    regions_enabled:
      - eu-west-1
      - eu-west-2
      - eu-west-3
      - us-east-1
    tags:
      - outype:foundational
      - ou:sharedservices
      - type:prod
      - team:ccoe
      - role:securitytooling
      - role:account

  - account_id: 0123456789010
    name: 'special-account'
    overwrite:
      tags:
        - role:special

  - account_id: 0123456789011
    name: 'also-special-account'
    overwrite:
      tags:
        - role:also-special

   {{< / highlight >}}
  </figure>

You can use the *role:special* and *role:also-special* tags in your actions to target these accounts.

## Using AWS Organizations account tags
If you have many exceptions using append or overwrite can become cumbersome or you may want to use AWS Organizations
account tags for other reasons.  To use AWS Organizations account tags you add the attribute *organizations_account_tags*
to the account section - you can add this to accounts and to OUs.  When you add it, you must specify a value:

- ignore - this is the default. Setting ignore means you will ignore AWS Organizations tags
- honour - this means any tags you specify in AWS Organizations will *REPLACE* the tags you provide in the manifest
- append - this means any tags you specify in AWS Organizations will *APPEND* the tags you provide in the manifest

  <figure>
   {{< highlight js >}}
accounts:
  - ou: '/sharedservices'
    name: 'sharedservices'
    default_region: eu-west-1
    regions_enabled:
      - eu-west-1
      - eu-west-2
      - eu-west-3
      - us-east-1
    organizations_account_tags: honour
    tags:
      - outype:foundational
      - ou:sharedservices
      - type:prod
      - team:ccoe
      - role:securitytooling
      - role:account
   {{< / highlight >}}
  </figure>

You can use the append and overwrite described in the section above in conjunction with organizations_account_tags.  If
you do the organizations_account_tags will take affect first and then append or overwrite will affect the tags from AWS
Organizations.