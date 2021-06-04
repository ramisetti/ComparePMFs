# This scripts converts Gromacs pullx.xvg data to two data formats
# 1. acceptable by ALAN's WHAM code
# 2. acceptable by ATB-UI code

mkdir -p tmpD
rm tmpD/metadata-CH4.dat

TK=298.15
minR=0.05
maxR=1.35
nBins=100
# 5000 kJ/mol/nm^2/4.184 =  1195.02868 kCal/mol/nm^2
Kharm_kJ=5000
Kharm=1195.02868
seedN=1234

for fileName in $(ls 2_CH4_data/pullx-prd.*.xvg | sort -V)
do
     fname=$(basename -- "$fileName")
     tmp="${fname%.*}"
     I=${tmp:10:5}
     EQ=$(awk -v IDX=$I 'BEGIN{printf "%.2f", 0.05*(IDX+1) }')
     echo $fileName $EQ

     # to copy data from 0 to 5000 ps (use this if needed)
     tail -50001 $fileName > tmpD/tmpGx$I-0ps

     # to copy data from 500 to 5000 ps (to discard the first 500 ps)
     tail -45001 $fileName > tmpD/tmpGx$I-50ps

     # write metadata/dat file
     # appends the lines to metadata file
     # makesure to delete the metadata.dat file to avoid repated lines
     # the third column is force constant in kcal/mol/dist^2 because the default energy unit in ALAN's WHAM code is kCal/mol
     echo "tmpGx$I-50ps $EQ $Kharm" >> tmpD/metadata-CH4.dat

     # write the *ui.dat for ATB-UI code (To be run on Mac)  
     python CODES/umbrella_integration-master/format_input_data.py -i tmpD/tmpGx$I-50ps -f $Kharm_kJ -r $EQ -o tmpD/gmxtmp${I}.ui_dat
done
