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
