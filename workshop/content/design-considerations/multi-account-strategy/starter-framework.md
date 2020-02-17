+++
title = "Starter framework"
weight = 10

+++
---

## What are we going to do?

This article will explain the starter multi-account framework


## Starter framework

Within your AWS Organization there are two types of Organizational Units (OUs) - foundational and additional.  

The Foundational OUs group the shared accounts needed to manage the your overall AWS environment. The areas 
considered foundational are security, networking and logs. Each of the AWS Accounts within the foundational OUs are 
grouped into production and non-production environments in order to clearly distinguish between production and non 
production policies.
 

The additional OUs group the accounts directly related to the software development lifecycle. This includes the accounts
for development (development sandboxes, source code and continuous delivery) and the accounts for the staging process 
from earliest testing to production.

{{< figure src="/design-considerations/multi-account-strategy/starter-multi-account-framework.png" >}}


### Foundational

#### Security 

This OUs where the accounts for security are grouped. This OU and the accounts within it is the main responsibility of 
the security organization.

##### Log Archive Account

The log archive account would be home to AWS CloudTrail logs and other security logs.  We would expect to see versioned, 
and encrypted Amazon S3 buckets with restrictive bucket policies and MFA on delete.  There should be limited access to 
the account and there should be alarms on user login.  The log archive account should be the single source of truth.

##### Read only 
This account would typically be owned by the security team and used to enable security operations.  It would have cross 
account roles for viewing / scanning resources in other accounts.  It would be used for exploratory security testing.

##### Break glass
This account would typically be owned by the security team and used to enable security operations. It would have cross 
account roles for making changes to resources in other accounts.  It would be used in case of an event.  It should have 
extremely limited access, almost never be used and have an alert on login.

##### Tooling
This account / these accounts would typically be owned by the security team and used to enable security operations. It 
would would be used for tools such as AWS Guard Duty, AWS Security Hub, AWS Config aggregation or [Cloud Custodian](https://github.com/cloud-custodian/cloud-custodian).  
There could be more than one tooling account.

#### Infrastructure

Infrastructure is intended for shared infrastructure services such as networking and optionally any shared hosted 
infrastructure services.

Accounts in other foundational and additional OUs should only depend on the infrastructure/prod OU accounts.

##### Shared Services

This account / these accounts would typically host the following shared services consumed by others:

- LDAP/Active Directory
- Deployment tools
    - Golden AMI
    - Pipeline

##### Network

This account / these accounts would typically host the following networking services consumed by others:

- DNS
- Shared Services VPC

### Additional

The Additional OUs group the accounts directly related to the SDLC. This includes the accounts
for development (development sandboxes, source code and continuous delivery) and the accounts for the staging process 
from earliest testing to production.






