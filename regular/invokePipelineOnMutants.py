#!/usr/bin/python

# Matthew Lee
# Winter 2020
# JagResearch
# MultiMutant

###### ARGS ######

# pdbID
# chainID
# list of dirs (can be any number of args)

###### OUTLINE ######

# -> copy pdb file from task 1 multiMutant output subdir to designated pipeline input dir
# -> run the pipeline
# -> collect the output file from the output dir and copy it into the original multiMutant output subdir
# -> clear contents of input/output dirs
# -> copy pdb file from task 2 multiMutant output subdir....
# -> repeat until all tasks are completed and print a message to the console indicating this

###### SCRIPT ######

var pdbID = sys.argv[1]
var chainID = sys.argv[2]

for i in range (3,len(sys.argv)):
	
