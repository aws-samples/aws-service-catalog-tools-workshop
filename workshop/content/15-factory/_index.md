+++
title = "Service Catalog Factory"
chapter = true
weight = 15
+++

# What is Service Catalog Factory

Service Catalog Factory enables you to quickly build AWS CodePipelines that will
create Service Catalog portfolios and populate them with products across multiple 
regions of your AWS account.  You specify where in git the source code is for your
products and you specify which regions you would like your products to exist and 
the framework will perform all of the undifferentiated heavy lifting for you.  In 
addition, the pipelines the framework creates can perform functional tests and static
analysis on your templates to help you with your SDLC.

{{< figure src="/sc_factory.png" height="600" width="800">}}

#### This section will cover:

{{% children depth="1" showhidden="false" %}}

{{% notice tip %}}
You can use the arrows to move backwards and forwards through the Workshop
{{% /notice %}}