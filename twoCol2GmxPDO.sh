mkdir -p tmpD
rm tmpD/pdo.dat

TK=298.15
minR=-3.14
maxR=3.14
nBins=100
# 100 kCal/mol/deg^2/4.184 =  418.4 kJ/mol/deg^2
Kharm_kJ=100
Kharm=418.4
seedN=1234

#for fileName in $(ls 1_Data_Aline_Cyclic/COLVAR*.xvg | sort -V)
for EQ in -3.0 -2.75 -2.5 -2.25 -2.0 -1.75 -1.5 -1.25 -1.0 -0.75 -0.5 -0.25 +0.0 +0.25 +0.5 +0.75 +1.0 +1.25 +1.5 +1.75 +2.0 +2.25 +2.5 +2.75 +3.0
do
    fileName=1_Data_Aline_Cyclic/COLVAR$EQ.xvg

    fname=$(basename -- "$fileName")
    tmp="${fname%.*}"
    # EQ=${tmp:6:5}
    fnameNoExt="${fname%.*}"
    echo $fname $fileName $EQ $fnameNoExt

    {
    echo "# UMBRELLA      3.0"
    echo "# Component selection: 0 0 1"
    echo "# nSkip 1"
    echo "# Ref. Group 'TestAtom'"
    echo "# Nr. of pull groups 1"
    echo "# Group 1 'GR1'  Umb. Pos. $EQ Umb. Cons. $Kharm"
    echo "#####"
    } > xxtmp$EQ.tmp0

    cat xxtmp$EQ.tmp0 $fileName > tmpD/$fnameNoExt.pdo

    echo $fnameNoExt.pdo >> tmpD/pdo.dat
    rm xxtmp$EQ.tmp0
done
