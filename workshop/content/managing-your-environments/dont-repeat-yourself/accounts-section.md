+++
title = "Accounts section"
weight = 1
+++
---


## Accounts section

As the accounts section of your manifest file increases you can find some duplication.  The following sections explain
how to deal with this

### Duplicate account details

You may find you have many accounts and OUs with the same default region and enabled regions:

  <figure>
   {{< highlight js >}}
accounts:
    - account_id: '012345678910'
      default_region: eu-west-1
      email: someone-1@example.com
      name: example account 1
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
          - role:sct
          - role:account
    - account_id: '109876543210'
      default_region: eu-west-1
      email: someone-2@example.com
      name: example account 2
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
          - role:account
  
   {{< / highlight >}}
  </figure>

If you want to roll out a new region you will have to update each of these entries.  Instead you can use the accounts 
sub section of the defaults section of the manifest file to declare the defaults for each account: 

  <figure>
   {{< highlight js >}}
defaults:
  accounts:
    default_region: eu-west-1
    regions_enabled:
        - eu-west-1
        - eu-west-2
        - eu-west-3
        - us-east-1
  
   {{< / highlight >}}
  </figure>

You can now omit the default_region and regions_enabled sections of your accounts:

  <figure>
   {{< highlight js >}}
accounts:
    - account_id: '012345678910'
      email: someone-1@example.com
      name: example account 1
      tags:
          - outype:foundational
          - ou:sharedservices
          - type:prod
          - team:ccoe
          - role:sct
          - role:account
    - account_id: '109876543210'
      email: someone-2@example.com
      name: example account 2
      tags:
          - outype:foundational
          - ou:sharedservices
          - type:prod
          - team:ccoe
          - role:account
  
   {{< / highlight >}}
  </figure>

If you specify a default_region wihtin the defaults.accounts section and an account within the accounts section 
specifies its own default_region the accounts section value will be used.  The same is true for any values set within
the defaults.accounts section - there is no append or merge behaviour.