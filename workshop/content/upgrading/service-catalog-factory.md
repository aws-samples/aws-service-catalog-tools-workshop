+++
title = "Service Catalog Factory"
chapter = false
weight = 20
home_region = 'eu-west-1'
home_region_name = 'Ireland'
+++

### Before you update

This guide applies to all users who installed using the AWS CloudFormation template.  If you did not install using the 
template then you need to follow the install guide.  When following the install guide, ensure you provision the 
initialiser stack into the same region you installed the tools using the CLI method.  Installing this way will perform
an update and will not break your install.

If you have added any regions since your initial install or modified any settings provided by the parameters in the
install template ensure you specify the values you want for them as the install process will overwrite any previous
settings you configured in your existing install.

### Navigate to CloudFormation

- Select the AWS CloudFormation Service.

{{< figure src="/how-tos/installation/select_cloudformation.png" height="450" width="900">}}

- Select the initialization stack you created when installing Service Catalog Factory.  The recommended stack name was `factory-initialization-stack`

- Select 'Update'

- Select 'Replace current template' 

- For Template source select 'Amazon S3 URL' and paste in the following:  `https://service-catalog-tools.s3.eu-west-2.amazonaws.com/factory/latest/servicecatalog-factory-initialiser.template.yaml`
  
- Then hit 'Next'

- Make any changes you want to the parameters you provided and then hit 'Next' again

- Follow the rest of the steps to update the stack

- As the stack updates the AWS CodeBuild project named `servicecatalog-product-factory-initialiser` is started.  Once it is completed the stack update will complete.  The project will update your installation to the latest version
