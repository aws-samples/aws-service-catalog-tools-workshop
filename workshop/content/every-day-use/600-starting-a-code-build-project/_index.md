+++
title = "Starting a CodeBuild project"
weight = 600
home_region = "eu-west-1"
+++
---

## What are we going to do?

This tutorial will walk you through how to use the "{{% param title %}}" feature.

We will assume you have:
 
 - installed Service Catalog Puppet correctly
 - bootstrapped a spoke
 - created a manifest file
 - added an account to the manifest file

 
 
We are going to perform the following steps to "{{% param title %}}":

- Create an AWS CodeBuild project in your puppet account that will be triggered
- Adding the codebuild run to your manifest file that will do the triggering

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Create an AWS CodeBuild project in your puppet account

Log into the account where you installed service catalog puppet and navigate to the AWS CodeBuild console in the region
where you installed service catalog puppet.

Create a new project named `ping-host`.  It should have three environmental variables named:

- `TARGET_ACCOUNT_ID`
- `TARGET_REGION`
- `HOST_TO_PING`

For the build spec you should have the following command:

`echo "I have been asked to ping ${HOST_TO_PING} from ${TARGET_REGION} of ${TARGET_ACCOUNT_ID}"`

### Adding the codebuild run to your manifest file
 
Add the following snippet to your manifest file:

 <figure>
  {{< highlight js >}}
code-build-runs:
  ping-host:
    project_name: ping-some-host
    parameters:
      HOST_TO_PING:
        default: 10.0.0.2
    run_for:
      tags:
        - regions: regions_enabled
          tag: role:all
  {{< / highlight >}}
 </figure>

If you already had a code-build-runs please append the ping-host declaration to the existing code-build-runs section.

You will most likely need to update the tag from role:all to whatever you are using in your environment.

The parameters section supports all capabilities that *launches* supports.  You can read more in the "Using parameters 
in the real world" section under the "Design considerations" heading.

#### What did we just do?

You told service catalog puppet to get a list of all regions for all accounts with the tag you specified.  For each item
in the list you told service catalog puppet to run a codebuild project.  If you have 2 regions and 4 accounts the 
codebuild project will be triggered 8 times.  The codebuild projects will run in serial to avoid hitting service or api 
throttling limits.

### Verifying the codebuild run

To verify the codebuild runs you can use the codebuild console.  Look at the history for the ping-host project and 
verify the number of runs was correct.  For each run you can verify the environmental variables that were overridden.

You have now successfully run a codebuild project!
