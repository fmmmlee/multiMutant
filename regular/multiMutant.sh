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
# rename wl type to something in the vein of "WL_$1".pdb
# add flag for logging output to a file

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
    
	# run promute in fork unless energy minimization is enabled
	if [ $5 == "em" ];
	then
		echo "Mutating $1 on chain $2 at residue $3 to $4"
		./proMute $1 $2 $3 $4 $5 &>/dev/null && mkdir ../$6_out/$1.$2$3$4 && mv *$1.$2$3$4* ../$6_out/$1.$2$3$4 -f 2>/dev/null
	else
		./proMute $1 $2 $3 $4 $5 &>/dev/null && mkdir ../$6_out/$1.$2$3$4 && mv *$1.$2$3$4* ../$6_out/$1.$2$3$4 -f 2>/dev/null &
	fi    
}


#calls runMutant for each amino acid type
# ARGS: pdbID chainID resNum foldername
allTargets() {
     for j in "${amAcids[@]}"
     do
        runMutant $1 $2 $3 $j $4 $5
     done
}


###### EXECUTED PART ######
# Download and build proMute if it doesn't exist
if [ ! -d promute ];
then
	git clone https://gitlab.cs.wwu.edu/carpend3/promute.git
	cd promute
	make
	cd ..
	mv promute promute-src
	mv promute-src/build promute
	rm -rf promute-src
	
fi

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
if [ ! -f "promute/${1}.pdb" ]
then
	wget -q -O "promute/${1}.pdb" "https://files.rcsb.org/download/${1}.pdb"
fi

#grabbing range of residues (inclusive)
beginning=${3%:*}
end=${3#*:}

#make output folder if it doesn't exist
if [ ! -d $1$2$3_out ];
then
	mkdir $1$2$3_out
fi

#copying pipeline invocation script into output folder ?and giving it permissions?
cp sequentialPipelineInvocation.sh $1$2$3_out/sequentialPipelineInvocation.sh
# (below might not be necessary)
#cd $1$2$3_out 
#chmod +x sequentialPipelineInvocation.sh
#cd ..

#cd-ing into folder containing rMutant
cd promute

#loops over range of residues mutating each into all amino acids
for ((i = $beginning; i <= end; i++));
do
    allTargets $1 $2 $i $ENERMIN $1$2$3
done


#
