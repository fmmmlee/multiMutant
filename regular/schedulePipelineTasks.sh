#!/bin/bash

# Matthew Lee
# Winter 2020
# JagResearch
# MultiMutant

###### ARGUMENTS ######

# $1 = location of pipeline
# $2 = number of instances to create
# $3 = {pdbID}.{chainID}

###### NOTES ######

# this script is intended to be used inside the output
# folder of a successful invocation of multiMutant

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
