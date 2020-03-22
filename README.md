# multiMutant

Scripts to use rMutant and the Kinari analysis pipeline to generate datasets based on pdb files.

/regular/ folder is the only one in use at the moment.

### Requirements

Ubuntu, Python 3.4.x - 3.6.x, and sufficient permissions to pull the following repositories from the [WWU Gitlab server](https://gitlab.cs.wwu.edu/):

- [hsiehr /  rMutant-pipeline](https://gitlab.cs.wwu.edu/hsiehr/rMutant-pipeline)

- [carpend3 /  Promute](https://gitlab.cs.wwu.edu/carpend3/promute)

- [Filip Jagodzinski /  rMutant-codeBase](https://gitlab.cs.wwu.edu/jagodzf/rMutant-codeBase)

- [ Filip Jagodzinski /  kinari-molRigidityApp](https://gitlab.cs.wwu.edu/jagodzf/kinari-molRigidityApp)

- [Filip Jagodzinski /  kinari-curationApps](https://gitlab.cs.wwu.edu/jagodzf/kinari-curationApps)

- [ Filip Jagodzinski /  kinari-molecularLib](https://gitlab.cs.wwu.edu/jagodzf/kinari-molecularLib)

- [ Filip Jagodzinski /  kinari-kernel](https://gitlab.cs.wwu.edu/jagodzf/kinari-kernel)

## Instructions

### Overview

`multimutant.sh` invokes promute a number of times to produce output, which can be found in a folder that is named based on the arguments given. This output folder will contain a copy of `sequentialPipelineInvocation.sh`, which when invoked uses the Kinari pipeline to perform analysis of each of the energy-minimized outputs that promute created. The pipeline output for each _em.pdb file is placed in subdirectories in the folder said file originated from.



### Setup

Upon invoking multiMutant for the first time, the script will download and set up promute and then the rest of the mutation job will continue normally. Subsequent invocations will be much quicker since promute setup will be unnecessary.

When invoking the pipeline script for the first time, it will download and set up the rMutant pipeline; this will take some time as various executables need to be built and tested. During this initial setup, some additional file operations will be done post-build where the sources are deleted and folders not intended for use in this project will be removed in order to save space. As with multiMutant, subsequent invocations of the pipeline will be more swift than the first.



### Known Issues/TODO

- The pipeline invocation script will attempt to copy empty files as input to the pipeline and will also invoke the pipeline when no input has been copied from a source directory.

- Both multimutant and the pipeline invocation scripts lack descriptive console messages to describe what is occurring.
- It would be useful to have the argument lists and descriptions of each script added to this readme file.