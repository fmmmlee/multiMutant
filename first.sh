#!/bin/bash

#ARGS:
# pdbID
# chainID
# resNumRange (X:Y)

runMutant () {
    # ARGS: pdbID chainID resNum mutTarget (optional)energyMinimization
    ./rmutant $1 $2 $3 $4 $5
}

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

#
beginning = ${3%:*}
end = ${3#*:}

for i in (beginning...end)
do
    allTargets $1 $2 i &
done