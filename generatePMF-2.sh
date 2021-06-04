# This scripts provides to generate PMFs for the two datasets using different tools
# The scripts will be required to run multiple times by commenting other tools in order
# to generate the PMFs using different tools

mkdir -p images
TOLE=1e-5
TK=298.15
minR=0.05
maxR=1.35
nBins=200
# 5000 kJ/mol/nm^2/4.184 =  1195.02868 kCal/mol/nm^2
Kharm=1195.02868
seedN=1234

# generate PMFs for CH4

## using gmx wham (To be run on machine with gmx wham installed, tested on Linux)
# (cd 2_CH4_data; gmx wham -it tpr.dat -if pullf.dat -bins $nBins -temp $TK -tol $TOLE -auto -b 500; cp profile.xvg ../GWHAM_pmf-CH4.out)

## using Alan's wham (To be run on machine with WHAM installed, tested on Linux)
# (cd tmpD; ../CODES/ALAN_WHAM/wham/wham $minR $maxR $nBins $TOLE $TK 0 metadata-CH4.dat ../ALAN_pmf-CH4.out 0 $seedN)

## using BAEUR's wham (Installed on Mac)
# (cd tmpD; wham --max $maxR  --min $minR --bins $nBins -T $TK -t $TOLE -f metadata-CH4.dat -o  ../BAEUR_pmf-CH4.out --bt 20 --seed $seedN)

## using ATB-UI (Installed on Mac)
# python CODES/umbrella_integration-master/umbrella_integration.py -t $TK -i tmpD/gmxtmp*.ui_dat -n $nBins -r left -m $minR $maxR -o ATBUI_pmf-CH4.out -pd ../images/ATBUI_derivatives-CH4.eps -pp ../images/ATBUI_pmf-CH4.eps -nb 100 -ph ../images/ATBUI_position_histograms-CH4.png

## using SHIRU's UI (results not good)
# (cd tmpD; python3.5 ../CODES/SHIRUI816_Wham.py -f metadata-CH4.dat -r $minR $maxR -b $nBins -T $TK -o ../SHIRUI816_pmf-CH4.out)
