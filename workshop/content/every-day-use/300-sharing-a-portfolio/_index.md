+++
title = "Sharing a portfolio"
weight = 300
home_region = "eu-west-1"
+++
---

## What are we going to do?

This will talk you through the different options you have for sharing a portfolio from a hub account to a spoke account.
The different options have different limitations so it is good to read this before you set up sharing.  Changing between
the different options can affect the user experience of the people using the shared portfolio. 

## Spoke Local Portfolios

Spoke-local-portfolios was the first way you could share a portfolio using this solution.  With spoke-local-portfolios
a copy of the portfolio you created in the hub account is created in the spoke and the products are either copied or 
imported into the spoke portfolio.  If you use imported products a change to the product in the hub cascades to the 
spoke whereas if you copied the product you will need to run this solution to sync the change.  With 
spoke-local-portfolios you can create launch role constraints and resource update constraints in the spoke duplicated 
portfolio.  You can use AWS Organizations for sharing or you can share between directly between accounts.  If want to 
use different launch role constraints per spoke without having to create multiple portfolios this is the route for you.

In order to create a spoke-local-portfolio 11 tasks are created and then executed:

{{< figure src="/how-tos/sharing-portfolios/SLP-tasks.png" >}}


## Imported Portfolios

Imported-portfolios is the easiest way to share a portfolio using this solution.  With imported-portfolios
the portfolio you created in the hub account is shared with the spoke account.  Changes made to the portfolio hub are
reflected within the spoke account.  With imported-portfolios you can create launch role constraints and resource update
constraints in hub account and their affects are applied within the spoke accounts also.  You can use AWS Organizations 
for sharing or you can share between directly between accounts.  If want to use different launch role constraints per 
spoke without having to create multiple portfolios you should use spoke-local-portfolios instead.

In order to create an imported-portfolio 6 tasks are created and then executed:

{{< figure src="/how-tos/sharing-portfolios/IP-tasks.svg" >}}

## Summary
It takes more time for this solution to create spoke-local-portfolios than it does to create imported-portfolios.  If 
you need to customise your portfolio constraints per spoke then you will either need to create duplicate portfolios
when using imported-portfolios of you can use spoke-local-portfolios.  Spoke-local-portfolios require more effort to 
keep in sync.