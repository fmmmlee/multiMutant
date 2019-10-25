#!/bin/bash

# Matthew Lee
# Fall 2019
# JagResearch
# MultiMutant

#ARGS:
# pdbID
# chainID
# resNumRange (X:Y)

# runs rMutant with the given arguments
runMutant () {
    # ARGS: pdbID chainID resNum mutTarget (optional)energyMinimization
    # non-parallel processing works fine, very slow (time measured in dozens of seconds)
    # ISSUE: spawning new processes - rMutant appears to create temporary config files and access issues occur since they share the filename - only about half of the mutations are successfully completed
    # SOLUTION?: copy rMutant into subdirectories, run there, move output to main dir, delete subdir afterwards? if running distributed, would not be an issue (since rMutant would presumably have its own instance on each VM/system)
    ./rMutant $1 $2 $3 $4 $5 &
}


#calls runMutant for each amino acid type
allTargets() {
     # ARGS: pdbID chainID resNum
     runMutant $1 $2 $3 "A"
     runMutant $1 $2 $3 "R"
     runMutant $1 $2 $3 "N"
     runMutant $1 $2 $3 "D"
     runMutant $1 $2 $3 "C"
     runMutant $1 $2 $3 "Q"
     runMutant $1 $2 $3 "E"
     runMutant $1 $2 $3 "G"
     runMutant $1 $2 $3 "H"
     runMutant $1 $2 $3 "I"
     runMutant $1 $2 $3 "L"
     runMutant $1 $2 $3 "K"
     runMutant $1 $2 $3 "M"
     runMutant $1 $2 $3 "F"
     runMutant $1 $2 $3 "P"
     runMutant $1 $2 $3 "S"
     runMutant $1 $2 $3 "T"
     runMutant $1 $2 $3 "W"
     runMutant $1 $2 $3 "Y"
     runMutant $1 $2 $3 "V"
}

#grabbing range of residues (inclusive)
beginning=${3%:*}
end=${3#*:}

#loops over range of residues mutating each into all amino acids
for ((i = $beginning; i <= end; i++));
do
    allTargets $1 $2 $i
done
