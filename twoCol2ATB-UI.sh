mkdir -p tmpD

TK=298.15
minR=-3.14
maxR=3.14
nBins=100
# 100 kCal/mol/deg^2/4.184 =  418.4 kJ/mol/deg^2
Kharm_kJ=100
Kharm=418.4
seedN=1234

for fileName in $(ls 1_Data_Aline_Cyclic/COLVAR*.xvg)
do
    fname=$(basename -- "$fileName")
    tmp="${fname%.*}"
    EQ=${tmp:6:5}
    echo $fileName $EQ

    python CODES/umbrella_integration-master/format_input_data.py -i $fileName -f $Kharm_kJ -r $EQ -o tmpD/AaaTmp${EQ}.ui_dat
done

#python CODES/umbrella_integration-master/umbrella_integration.py -t $TK -i tmpD/GmxTmp*.ui_dat -n $nBins -r left -m $minR $maxR -o ATBUI_pmf-aline.out -pd ATBUI_derivatives-aline.eps -pp ATBUI_PMF-aline.eps -nb 100 -ph ATBUI_position_histograms-aline.png
