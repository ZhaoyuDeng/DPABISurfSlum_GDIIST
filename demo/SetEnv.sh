#!/bin/bash

export DATADIR=".../Analysis"
# Should have BIDS and subjects.txt

export SingularityDIR=".../DPABISurfSlurm_SingularityFiles"
# Should have dpabisurfslurm.sif. You can get it by singularity pull dpabisurfslurm.sif docker://cgyan/dpabisurfslurm:latest
# Should have freesurfer.sif. You can get it by singularity pull freesurfer.sif docker://cgyan/freesurfer:latest

export FreeSurferLicenseDIR=".../DPABISurfSlurm_GDIIST"
# Should have license.txt from FreeSurfer

export RemoveFirstTimePoints="5"
# Set up Number of time points needs to be removed

export FunctionalSessionNumber="1"
# Set up Number of Functional Sessions
