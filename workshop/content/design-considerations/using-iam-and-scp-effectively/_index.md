+++
title = "Using IAM and SCP Effectively"
weight = 500

+++
---

## What are we going to do?
This article will explain how to restrict access to the AWS services for your users but still allow them to provision 
resources using *launch constraints*.   

It will also cover how you can use resource naming conventions and conditional IAM and SCP statements to ensure 
users cannot modify AWS Service Catalog products or the resources within them.  

## Using launch constraints
You may wish to use a service catalog to provide a set of approved resource templates for consumption.  In this instance,
you may want to allow consumers to provision a product that contains an AWS S3 bucket but you may not want to allow these
users to provision AWS S3 buckets directly via the console or cli.  

To achieve this, you could use a launch constraint and an IAM role assumable by the AWS Service Catalog service.  The IAM
role you provide as a launch constraint is used to provision the resources in the product.  The role provisioning the product
must have the *iam:passrole* permission. 

## Resource naming conventions along with conditional IAM and SCP statements
When writing your AWS Service Catalog products you can have a parameter to all of your products that is used as a prefix 
to the names of the resources provisioned.  You can then use IAM boundaries to prohibit the modifying of all resources 
that have the given prefix or you can use a conditional SCP to prohibit the modifying of all resources that have the given
prefix except for the *PuppetRole*.

Within the Service Catalog Tools all provisioning occurs using an IAM role */servicecatalog-puppet/PuppetRole*.

When writing your products you should use globally unique parameter names to avoid clashes.  If you use the same name for
the resource prefixes you can set the parameter value once in the manifest file as a [global parameter](https://aws-service-catalog-puppet.readthedocs.io/en/latest/puppet/designing_your_manifest.html#parameters). 

{{% notice note %}}
If you would like to share your experiences please raise a [github issue](https://github.com/aws-samples/aws-service-catalog-tools-workshop/issues)
{{% /notice %}}
