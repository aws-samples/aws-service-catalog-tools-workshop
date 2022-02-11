+++
title = "Managing multi Org environments"
weight = 105

+++
---

## What are we going to do?

This article will provide advice on how to manage change in a multi AWS Organizations environment.  

There are two examples of when you may want to have multiple organizations we will cover.

### Multi Org SDLC 
Those instances where you would like to develop or test changes to items you deploy, share or execute in a different AWS
Organization to production.

If you are developing or testing features that use AWS Organizations we recommend where possible to use an additional
AWS Organization.  These sorts of changes include when you are developing solutions around AWS Organizations integration
with other AWS Services like AWS Security Hub or Amazon Guard Duty.  For other scenarios we recommend you continue using
your production Organization to reduce any overheads associated with the management of an Organizations.  If you do wish
to maintain a stronger level of isolation or you have additional reasons for having additional Organizations this 
article can help you.

### Multiple Prod Orgs
Those instances where you would like to make changes to multiple Organizations with a single configuration change.

If you are managing multiple production AWS Organizations and would like to reduce the overhead of gitOps this article 
can help you.


## Background

The Service Catalog Tools default approach for environment management is to use a gitOps approach where you have a set 
of configuration files per environment that you make changes to.  These files stored are stored in a git repository.  
When change is detected in the git repository it is applied by the tools.  Multiple environments are generally managed 
via multiple branches and or multiple repositories which can lead to a sprawl of git branches or repositories, it also 
means rolling out a change out may mean merging changes between many branches or repositories which can increase the 
time and effort required to roll out changes.

The number of people you have in your teams, the number of environments you have, the number of things you deploy, share
or execute and the number of changes to push through your environments affect how well a gitOps approach works for you.
GitOps starts off simple and becomes more complex with more overheads as you make more changes to your configurations.
The goal of this article to identify specific pain points and solutions for them.  It is not possible to write guidance
for every team as you are all different.

## Multi Org SDLC
When working with a multi Org environment we recommend using the same git branch and repository for all environments.

When using Service Catalog Factory this means changes to your git repository affect all environments in parallel. We 
recommend not deploying changes to a published pipeline - if you want to make a code change to something create a new
version.

When using Service Catalog Puppet, where it is possible to specify a version externally to the manifest file we 
recommend doing so and setting the default version to the production version and overriding it for different 
environments. This means production (which should be the safest version to deploy) is deployed by default and you need 
to override it for other environments.

The following sections explain how to you can maintain a single manifest file for multiple Organizations when using
Service Catalog Puppet:

### Different Hub/Core Accounts in a Multi Org SDLC
If you have differences in the account list we recommend using intrinsic functions to declare your AWS account details - 
for example your security tooling account or log storage account ID will most likely be different in each Organization.
Using intrinsic functions to declare and use the account IDs for each hub account allows you to have different intrinsic
function files per Organization but keep the same manifest file.

### Different Parameters in a Multi Org SDLC
If you have Organization wide parameters that are different between Organizations you can use SMM parameters to store 
the values.  These parameters may be a log storage account id, the Arn of a networking resource or an email address. We 
recommend defining these parameters in the global parameters section of the main manifest file and use a naming
convention for the SSM parameters to ensure they are consistent and unique.  You can use intrinsic functions in the 
parameter name for this usecase but we do not recommend it.

### Rolling out changes to already defined items in a Multi Org SDLC
We recommend you use the manifest.ini file to specify the versions for the production Organization.  If you want to 
update the version of a stack (or any other item) we recommend defining the version number in the 
manifest-<<dev-org-puppet-account-id>>.ini file.  Should something go wrong with your overriding, the production 
version will be provisioned to the dev Org which is generally a much lower impact than deploying the test version to 
production.  When you have developing we recommend you change the manifest-<<test-org-puppet-account-id>>.ini file to 
reflect the change.  When testing is complete we recommend deleting the entries from the dev and test ini files and 
updating the production version (all in the same commit).  Following this pattern will show the change you are rolling 
out in the git history and it should be easy to see what changed, when and if your git commit comments are good then you
will see why.

### Rolling out the first version of a new item in a Multi Org SDLC
If you are creating a new launch (or something of any other action type) we recommend adding it to the main manifest 
file with a status of "ignored".  In the manifest-<<dev-org-puppet-account-id>>.properties or 
manifest-<<test-org-puppet-account-id>>.properties file we recommend you set the status to "provisioned", "terminated", 
"shared" or "enabled" depending on which type of action you are configuring and where you would like to test it.


## Multiple Prod Orgs
When working with a multiple Prod Orgs environment we recommend using the same git branch and repository for all 
environments.

When using Service Catalog Factory this means changes to your git repository affect all environments in parallel.

### Different Hub/Core Accounts in a Multiple Prod Orgs
See "Different Hub/Core Accounts in a Multi Org SDLC" above

### Different Parameters in a Multiple Prod Orgs
See "Different Parameters in a Multi Org SDLC" above

### Rolling out changes to already defined items in a Multiple Prod Orgs
We recommend you roll out your changes in waves.  You should decide which Organizations should be in each wave based on 
risk.  You should aim to roll out changes to lower risk waves before higher risk waves.  You should test the effects of 
your changes after each wave completes and before beginning the next.  You should then follow the above guidance 
"Rolling out changes to already defined items" to see how you can roll out changes to each Organization at a time.

### Rolling out the first version of a new item in a Multiple Prod Orgs
We recommend you follow the patterns defined in "Rolling out changes to already defined items" and in 
"Rolling out the first version of a new item"