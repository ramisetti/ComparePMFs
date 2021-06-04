# This scripts provides to generate PMFs for the two datasets using different tools
# The scripts will be required to run multiple times by commenting other tools in order
# to generate the PMFs using different tools

mkdir -p images

TOLE=1e-5
TK=300
minR=-3.14
maxR=3.14
nBins=200
# 100 kJ/mol/rad^2/4.184 =  418.4 kCal/mol/rad^2
Kharm_kJ=100
Kharm=418.4
seedN=1234

# generate PMFs for Aline

## using gmx wham (To be run on machine with gmx wham installed, tested on Linux)
#(cd tmpD; gmx wham -v -ip pdo.dat -bins $nBins -temp $TK -min $minR -max $maxR -cycl -b 10 -unit kCal; cp profile.xvg ../GWHAM_pmf-aline.out)

## using Alan's wham (To be run on machine with WHAM installed, tested on Linux)
# (cd 1_Data_Aline_Cyclic; ../CODES/ALAN_WHAM/wham/wham $minR $maxR $nBins $TOLE $TK 0 metadata-aline.dat ../ALAN_pmf-aline.out 20 $seedN)

## using BAEUR's wham (Installed on Mac)
# (cd 1_Data_Aline_Cyclic; wham --max $maxR  --min $minR --bins $nBins -T $TK -t $TOLE -f metadata-aline.dat -o  ../BAEUR_pmf-aline.out --bt 20 --seed $seedN)

## using ATB-UI (Installed on Mac)
python CODES/umbrella_integration-master/umbrella_integration.py -t $TK -i tmpD/AaaTmp*.ui_dat -n $nBins -r left -m $minR $maxR -o ATBUI_pmf-aline.out -pd ../images/ATBUI_derivatives-aline.eps -pp ../images/ATBUI_pmf-aline.eps -nb 20 -ph ../images/ATBUI_position_histograms-aline.png

## using SHIRU's UI
#(cd tmpD; python ../CODES/SHIRUI816_Wham.py -f metadata-aline.dat -r $minR $maxR -b $nBins -T $TK -o ../SHIRUI816_pmf-aline.out)
