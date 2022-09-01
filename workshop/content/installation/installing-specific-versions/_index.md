+++
title = "Installing specific versions"
weight = 200
+++

You may want to install a specific version of either factory or puppet.  For example, you may want to ensure you are 
using the same version in two different installations.  In order to do so you can alter the value of 
the **version** parameter in the initialisation stacks you created when installing the solution.

Before updating the parameter value you must select which version you would like to install.  You can see which versions
you can use in the following links:
- Factory - https://pypi.org/project/aws-service-catalog-factory/#history
- Puppet - https://pypi.org/project/aws-service-catalog-puppet/#history

Once you have selected the version you wish to install you must update your initialiser stack.  If you followed the 
install guide you should have a stack named `factory-initialization-stack` or `puppet-initialization-stack`.

You should navigate to AWS CloudFormation in the region of the AWS account where you installed the solution and search
for the stack.  

Once found, you should click **Update** button, on the next screen ensure **Use current template** is 
selected before clicking **Next**.

Then on the **Parameters** screen scroll to the bottom of the page where you will see the **Advanced** section where you 
may see the warning **Do not change unless told to do so**.  

Within the **Advanced** section there is a parameter named **Version**.  

You will need to set its value following the pattern:

 <figure>{{< highlight js >}}aws-service-catalog-factory==<version>{{< / highlight >}}</figure>
or 
<figure>{{< highlight js >}}aws-service-catalog-puppet==<version>{{< / highlight >}}</figure>

where version is the name of the version you would like to install.  For example to install version 0.60.0 of factory
you should use:

<figure>{{< highlight js >}}aws-service-catalog-factory==0.60.0{{< / highlight >}}</figure>
