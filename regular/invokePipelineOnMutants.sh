#!/bin/bash

# Matthew Lee
# Winter 2020
# JagResearch
# MultiMutant

#should be copied to the output folder after multiMutant runs

# ARGS
# number of instances to create
# args for Kinari script




###### EXECUTED PART ######
# copy pipeline to each folder at the current directory level and run with appropriate arguments
# do say 20 at a time
# ls, pipe first 20 entries of ls into a cp statement (cp [ls output entry as dest] [pipeline src])
# in 20 separate processes, invoke the pipeline with appropriate arguments
# wait certain amount of time (30 sec, 1 min, whatever) then do for next 20 entries of ls, until end of ls is reached
# have cleanup function that checks after x minutes to see if output is in a folder where Kinari pipeline was run, if so, then delete the pipeline from that folder

