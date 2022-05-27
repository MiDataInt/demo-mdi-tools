---
published: false
---

## Pipeline 'demo'

A simple demo pipeline to validate your MDI installation
and illustrate how a fully operational pipeline is configured
and used.

## Prerequisites

You need to have the MDI installed to use this pipeline.
For instructions see:

- <https://github.com/MiDataInt/demo-mdi-tools>

## Pipeline actions

The demo pipeline has two actions that do exactly the 
same thing, which is to create a couple of simple
text files and make a basic plot using R.

Action 'do' executes these steps using scripts
coordinated by the MDI's workflow control mechanisms.

Action 'snakemake' illustrates how you can use 
a 3rd-party workflow processor to do the same work
within an MDI pipeline.
