+++
title = "Installation"
weight = 10
+++

In order to install these tools you will need:

- A single AWS Account which you can log into
- A web browser where to access the AWS console.

You will also need to decide which account to install these tools into.  

This account will contain the AWS CodePipelines and will need to be accessible to any accounts you would like to share 
products with. If you want to use the optional AWS Organizations support you will need to install the tools into an 
account where there is (or can be) a trust relationship with the Organizations master account.  You can install these 
tools into your master account but this is not recommended. 

Both tools should be installed into the same region of the same account.

{{% children depth="1" showhidden="false" %}}