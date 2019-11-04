# multiMutant

Sequential version is in the /regular/ folder. For it to work, it should be placed in a folder containing rMutant.

After throwing together that script, I tried forking processes and running in parallel, but unfortunately it appears that [rMutant](https://gitlab.cs.wwu.edu/hurshk/rMutant_2) creates temporary files and multiple running instances of rMutant fight over the file access (later edit: not 100% sure, will check up on this). To resolve this, I decided to run each mutation inside a docker container, from which the result could be copied back to the host. Not finished implementing this yet!

Depending on how effective this proves (particularly for larger workloads) it might be doable to try running on AWS Batch or a comparable service too. Alternatively, if the file access issues prove to be inconsequential, traditional forking could be done for simplicity's sake on small workloads and combined with containers when dealing with larger job sizes.

### Todo
- make appropriate changes to script run inside docker container
  - send output files to host
- dockerfile changes
  - mount a volume instead of copying a directory containing the scripts and rMutant
- changes to host script
  - take an image name as an argument
  - `docker network create [...]` to allow containers to communicate with host
