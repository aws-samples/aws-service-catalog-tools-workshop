+++
title = "Adding an account"
weight = 192
home_region = "eu-west-1"
+++
---

## What are we going to do?

This tutorial will walk you through "{{% param title %}}" 

We will assume you have:
 
 - installed Service Catalog Puppet correctly
 - created a manifest
 - bootstrapped a spoke
 
We are going to perform the following steps:

- adding an account to the manifest file

During this process you will check your progress by verifying what the framework is doing at each step.

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Adding an account to the manifest file

- Navigate to the {{% service_catalog_puppet_code_commit_repo_link %}}

- Click on *manifest.yaml*

- Click *Edit*

{{< figure src="/tasks/ClickEditPuppetRepo.png" >}}

- Append the following snippet to the YAML document in the main input field (be careful with your indentation):

- Copy the following snippet into the main input field:

 {{% code file="30-how-tos/50-every-day-use/192-adding-an-account/artefacts/orchestrator/manifest-accounts-only.yaml" language="js" %}}
 
- Update account_id on line to show the account id of the account you have bootstrapped


### Committing the manifest file

- Set the *File name* to `manifest.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/how-tos/creating-and-provisioning-a-product/CommitChanges.png" >}}
