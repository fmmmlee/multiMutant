#!/bin/bash

# Matthew Lee
# Winter 2020
# JagResearch
# MultiMutant

# TODO: Make default a progress bar/# completed indicator, have -v flag to give all the output

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

counter = 1
total_jobs=$(ls -l | grep -c ^d)

for subdir in */
do
	printf "${counter}/${total_jobs}"$'\r'
	if [ "${1}" == "-v" ];
	then
		echo "##################################"
		echo "###### MULTIMUTANT-PIPELINE ######"
		echo "##################################"

		# copy input pdb into pipeline	
		echo "Copying input from " $subdir " into pipeline"
	fi
	
	if [ ! -f ${subdir::-1}/${subdir::-1}_em.pdb ];
	then
		cp ${subdir::-1}/${subdir::-1}.pdb ${subdir::-1}/${pdbID}.pdb
	else
		cp ${subdir::-1}/${subdir::-1}_em.pdb ${subdir::-1}/${pdbID}.pdb
	fi

	mkdir ../rMutant-pipeline/WT_C/data/${pdbID}.${chainID}.cur.in
	mv ${subdir::-1}/${pdbID}.pdb ../rMutant-pipeline/WT_C/data/${pdbID}.${chainID}.cur.in/${pdbID}.pdb

	if [ ! -f ../rMutant-pipeline/WT_C/data/${pdbID}.${chainID}.cur.in/${pdbID}.pdb ];
	then
		echo "Input files not found in pipeline, skipping pipeline execution."
		continue
	fi
	
	# run pipeline
	cd ../rMutant-pipeline

	# if verbose
	if [ "${1}" == "-v" ];
	then
		echo "Invoking pipeline"
		./invokePipeline_WT.sh ${pdbID} ${chainID}

		echo "###### MULTIMUTANT-PIPELINE ######"
		echo "Copying output to source directory"
	else
		#TODO this should write to a log file
		./invokePipeline_WT.sh ${pdbID} ${chainID} &>/dev/null
	fi

	# copy output back to ${subdir}
	cp -r ./WT_C/data/${pdbID}.${chainID}.cur.out ../${outputFolder}/${subdir::-1}/${pdbID}.${chainID}.cur.out_C
	cp -r ./WT_RA/data/${pdbID}.${chainID}.ra.out ../${outputFolder}/${subdir::-1}/${pdbID}.${chainID}.ra.out_RA
	cp -r ./WT_RA/data/${pdbID}.${chainID}.cur.out ../${outputFolder}/${subdir::-1}/${pdbID}.${chainID}.cur.out_RA

	

	# clear input/output
	./cleanPipeline.sh &>/dev/null

	if [ "${1}" == "-v" ];
	then
		echo "Finished, next job..."	
	fi

	# return to output dir to be ready for next iteration
	cd ../${outputFolder}
	
	let "counter++"
done

echo "Finished all jobs, exiting."
