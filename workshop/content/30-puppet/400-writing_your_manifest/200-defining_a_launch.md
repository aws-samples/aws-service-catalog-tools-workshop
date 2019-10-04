+++
title = "Defining a launch"
weight = 200
+++

# Defining a Launch

A Launch definition essentially tells Puppet which products to provision in which Accounts. There are 2 options to do this:

- Launch Based on Account Id
- Launch Based on Tag

Launch Based on Account Id
^^^^^^^^^^^^^^^^^^^^^^^^^^

The below code block provides an example of describing a launch of v1 of an example Product into your default region based on the 12 digit account id.

  schema: puppet-2019-04-01

    launches:
    my-first-launch-example:
        portfolio: example-portfolio-name
        product: example-product-name
        version: v1
        deploy_to:
        accounts:
            - account_id: <'12_Digit_Account_Id'>
            regions: default_region

> The Portfolio and Product names must match exactly what is in Service Catalog

Launch Based on Tag
^^^^^^^^^^^^^^^^^^^

The below code block provides an example of describing the same launch as above of v1 of an example Product into your default region. However, this time we have used a Tag.

    schema: puppet-2019-04-01

    launches:
    my-first-launch-example:
        portfolio: example-portfolio-name
        product: example-product-name
        version: v1
        deploy_to:
        tags:
            - tag: scope:bus_app_01
            regions: default_region

> The Tag matches one from our Account List Description earlier in this section