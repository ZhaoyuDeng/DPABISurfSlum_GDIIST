#! bin/bash
# Convert selected series images from DICOM to NIfTI format
# Zhaoyu Deng, Nov. 16 2025

InDir="....../2_Selected"
OutDir="....../3_NIfTI"
Dcm2niix="....../dcm2niix"

for sub in $(ls -A $InDir)
do
  echo $sub
  mkdir $OutDir/$sub
  
  for series in $(ls -A $InDir/$sub)
  do
     $Dcm2niix -o $OutDir/$sub/ $InDir/$sub/$series/
  
  done
	

done
