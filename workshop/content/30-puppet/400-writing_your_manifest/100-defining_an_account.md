+++
title = "Defining an account"
weight = 100
+++

# Defining an Account
---------------------------

There are 2 ways to describe your Accounts in the Manifest:

- Individual AWS Account Ids
- A set of AWS Accounts under a given AWS Organizational OU Path

> NOTE: We will be using Individual Account Ids for this Workshop

## Using Individual AWS Account Ids

    schema: puppet-2019-04-01
    accounts:
    - account_id: '<YOUR_FIRST_ACCOUNT_ID>'
        name: '<MY_FIRST_ACCOUNT>'
        default_region: eu-west-1
        regions_enabled:
        - eu-west-2
        - us-east-1
        tags:
        - type:prod
        - partition:eu
        - scope:bus_app_01
    - account_id: '<YOUR_SECOND_ACCOUNT_ID>'
        name: '<MY_SECOND_ACCOUNT>'
        default_region: eu-west-1
        regions_enabled:
        - eu-west-2
        - us-east-1
        tags:
        - type:prod
        - partition:eu
        - scope:bus_app_02

## Using OU Path

To use OU Path, you must bootstrap your AWS Org Master and Puppet Accounts first. 

  schema: puppet-2019-04-01
  accounts:
    - ou: /bus_app_01/Production
      name: 'Production Business App01'
      default_region: eu-west-1
      tags:
        - type:bus_app_01-prod
        - patchwindow:weekend

    - ou: /Department_01
      name: 'Department Apps'
      default_region: eu-west-1
      tags:
        - type:dept01-all
        - patchwindow:evenings

> NOTE:  OU Paths are Case Sensitive and therefore must match exactly as written in AWS Organizations

