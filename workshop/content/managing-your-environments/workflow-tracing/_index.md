+++
title = "Workflow Tracing"
weight = 114
+++
---

## What are we going to do?
This article will help you to understand how to visualise a completed workflow (pipeline).

## Why is this important
As your adoption of this solution develops your workflow will grow and your pipeline will take longer to run.  
Visualising the workflow allows you to see how long tasks take to execute, what order they execute in and what blocks
other tasks from executing.  The visualisation also allows you to see the saturation of the workers to help you decide
if you need to increase the number of workers.

### Generating the traces
As the workflow runs traces are generated and stored in Amazon S3.  It is possible to export these traces in the Google
Trace Event format using the following command:

  <figure>
   {{< highlight shell >}}
servicecatalog-puppet export-traces <aws-codebuild-execution-id>
    {{< / highlight >}}
  </figure>

This will produce the input needed when using solutions like [Perfetto](https://ui.perfetto.dev/)  

### Running Perfetto locally
You may prefer to run Perfetto locally.  To do so you can check out 
[VizTracer](https://viztracer.readthedocs.io/en/latest/) which provides some helper commands to get it up and running
quickly.