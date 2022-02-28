+++
title = "Fault Tolerance"
weight = 110
aliases = [
    "/design-considerations/fault-tolerance.html",
]
+++
---

## What are we going to do?
This article will help you to understand how to make the workflow you generate more fault tolerant.

## Why is this important
Customers are using this solution to deploy, operate and govern AWS multi account estates.  These estates are made up of
several regions and hundreds of accounts.  

When building a workflow using this solution you can use dependencies to say only perform an action after another action 
has completed successfully.  By default, every sub action of the dependency must complete successfully before the
dependent action is instructed to start.  

## A practical example
When inflating your accounts you may want to enable AWS Config before enabling AWS Config rules.  By default, if the 
enabling of Config fails in one region of one account no Config rules will be deployed.  This is great for rapid 
feedback - fail fast - but in production this means you have regions of accounts with missing guardrails.

The rest of this section explains your options for improving fault tolerance along with the costs of each option.

## Spoke execution mode
Using spoke execution mode is the quickest way to improve fault tolerance.  When you configure an action to be performed
using spoke execution mode you are delegating execution to the spoke.  This solution will fan out the spoke actions to 
each spoke in parallel in a single batch. Each spoke does not affect another - meaning a failure in one spoke will have 
no impact to others.  However, within the spoke a failure enabling Config in one region will mean no rules enabled in 
other regions.  To further improve fault tolerance you will need to use fine grain depends on.

Enabling spoke execution mode means errors will not be visible in your pipeline output.  You will need to log into the 
spoke account to view the execution there or you will need to use AWS Ops Center in the hub account to see what went
wrong.  This can increase operational complexity.

Enabling spoke execution mode typically reduces execution time considerably.  We have seen it reduce execution time by 
more than a factor of 8.

## Fine grain depends on
When you say AWS Config rules depends on AWS Config enablement the framework will enable AWS Config across all regions
of all accounts before attempting to enable any AWS Config rules.  Using fine grain depends on you can change that 
behaviour.  You can say:

- Once AWS Config enable completes in the region of the account, start AWS Config rules in the same region of the same account
- Once AWS Config enable completes in the region x of all accounts, start AWS Config rules in region x of all accounts
- Once AWS Config enable completes in all regions of account n, start AWS Config rules in all regions of account n

This can be useful when deploying / configuring critical services within you multi account estate but it can increase
the execution time of your workflow.  We have seen it add 30 - 60 mins of execution time to estates with 6 regions, 200 
accounts and 8 actions.