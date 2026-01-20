#!/bin/bash

export DATADIR="/fs/data/home/dengzy_sjwljgygnpt/Personal/SYSU2H/4_Analysis_all"
# Should have BIDS and subjects.txt

export SingularityDIR="/fs/data/home/dengzy_sjwljgygnpt/MatlabToolboxs/DPABISurfSlurm_GDIIST/"
# Should have dpabisurfslurm.sif. You can get it by singularity pull dpabisurfslurm.sif docker://cgyan/dpabisurfslurm:latest
# Should have freesurfer.sif. You can get it by singularity pull freesurfer.sif docker://cgyan/freesurfer:latest

export FreeSurferLicenseDIR="/fs/data/home/dengzy_sjwljgygnpt/MatlabToolboxs/DPABISurfSlurm_GDIIST/"
# Should have license.txt from FreeSurfer

export RemoveFirstTimePoints="5"
# Set up Number of time points needs to be removed

export FunctionalSessionNumber="1"
# Set up Number of Functional Sessions
