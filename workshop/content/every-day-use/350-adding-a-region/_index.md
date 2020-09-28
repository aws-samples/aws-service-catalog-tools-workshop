+++
title = "Adding a region"
weight = 350
home_region = "eu-west-1"
+++
---

## What are we going to do?

This tutorial will walk you through "{{% param title %}}".

We will assume you have:
 
 - installed Service Catalog Factory correctly
 - installed Service Catalog Puppet correctly

We steps you will take depend on how you installed the tooling.  Please follow the appropriate section.

If you installed the tools by creating an AWS CloudFormation stack then please follow the AWS CloudFormation steps,
otherwise please follow the Python steps.  If you cannot remember how you installed the tools please follow the Python
steps.

If you have switched to GitHub as the source of your ServiceCatalogFactory and ServiceCatalogPuppet repos you will need
to follow the Python steps.

Whichever steps you follow you will need to follow the steps in Populating the New Regions section

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### AWS CloudFormation steps

#### Factory

If you installed factory using the AWS CloudFormation way then you can update the stack you created, changing the 
parameters.  This will update your config and bootstrap again for you. 

- In the AWS Console navigate to the AWS CloudFormation service where you created your initialisation stack - the 
recommended name for the stack was `factory-initialization-stack`.

- Select the stack and click *Update*, then *Use current template* should be selected and you can click *Next*

- In the *EnabledRegions* input specify the new list of every region you want to target.

- Once you have done this click *Next* on the following two screens and then check the box *I acknowledge that AWS 
CloudFormation might create IAM resources with custom names.* and click *Update Stack*

- Once this has completed you can run the *servicecatalog-product-factory-initialiser* AWS CodeBuild project and your
install will be updated.

#### Puppet

If you installed puppet using the AWS CloudFormation way then you can update the stack you created, changing the 
parameters.  This will update your config and bootstrap again for you. 

- In the AWS Console navigate to the AWS CloudFormation service where you created your initialisation stack - the 
recommended name for the stack was `puppet-initialization-stack`.

- Select the stack and click *Update*, then *Use current template* should be selected and you can click *Next*

- In the *EnabledRegions* input specify the new list of every region you want to target.

- Once you have done this click *Next* on the following two screens and then check the box *I acknowledge that AWS 
CloudFormation might create IAM resources with custom names.* and click *Update Stack*

- Once this has completed you can run the *servicecatalog-product-puppet-initialiser* AWS CodeBuild project and your
install will be updated.

### Python steps

#### Factory

- You will need to install aws-service-catalog-factory via pip:
 <figure>
  {{< highlight bash >}}
pip install aws-service-catalog-factory
  {{< / highlight >}}
 </figure>

- You can then set your regions: 
 <figure>
  {{< highlight bash >}}
servicecatalog-factory set-regions eu-west-1,eu-west-2,eu-west-3
  {{< / highlight >}}
 </figure>

- You will then need to bootstrap with the same settings you used when initially bootstrapping:
 <figure>
  {{< highlight bash >}}
servicecatalog-factory bootstrap ...
  {{< / highlight >}}
 </figure>

If you are using GitHub as your ServiceCatalogFactory repo you will need to specify this whenever you bootstrap.

To get a list of the parameters for bootstrapping you can run:

 <figure>
  {{< highlight bash >}}
servicecatalog-factory bootstrap --help
  {{< / highlight >}}
 </figure>

#### Puppet

- You will need to install aws-service-catalog-puppet via pip:

 <figure>
  {{< highlight bash >}}
pip install aws-service-catalog-puppet
  {{< / highlight >}}
 </figure>

- You can then set your regions: 
 <figure>
  {{< highlight bash >}}
servicecatalog-puppet set-regions eu-west-1,eu-west-2,eu-west-3
  {{< / highlight >}}
 </figure>

- You will then need to bootstrap with the same settings you used when initially bootstrapping:
 <figure>
  {{< highlight bash >}}
servicecatalog-puppet bootstrap ...
  {{< / highlight >}}
 </figure>

If you are using GitHub as your ServiceCatalogPuppet repo you will need to specify this whenever you bootstrap.

To get a list of the parameters for bootstrapping you can run:

 <figure>
  {{< highlight bash >}}
servicecatalog-puppet bootstrap --help
  {{< / highlight >}}
 </figure>

### Populating the New Regions

Once you have followed the instructions above your product pipelines have been reconfigured to add your products to the
newly specified regions.  For your products to appear in those regions you will need to run their pipelines again.

