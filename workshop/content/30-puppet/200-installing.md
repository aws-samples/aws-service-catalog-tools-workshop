+++
title = "Installing and configuring your puppet"
weight = 200
+++

# Installing Service Catalog Puppet


## Which Account Should I use for Puppet?

**Before you install Puppet, there are a few things to be aware of:**

- Puppet needs to be installed into an AWS Account which we will be calling the **Puppet Account** throughout the Docs.
- The Puppet Account will be used to Share Portfolios and Launch Products across the rest of your AWS Accounts.
- Accounts which you want to manage with Puppet must 'Trust' the Puppet Account. This is an [AWS IAM Mechanism](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user.html) to allow a Role in one Account to Assume a Role in another Account. Don't worry, this will be explained more a little later in the Docs.
- Puppet can be used in conjuntion with [AWS Organizations](https://aws.amazon.com/organizations/) to describe AWS Accounts under an Organizational Unit as opposed to individually or as a list. If this is the case, your Organization Master would also need to Trust the Puppet Account.
- We recommend that if you are using [Service Catalog Factory](https://aws-service-catalog-factory.readthedocs.io/en/latest/index.html), then Puppet should use the same Account.

> NOTE: For this workshop we will be using a single AWS Account to both create and deploy Products.

## Which Region(s) Should I Use?

**Some notes on your region choice:**

- You can choose to enable one or more Regions by adding them to a Config File (See: `Uploading Configuration File`_) and Bootstrapping Puppet (See: `Bootstrapping Puppet Account`_) again
- Not all Regions currently support the base Services required by Puppet such as CodeBuild and Codepipeline. Please check the [Region Table](https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/) for more information.
- Each Region will increase the Cost of Running Puppet. We recommend only configuring Regions you intend to use. It can be changed at a later date as requirements change.
- As with the Account decision above, if you are using Service Catalog Factory, we recommend using the same Regions.

> NOTE: For this workshop we will be using a 2 AWS Regions. The first will simulate the Puppet Account, the second will act as the spoke Account.

## Create a Python Virtual Environment

Virtual Environments allow you to manage different versions of Python and other required dependencies in isolation without affecting the running of the rest of your Applications on the same Machine. We recommend having an independent Virtual Environment for Puppet as in some cases the dependencies are at a different version to those required by tools like Service Catalog Factory (for example).

### Pre-reqs to Creating a Virtual Environment

To create a Virtual Environment, you must have Python3 and VirtualEnv installed on your machine.

### Creating a Virtual Environment

    virtualenv --python=python3.7 venv

### Activating a Virtual Environment

    source venv/bin/activate

## Install Service Catalog Puppet

Once you have successfully created and activated your environment, you are ready to install the Puppet Package locally to your Machine.

    pip install aws-service-catalog-puppet

## Uploading Configuration File

As noted above, we use a Configuration File to define the Regions in which we want Puppet to Operate in. 

## Create the Configuration File

This is just a json file with region names in it. Create this file in a location of your choice.

Configuration File Example:

    regions: [
      'us-east-2',
      'us-east-1',
      'us-west-1',
      'us-west-2',
      'eu-west-1',
      'eu-west-2',
      'eu-west-3',
    ]

> NOTE: We will be using eu-west-1 and eu-west-2 

## Setting your AWS Credentials

To interact with your Puppet Account, you need to set your [AWS Credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).  Initial configuration of your AWS requires an IAM User (or Assumable Role) to be setup in the Puppet Account. 

.. note:: The Profile Name should be the same name used to configure aws cli for the Puppet Account and Region should be the AWS Region used to bootstrap the Factory.

You can then Configure aws cli using:

    aws configure –profile profilename command.

Once the profile is setup you must export the Variables into your environment:

For linux:

    export AWS_PROFILE = profilename
    export AWS_DEFAULT_REGION = region

For Windows:

    set AWS_PROFILE = profilename
    set AWS_DEFAULT_REGION = region

## Uploading the Configuration File

Once the file has been created, we can now upload it:

    servicecatalog-puppet upload-config config.yaml

## Bootstrapping Puppet Account

Bootstrapping the Environment will setup your Puppet Account with all of the requisite AWS Services such as CodeBuild jobs and CodePipeline to enable Puppet to function.

Some Considerations:

- If you make changes to your config you will need to run upload-config and bootstrap commands again for the changes to occur.
- Prior to bootstrapping, you must make sure you have setup your AWS Credentials (See: `Setting your AWS Credentials`_ for the Puppet Account.

There are 2 options for bootstrapping, the first creates the Puppet CodePipeline as standard but does not add an Approval Stage. This means everytime you make a commit to the Puppet Repo, the Pipeline will run through to completion, Sharing Portfolios and Launching Products as defined in the Manifest.

Option 1:

    servicecatalog-puppet --info bootstrap

The second adds an additional Approval Stage to the Puppet pipeline so when there is a new Commit an Approval is required prior to Puppet applying the Puppet Definition.

Option 2:

    servicecatalog-puppet --info bootstrap --with-manual-approvals

> Note: Running the command with an optional '--info' flag will write the progress of the boostrap command to screen.

Setup your Puppet
~~~~~~~~~~~~~~~~~

Once Puppet Account has been bootstrapped, you will not within the Account that there is now a Puppet CodePipeline. This has a Source of the Puppet CodeCommit Repository. You are now ready to work with Puppet :)

The first step is to Clone the newly created CodeCommit repository.

Clone the configuration repo into a folder of your choice:

    git clone --config 'credential.helper=!aws codecommit credential-helper $@' --config 'credential.UseHttpPath=true' https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/ServiceCatalogPuppet
    servicecatalog-puppet seed simple ServiceCatalogPuppet

You now have the base template of Puppet and can interact with the YAML file locally on your Machine. In the next few sections of this documentation we discuss how to design your Manifest but at a very high level you'll need a code editor and some understanding of how to use [Git](https://git-scm.com)

Navigate to the Manifest File in your Repo

    cd ServiceCatalogPuppet

Open it in the editor of your choice

    vim manifest.yaml

Save the file, stage the commit, apply the commit and push it back up to the Puppet Code Commit Repo

    git add .
    git commit -m "initial add"
    git push

If you look in the Puppet Account you will see the Puppet CodePipeline running. Wait for it to complete and you have a working Puppet.








