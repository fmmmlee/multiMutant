#!/bin/bash

# Matthew Lee
# Winter 2020
# JagResearch
# MultiMutant

###### NOTES ######
# script takes no arguments

# this script is copied by multiMutant.sh into the top level of the output directory generated when multiMutant.sh is run

# modifications for parallel testing are just changing tasks to be args instead of the whole list of subdirs and having an arg for moving in/out a particular pipeline instance dir

###### SCRIPT ######
# list of subdirectories containing output
directories=${*/}

# variables used in loop
outputFolder=${PWD##*/}	# eg. 1R6JA195:196_out
pdbID=${outputFolder:0:4}	# eg. 1R6J
chainID=${outputFolder:4:1}	# eg. A

# create pipeline if it doesn't exist
if [ ! -d ../rMutant-pipeline ];
then
	echo "pipeline not found, creating..."
	cd ..
	./create_minimal_pipeline.sh
	cd ${outputFolder}
fi

for subdir in */
do
	# copy input pdb into pipeline	
	echo "Copying input from " $subdir " into pipeline"
	cp ${subdir::-1}/${subdir::-1}_em.pdb ${subdir::-1}/${pdbID}.pdb
	mkdir ../rMutant-pipeline/WT_C/data/${pdbID}.${chainID}.cur.in; mv ${subdir::-1}/${pdbID}.pdb $_


	# run pipeline
	echo "Invoking pipeline"
	cd ../rMutant-pipeline
	./invokePipeline_WT.sh ${pdbID} ${chainID}

	# copy output back to ${subdir}
	echo "Copying output to source directory"
	cp -r ./WT_C/data/${pdbID}.${chainID}.cur.out ../${outputFolder}/${subdir::-1}/${pdbID}.${chainID}.cur.out_C
	cp -r ./WT_RA/data/${pdbID}.${chainID}.ra.out ../${outputFolder}/${subdir::-1}/${pdbID}.${chainID}.ra.out_RA
	cp -r ./WT_RA/data/${pdbID}.${chainID}.cur.out ../${outputFolder}/${subdir::-1}/${pdbID}.${chainID}.cur.out_RA

	# clear input/output
	./cleanPipeline.sh

	echo "Finished, next job..."	

	# return to output dir to be ready for next iteration
	cd ../${outputFolder}
	
done

echo "Finished all jobs, exiting."
