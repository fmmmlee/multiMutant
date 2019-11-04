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
        runMutant $1 $2 $3 $j
     done
}


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
    allTargets $1 $2 $i
done

#move pdb and txt files to output folder
mv *.*.pdb *.txt ./output -f

#remove wal type
rm "${1}.pdb"
