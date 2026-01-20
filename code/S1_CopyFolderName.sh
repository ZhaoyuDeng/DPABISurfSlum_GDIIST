#! bin/bash
# Copy needed series folder after DICOM Sorter
# Zhaoyu Deng, Nov. 8 2025

InDir="....../1_Sorted2/"
OutDir="....../2_Select/"

for name in $(ls -A $InDir)
do
	echo $name
	mkdir $OutDir$name
	cp -r $InDir$name/*_T1W_Mprage_3D_SAG $OutDir$name/
	cp -r $InDir$name/*_ep2d_pace_moco_p2_2mm $OutDir$name/
	# cp -r $InDir$name/*_ep2d_pace_moco_p2_2mm_* $OutDir$name/

done
