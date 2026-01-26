#!/bin/bash

# DPABISurfSlurm is designed for running DPABISurf on high-performance computing (HPC)
# You should have your data (BIDS and subjects.txt) at as defined in DATADIR.
# You should have DPABISurfSlurm at as defined in DPABISurfSlurmDIR.
# You should have SetEnv.sh at as defined in SetEnvScriptDir.
# You should define the parameters in SetEnv.sh!!!
#     You should have dpabisurfslurm.sif and freesurfer.sif in SingularityDIR as defined in SetEnv.sh.
#         You can get it by singularity pull dpabisurfslurm.sif docker://cgyan/dpabisurfslurm:latest and singularity pull freesurfer.sif docker://cgyan/freesurfer:latest
#     You should have license.txt in FreeSurferLicenseDIR as defined in SetEnv.sh.
# ___________________________________________________________________________
# Written by YAN Chao-Gan 230214.
# The R-fMRI Lab, Institute of Psychology, Chinese Academy of Sciences, Beijing, China
# International Big-Data Center for Depression Research, Institute of Psychology, Chinese Academy of Sciences, Beijing, China
# ycg.yan@gmail.com

# !!!DEFINE YOURS BELOW!!!
export DPABISurfSlurmDIR=".../DPABISurfSlurm_GDIIST"
# Should have the DPABISurfSlurm files
export SetEnvScriptDir=".../Analysis"
# Should have SetEnv.sh
# You should also go into SetEnv.sh to define your parameters!!!
export DATADIR=".../Analysis"
# Should have BIDS and subjects.txt
# !!!DEFINE YOURS ABOVE!!!

sbatch --export=SetEnvScriptDir=${SetEnvScriptDir} --wait ${DPABISurfSlurmDIR}/1_GetTRInfo.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n GetTRInfo) --export=SetEnvScriptDir=${SetEnvScriptDir} --array=1-$(( $( wc -l < ${DATADIR}/subjects.txt ) )) --wait ${DPABISurfSlurmDIR}/2_RemoveFirstTimePoints.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n RemoveFirstTimePoints) --export=SetEnvScriptDir=${SetEnvScriptDir} --wait ${DPABISurfSlurmDIR}/3_Prefmriprep.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n Prefmriprep) --export=SetEnvScriptDir=${SetEnvScriptDir} --array=1-$(( $( wc -l < ${DATADIR}/subjects.txt ) )) --wait ${DPABISurfSlurmDIR}/4_fmriprep.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n fmriprep) --export=SetEnvScriptDir=${SetEnvScriptDir} --wait ${DPABISurfSlurmDIR}/5_Postfmriprep.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n Postfmriprep) --export=SetEnvScriptDir=${SetEnvScriptDir} --array=1-$(( $( wc -l < ${DATADIR}/subjects.txt ) )) --wait ${DPABISurfSlurmDIR}/6_Organize_fmriprep_Surf.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n Organize_fmriprep_Surf) --export=SetEnvScriptDir=${SetEnvScriptDir} --wait ${DPABISurfSlurmDIR}/7_Organize_fmriprep.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n Organize_fmriprep) --export=SetEnvScriptDir=${SetEnvScriptDir} --array=1-$(( $( wc -l < ${DATADIR}/subjects.txt ) )) --wait ${DPABISurfSlurmDIR}/8_SegmentSubregions.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n SegmentSubregions) --export=SetEnvScriptDir=${SetEnvScriptDir} --array=1-$(( $( wc -l < ${DATADIR}/subjects.txt ) )) --wait ${DPABISurfSlurmDIR}/9_Organize_SegmentSubregions_Convert.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n Organize_SegmentSubregions_Convert) --export=SetEnvScriptDir=${SetEnvScriptDir} --wait ${DPABISurfSlurmDIR}/10_Organize_SegmentSubregions.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n Organize_SegmentSubregions) --export=SetEnvScriptDir=${SetEnvScriptDir} --array=1-$(( $( wc -l < ${DATADIR}/subjects.txt ) )) --wait ${DPABISurfSlurmDIR}/11_DPABISurf_run.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n DPABISurf_run) --export=SetEnvScriptDir=${SetEnvScriptDir} --wait ${DPABISurfSlurmDIR}/12_MakeLnForGSR.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n MakeLnForGSR) --export=SetEnvScriptDir=${SetEnvScriptDir} --array=1-$(( $( wc -l < ${DATADIR}/subjects.txt ) )) --wait ${DPABISurfSlurmDIR}/13_DPABISurf_run_GSR.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n DPABISurf_run_GSR) --export=SetEnvScriptDir=${SetEnvScriptDir} --wait ${DPABISurfSlurmDIR}/14_ResultsOrganizer_Surf.slurm
chmod -R 777 ~/.matlab/mcr_v913
sbatch --dependency=afterok:$(squeue -u $USER -h -o %i -n ResultsOrganizer_Surf) --export=SetEnvScriptDir=${SetEnvScriptDir} --wait ${DPABISurfSlurmDIR}/15_TarResults.slurm
chmod -R 777 ~/.matlab/mcr_v913

echo "The sbatch of DPABISurfSlurm is done!!! :)"

# squeue -u $USER | grep 655 | awk '{print $1}' | xargs -n 1 scancel

# TO USE: source ../DPABISurf_runSlurm.sh


