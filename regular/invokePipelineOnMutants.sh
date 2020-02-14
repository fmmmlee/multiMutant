#!/bin/bash

# Matthew Lee
# Winter 2020
# JagResearch
# MultiMutant


# ARGS
# pipeline location
# number of instances to create
# 




###### EXECUTED PART ######
# creating folder to hold instances of rMutant-pipeline
if[ ! -d pipelineInstances];
then
	mkdir pipelineInstances
fi

# creating subfolders for each instance of the pipeline
for((i = 1; i <= $2; i++));
do
	cp -R $1 pipelineInstances/rMutant-pipeline$i
done

# need to assign different tasks to different processes
# basically ls the output folder with x entries, and 
# each instance gets passed x/numOfInstances folders
# to work in
# then each process continues by:
# sequentially copying input from first folder,
# running pipeline,
# copying in/output back to first folder,
# copying input from second folder....etc


