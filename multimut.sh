#!/bin/bash

# Matthew Lee
# Fall 2019
# JagResearch
# MultiMutant

#SCRIPT ARGS:
# pdbID
# chainID
# resNumRange (X:Y)


# amino acids
declare -a amAcids=("A" "R" "N" "D" "C" "Q" "E" "G" "H" "I" "L" "K"
					"M" "F" "P" "S" "T" "W" "Y" "V")


# runs rMutant with the given arguments
# ARGS: pdbID chainID resNum mutTarget (optional)energyMinimization
runMutant () {
    # non-parallel processing works fine, very slow (time measured in dozens of seconds)
    # ISSUE: spawning new processes - rMutant appears to create temporary config files and access issues occur since they share the filename - only about half of the mutations are successfully completed
    # SOLUTION?: copy rMutant into subdirectories, run there, move output to main dir, delete subdir afterwards? if running distributed, would not be an issue (since rMutant would presumably have its own instance on each VM/system)
    ./rMutant $1 $2 $3 $4 $5
}


#calls runMutant for each amino acid type
# ARGS: pdbID chainID resNum
allTargets() {
     for j in "${amAcids[@]}"
     do
        runMutant $1 $2 $3 $j "no"
     done
}

#grabbing range of residues (inclusive)
beginning=${3%:*}
end=${3#*:}

#loops over range of residues mutating each into all amino acids
for ((i = $beginning; i <= end; i++));
do
    allTargets $1 $2 $i
done
