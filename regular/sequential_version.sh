#!/bin/bash

# Matthew Lee
# Fall 2019
# JagResearch
# MultiMutant

# SCRIPT ARGS:
# pdbID
# chainID
# resNumRange (X:Y)

# FLAGS:
# -em (energy minimization)
# -hphilic (mutate to only hydrophilic amino acids)
# -hphobic (mutate to only hydrophobic amino acids)

# CHANGES TO MAKE:
# count args/warn for incorrect flags/args
# maybe change flag structure to be "-flag=something" and/or change to use getopts or equiv.

###### VARIABLE AND FUNCTION DECLARATIONS/DEFINITIONS ######

### Amino Acids ###

# all amino acids
declare -a allAcids=("A" "R" "N" "D" "C" "Q" "E" "G" "H" "I" "L" "K"
				    "M" "F" "P" "S" "T" "W" "Y" "V")
# hydrophilic amino acids
declare -a hPhilicAcids=("S" "T" "N" "Q" "C" "E" "R" "H" "D")
# hydrophobic amino acids - gly, pro, phe, ala, Ile, Leu, Val
declare -a hPhobicAcids=("G" "P" "F" "A" "I" "L" "V" )


### Flag Options ###

# which amino acids to mutate to
declare -a amAcids=("${allAcids[@]}")
# energy minimization argument passed to rMutant
# (defaults to no, change with -em flag)
ENERMIN="no"

### Functions ###

# runs rMutant with the given arguments
# ARGS: pdbID chainID resNum mutTarget (optional)energyMinimization
runMutant () {
    #need to find way to track what forks have died to perform file operations
    #after all rMutants have finished
    #For debugging add this to end of script: && echo "Mutation of $3 to $4 complete." &
    ./rMutant $1 $2 $3 $4 $5 &>/dev/null
}


#calls runMutant for each amino acid type
# ARGS: pdbID chainID resNum
allTargets() {
     for j in "${amAcids[@]}"
     do
        runMutant $1 $2 $3 $j $4
     done
}


###### EXECUTED PART ######

#handle flags
for flag in "$@"
do
	if [ $flag == "-em" ];
	then
		ENERMIN="em"
	elif [ $flag == "-hphilic" ]
	then
		amAcids=("${hPhilicAcids[@]}")
	elif [ $flag == "-hphobic" ]
	then
		amAcids=("${hPhobicAcids[@]}")
	fi
done

#download specified protein pdb file from rcsb
wget -q -O "${1}.pdb" "https://files.rcsb.org/download/${1}.pdb"

#grabbing range of residues (inclusive)
beginning=${3%:*}
end=${3#*:}

#make output folder if it doesn't exist
if [ ! -d output ];
then
	mkdir output
fi

#loops over range of residues mutating each into all amino acids
for ((i = $beginning; i <= end; i++));
do
    allTargets $1 $2 $i $ENERMIN
done

#move pdb and txt files to output folder
mv *.*.pdb *.txt ./output -f
