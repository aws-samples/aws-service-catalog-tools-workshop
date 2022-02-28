+++
title = "Manifest properties"
weight = 140
home_region = "eu-west-1"
aliases = [
    "/every-day-use/900-multi-org-usage.html",
]
+++
---

### Manifest properties

If you are using puppet to manage multiple environments you may find it easier to keep the versions of your launches in 
properties files instead of the manifest.yaml files. To do this you create a file named manifest.properties in the same 
directory as your manifest.yaml file. Within this file you can specify the following:

  <figure>
   {{< highlight ini >}}
[launches]
IAM-1.version = v50
{{< / highlight >}}
    </figure>

This will set the version for the launch with the name IAM-1 to v50.

Please note this will overwrite the values specified in the manifest.yaml files with no warning.

If you are using multiple instances of puppet you can also create a file named manifest-<puppet-account-id>.properties. 
Values in this file will overwrite all other values making the order of reading:

1. manifest.yaml 
2. other manifest files (eg in manifests/) 
3. manifest.properties 
4. manifest-<<puppet-account-id>>.properties