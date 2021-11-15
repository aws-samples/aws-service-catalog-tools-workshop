+++
title = "Using a mono repo"
weight = 80
+++
---

## What are we going to do?

This tutorial will walk you through how to use a mono repo

We will assume you have:
 
 - installed Service Catalog Factory correctly

We will assume you are comfortable:
 - making changes your stacks/apps/workspaces files
 

### Things to note, before we start

- This capability was introduced in version 0.71.0 of factory.  To use this feature you will need to use this version (or
  later).
- You can only use a mono repo for stacks, apps or workspaces.  There is currently no mono repo support planned
  for products.

## Recommended folder structure

If you are using a mono repo we recommend you use the root directory for the type of thing you are going to build, we 
then recommend a directory for each thing followed by a directory for each version of that thing:


 <figure>
  {{< highlight bash >}}
➜  mono-repo tree .
.
├── apps
│     └── k8s
│         ├── v1
│         └── v2
├── stacks
│     ├── subnet
│     │     ├── v1
│     │     └── v2
│     └── vpc
│         ├── v1
│         ├── v2
│         └── v3
└── workspaces
    ├── guard-duty-enabler-hub
    │     ├── v1
    │     └── v2
    └── guard-duty-enabler-spoke
        ├── v1
        ├── v2
        └── v3

20 directories, 0 files
{{< / highlight >}}
 </figure>


## Enabling the source directory

To tell the tools you want to use a source directory you can provide a path attribute:

 <figure>
  {{< highlight js >}}
Schema: factory-2019-04-01
Stacks:
  - Name: "vpc"
    Versions:
      - Name: "v3"
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "ssm-parameter-stack"
            BranchName: "main"
          Path: "vpc/v3"
  {{< / highlight >}}
 </figure>

The path must exist in the Source dictionary and needs to be relative to the root of the git repo.

## Limitations
You must be using at least version 0.71.0 to use this and you can only use this for stacks, apps and workspaces.  At the 
moment of writing this, a change to the source will trigger all pipelines that listen to it.  A future version will 
resolve this. 

If you are providing your own build, testing or package stages you will need to manage the path to the your source in the
buildspec you write. 