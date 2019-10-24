+++
title = "Managing Products"
chapter = false
weight = 40
+++

You have successfully delivered the pre-requisites for the engagement and are now ready to develop a set of Products to meet ACME Org's compliance requirements.

In a project update with the CISO you confirm the steps you have taken so far:

* ✅ Installed service catalog factory that lets you build AWS Service Catalog portfolios and products
* ✅ Installed service catalog puppet that lets you share AWS Service Catalog products and provision them elsewhere.

The next phase of the engagement is to build out the Security Products using the newly installed tools. For each Product we will:

- Define the Product in a Portfolio using Factory
- Create a CodeCommit Repo to store the Product code
- Define the Account which we want to deploy Products into using Puppet
- Define the Product and Version we wish to Launch into the Account using Puppet 

The CISO has provided a set of requirements:

- ACME Org must be able to audit the current configuration of their AWS environment
- All S3 buckets must be encrypted
- Any unencrypted S3 buckets must be identified
- All new IAM Roles must be restricted from being overly permissive

Using service catalog tools, we can build a set of products to meet these requirements and provide the customer with a framework which they can use to extend their governance product set as required.

{{% children depth="1" showhidden="false" %}}

Don't worry if you cannot complete all the assigned tasks during the workshop, you can complete them in your own time, using your own AWS account. 