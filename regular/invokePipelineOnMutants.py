#!/usr/bin/python

# Matthew Lee
# Winter 2020
# JagResearch
# MultiMutant

###### ARGS ######

# pdbID
# chainID
# pipelineNumber
# list of dirs (can be any number of args)

###### OUTLINE ######

# -> copy pdb file from the mutated output subdir to designated pipeline input dir
# -> run the pipeline
# -> collect the output file from the output dir and copy it into the original multiMutant output subdir
# -> clear contents of input/output dirs
# -> copy pdb file from task 2 multiMutant output subdir....
# -> repeat until all tasks are completed and print a message to the console indicating this

###### SCRIPT ######


import os
from shutil import copyfile

var pdbID = sys.argv[1]
var chainID = sys.argv[2]
var pipelineNum = sys.argv[3]

# for each directory specified in invocation:
for i in range (4,len(sys.argv)):
	# -> copy pdb file from the mutated output subdir to designated pipeline input dir
	var src = os.getcwd() + "./" + sys.argv[i] + "/"
	var dest = os.getcwd() + "./pipeline/instance_" + sys.argv[3] + "/rMutant-pipeline/WT_C/data/" + sys.argv[1] + "." + sys.argv[2] + ".cur.in/" + sys.argv[1] + ".pdb"
	var output = os.getcwd() + "./pipeline/instance_" + sys.argv[3] + "/rMutant-pipeline/WT_C/data/" + sys.argv[1] + "." + sys.argv[2] + ".cur.out"

	copyfile(src + "/" + sys.argv[i] + "_em.pdb", dest) 

	# -> run the pipeline
	subprocess.check_call(["./invokePipeline_WT.sh", sys.argv[1], sys.argv[2]], shell=true)
	
	# -> collect the output file from the output dir and copy it into the original multiMutant output subdir
	for somefile in os.listdir(output):
		if somefile endswith(".pdb"):
			copyfile(output + "/" + somefile, src + "/" + somefile)
			#purge this dir
	# -> clear contents of input/output dirs
	#filedelete(dest)

	
