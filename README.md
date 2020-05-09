# multiMutant

Scripts to use rMutant and the Kinari analysis pipeline to generate datasets based on pdb files.

/regular/ folder is the only one in use at the moment.

### [Requirements](https://github.com/fmmmlee/multiMutant/wiki/Requirements)

### Overview

`multimutant.sh` invokes promute a number of times to produce output, which can be found in a folder that is named based on the arguments given. This output folder will contain a copy of `sequentialPipelineInvocation.sh`, which when invoked uses the Kinari pipeline to perform analysis of each of the energy-minimized outputs that promute created. The pipeline output for each _em.pdb file is placed in subdirectories in the folder said file originated from.

See the [wiki](https://github.com/fmmmlee/multiMutant/wiki) for instructions.


### Known Issues/TODO

- Having a full clone/build process when running the pipeline for the first time on a machine is quite time-consuming. An option to alleviate this would to be have an archive containing a   complete prebuilt pipeline posted in a private Gitlab repo's releases page. Periodic checks would need to be run to make sure that the binaries are current with the source repos and rebuild and repackage if necessary; this could be done periodically using one of a number of CI services or be manually performed by project contributors.
- The pipeline invocation script will attempt to copy empty files as input to the pipeline and will also invoke the pipeline when no input has been copied from a source directory.
