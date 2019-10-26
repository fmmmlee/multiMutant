#!/bin/bash

# Matthew Lee
# Fall 2019
# JagResearch
# MultiMutant
# Spawns docker containers 

# SCRIPT ARGS:
# pdbID
# chainID
# resNumRange (X:Y)
# optional - energy minimization

# amino acids
declare -a amAcids=("A" "R" "N" "D" "C" "Q" "E" "G" "H" "I" "L" "K"
					"M" "F" "P" "S" "T" "W" "Y" "V")


# runs rMutant with the given arguments
# ARGS: pdbID chainID resNum mutTarget (optional)energyMinimization
# TODO: make an arg for the image name
runMutant () {
    sudo docker run multimutanttest $1 $2 $3 $4
}


#calls runMutant for each amino acid type
# ARGS: pdbID chainID resNum
allTargets() {
     for j in "${amAcids[@]}"
     do
        runMutant $1 $2 $3 $j $4
     done
}

#grabbing range of residues (inclusive)
beginning=${3%:*}
end=${3#*:}

#loops over range of residues mutating each into all amino acids
for ((i = $beginning; i <= end; i++));
do
    allTargets $1 $2 $i $4
done
