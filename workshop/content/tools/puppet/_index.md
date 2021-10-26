+++
title = "Service Catalog Puppet"
chapter = false
weight = 20
+++
---

## What is Service Catalog Puppet

**Service Catalog Puppet** is the second of the Service Catalog tools.  It is an AWS Solution designed to help you 
manage a multi account environment. Using the solution you can provision resources, share portfolios, execute functions
and execute assertions on the configuration of your environment.  The configuration for the solution is stored in git
and changes made to the configuration trigger a run of the solution.

## Overview

When installing **Service Catalog Puppet** you create a pipeline named servicecatalog-puppet-pipeline.  This pipeline
can use AWS CodeStar connections, Amazon S3 or AWS CodeCommit as its source.  The source contains descriptions of the 
actions you want to happen.

When the pipeline runs it will verify all existing provisioning and sharing is configured as expected.  Any manual 
actions applied since the last run are overridden and any new changes are applied.  If you change the value of a 
parameter used for provisioning the provisioned resources will be updated.

{{< figure src="/images/puppet/puppet-conceptual.png" >}}

### Spoke Execution Mode
When your pipeline takes 45+ mins to run we recommend switching to spoke execution mode.  Instead of all operations 
occurring in the hub account some of the operations are delegated to the spokes where they run in parallel across each 
spoke.  When using spoke execution mode the solution will still check if each action was performed correctly.

{{< figure src="/images/puppet/puppet-conceptual-spoke.png" >}}


## What Can I Do With The Solution

The solution allows you to easily build out a workflow.  You specify (using YAML) how you want your multi account 
environment to be configured and the solution will configure it as such.  The solution will ensure the right actions
are performed in the right order and that no API throttling limits are exceeded.  Using the solution you can perform
the following actions:

### Stacks
You can [provision a stack]({{< ref "every-day-use/385-provisioning-a-stack" >}} "provision a stack") in one or more 
regions of one or more accounts:

{{< figure src="/images/puppet/stacks.png" >}}

### Launches
You can [provision a product]({{< ref "every-day-use/200-provisioning-a-product" >}} "provision a product") in one or 
more regions of one or more accounts:

{{< figure src="/images/puppet/launches.png" >}}

### Spoke Local Portfolios
You can [share a portfolio]({{< ref "every-day-use/300-sharing-a-portfolio" >}} "sharing a portfolio") in one or
more regions of one or more accounts:

{{< figure src="/images/puppet/spoke-local-portfolios.png" >}}

### AWS Lambda Invokes
You can [invoke a lambda function]({{< ref "every-day-use/400-invoking-a-lambda-function" >}} "invoking a lambda function") for one or
more regions of one or more accounts:

{{< figure src="/images/puppet/lambda-invocations.png" >}}

### AWS CodeBuild Runs
You can [start a Code Build project]({{< ref "every-day-use/600-starting-a-code-build-project" >}} "starting a CodeBuild project") for one or
more regions of one or more accounts:

{{< figure src="/images/puppet/code-build-runs.png" >}}

### Assertions
You can [create an assertion]({{< ref "every-day-use/700-using-assertions" >}} "create an assertion") for one or
more regions of one or more accounts:

{{< figure src="/images/puppet/assertions.png" >}}
