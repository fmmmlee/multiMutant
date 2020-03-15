#!/bin/bash

# Matthew Lee
# Winter 2020
# JagResearch
# MultiMutant

###### NOTES ######
# script takes no arguments
# invoked by pipeline invocation script if pipeline not found

###### rMutant-pipeline setup ######
# clone rMutant-pipeline
git clone https://gitlab.cs.wwu.edu/carpend3/promute.git

# delete files/folders not used by multiMutant
cd rMutant-pipeline
rm -rf M_C
rm -rf M_EM
rm -rf M_RA
rm -rf createPipeline.sh
rm -rf invokePipeline{_WT_2mutations, _WT_3mutations, _WT_mutant, _WT_mutant_EM, _WT_scwrl, _mutant, _scwrl}.sh

# rewriting cleanPipeline.sh without references to deleted folders
echo "#!/bin/bash

rm -rf *~

cd WT_C/data
./cleanStage.sh
cd ../..

cd WT_EM/data
./cleanStage.sh
cd ../..

cd WT_RA/data
./cleanStage.sh
cd ../..

cd scwrl
./clean.sh
cd .." > cleanPipeline.sh
