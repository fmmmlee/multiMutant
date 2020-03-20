#!/bin/bash

# Matthew Lee
# Winter 2020
# JagResearch
# MultiMutant

###### NOTES ######
# script takes no arguments

# this script is copied by multiMutant.sh into the top level of the output directory generated when multiMutant.sh is run

# TODO: this script should check for existence of pipeline and if not present invoke create_minimal_pipeline.sh in parent dir
# modifications for parallel testing are just changing tasks to be args instead of the whole list of subdirs and having an arg for moving in/out a particular pipeline instance dir

###### SCRIPT ######
# list of subdirectories containing output
directories=$(ls -d */)

# variables used in loop
outputFolder = `echo $PWD`	# eg. 1R6JA195:196_out
pdbID = ${outputFolder:0:4}	# eg. 1R6J
chainID = ${outputFolder:4:1}	# eg. A

# create pipeline if it doesn't exist
if [ ! -d ../rMutant-pipeline ];
then
	../create_minimal_pipeline.sh
fi

for subdir in directories
do
	# copy input pdb into pipeline
	cp ${subdir}_em.pdb ../rMutant-pipeline/WT_C/data/${pdbID}.${chainID}.cur.in
	
	# run pipeline
	cd ../rMutant-pipeline
	./invokePipeline_WT.sh ${pdbID} ${chainID}

	# copy output back to ${subdir}
	cp WT_C/data/${pdbID}.${chainID}.cur.out ../${outputFolder}/${subdir}/${pdbID}.${chainID}.cur.out_C
	cp WT_RA/data/${pdbID}.${chainID}.ra.out ../${outputFolder}/${subdir}/${pdbID}.${chainID}.ra.out_RA
	cp WT_RA/data/${pdbID}.${chainID}.cur.out ../${outputFolder}/${subdir}/${pdbID}.${chainID}.cur.out_RA

	# clear input/output
	./cleanPipeline.sh

	# return to output dir to be ready for next iteration
	cd ../${outputFolder}
	
done
