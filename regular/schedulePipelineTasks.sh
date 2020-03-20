#!/bin/bash

# Matthew Lee
# Winter 2020
# JagResearch
# MultiMutant

###### ARGUMENTS ######

# $1 = output folder to process
# $3 = {pdbID}.{chainID}

###### NOTES ######

# this script should reside at the same level as multiMutant.sh
# a folder containing individual instances of the Kinari pipeline (./pipeline/instance_{num}/{the pipeline}) should also be present

#hb+ parallel processing potential issues

###### SCRIPT ######

#list of subdirectories containing output of multiMutant
directories=$(ls -d */)
#total number of pipelines created
progress = 0
#number of pipelines to be running at once
target = $2

# create internal pipeline cluster if not present


# choose indices based on # of pipelines and size of directories arr

# start invokePipelineOnMutants.py as another process for each set of dirs
