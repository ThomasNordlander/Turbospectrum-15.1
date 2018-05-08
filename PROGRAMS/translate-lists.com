#!/bin/csh -f

#  B. Plez  version of 12/01-2017
# exctraction of line lists from my database, and reformatting for turbospectrum. 

# The selection of lines is made at log(gf*lambda)-Elow*theta > strongest*10^CUT, 
# with theta=5040./tempselect,
# Elow is the lower energy level of the line,
# and strongest is the largest log(gf*lambda)-chie*theta of the ful line list.
# Chose a very low cut (e.g. CUT=-99.) if you want the full line list.

set CUT = -4
set tempselect = 3500.
set weakratio = 1.e${CUT}

set LAMBDAMIN = '3000'
set LAMBDAMAX = '30000'

set DIRECTORY = ${LAMBDAMIN}-${LAMBDAMAX}_cut${CUT}_new

mkdir ${DIRECTORY}

set prog = 'translate_molec_linelists_v16.1'

setenv PATH $PATH\:.

#------------------------------------------------------------------
# C2 Querci-Plez
#------------------------------------------------------------------

${prog} <<eof
../C2/C2_Ballik-Ramsay_Querci.dat
C1212Q
${DIRECTORY}/C12C12-BR_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../C2/C2_Ballik-Ramsay_Querci.dat
C1213Q
${DIRECTORY}/C12C13-BR_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../C2/C2_Ballik-Ramsay_Querci.dat
C1313Q
${DIRECTORY}/C13C13-BR_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../C2/C2_Phillips_Querci.dat
C1212Q
${DIRECTORY}/C12C12-P_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../C2/C2_Phillips_Querci.dat
C1213Q
${DIRECTORY}/C12C13-P_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../C2/C2_Phillips_Querci.dat
C1313Q
${DIRECTORY}/C13C13-P_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../C2/C2_Swan_Querci.dat
C1212Q
${DIRECTORY}/C12C12-S_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../C2/C2_Swan_Querci.dat
C1213Q
${DIRECTORY}/C12C13-S_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../C2/C2_Swan_Querci.dat
C1313Q
${DIRECTORY}/C13C13-S_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

#------------------------------------------------------------------
# CN Plez
#------------------------------------------------------------------

${prog} <<eof
../CN/linelistCN_alliso_R240511.dat
C2N4sg
${DIRECTORY}/C12N14R_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../CN/linelistCN_alliso_R240511.dat
C2N5sg
${DIRECTORY}/C12N15R_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../CN/linelistCN_alliso_R240511.dat
C3N4sg
${DIRECTORY}/C13N14R_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../CN/linelistCN_alliso_R240511.dat
C3N5sg
${DIRECTORY}/C13N15R_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../CN/linelistCN1214V130710.dat
C12N14
${DIRECTORY}/C12N14V130710_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../CN/linelistCN1215V130710.dat
C12N15
${DIRECTORY}/C12N15V130710_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../CN/linelistCN1314V130710.dat
C13N14
${DIRECTORY}/C13N14V130710_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../CN/linelistCN1315V130710.dat
C13N15
${DIRECTORY}/C13N15V130710_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof


#------------------------------------------------------------------
# CaH Plez 
#------------------------------------------------------------------

${prog} <<eof
../CaH/linelist_CaH_A-X.dat
CaH
${DIRECTORY}/CaH_A-X-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../CaH/linelist_CaH_B-X.dat
CaH
${DIRECTORY}/CaH_B-X-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof


#------------------------------------------------------------------
# MgH Kurucz
#------------------------------------------------------------------

foreach ku (24 25 26) 

${prog} <<eof
../MgH/MgH_kurucz.dat
${ku}MgH
${DIRECTORY}/${ku}MgH-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

end


#------------------------------------------------------------------
# MgH Skory et al. (the turbospectrum format is also included ; no need to convert, unless special need)
#------------------------------------------------------------------

${prog} <<eof
../MgH/MgH_Skory_Weck_Stancil.list
MgH
${DIRECTORY}/MgH-Skory-Weck_Stancil-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

#------------------------------------------------------------------
# NH from Kurucz
#------------------------------------------------------------------

${prog} <<eof
../NH/NH_kurucz.dat
14NH
${DIRECTORY}/14NH-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../NH/NH_kurucz.dat
15NH
${DIRECTORY}/15NH-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

#------------------------------------------------------------------
# OH IR Goldman  / HITRAN
#------------------------------------------------------------------

${prog} <<eof
../OH/HITRAN/hitran.combined.acm.eav.ME4957
OH-IR
${DIRECTORY}/OH_HITRAN-IR.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

#------------------------------------------------------------------
# OH AX Goldman  / HITRAN
#------------------------------------------------------------------

${prog} <<eof
../OH/GOLDMAN/4600.fix.sorted
OH-AX
${DIRECTORY}/OH_HITRAN-AX.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

#------------------------------------------------------------------
# OH A-X Kurucz
#------------------------------------------------------------------

#${prog} <<eof
#../OH/OH_A-X_kurucz.dat
#16OH
#${DIRECTORY}/16OH_A-X-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
#${LAMBDAMIN}
#${LAMBDAMAX}
#${tempselect}
#${weakratio}
#eof

#${prog} <<eof
#../OH/OH_A-X_kurucz.dat
#18OH
#${DIRECTORY}/18OH_A-X-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
#${LAMBDAMIN}
#${LAMBDAMAX}
#${tempselect}
#${weakratio}
#eof


#------------------------------------------------------------------
# SiH Kurucz
#------------------------------------------------------------------

${prog} <<eof
../SiH/SiH_kurucz.dat
28SiH
${DIRECTORY}/28SiH-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof


${prog} <<eof
../SiH/SiH_kurucz.dat
29SiH
${DIRECTORY}/29SiH-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof


${prog} <<eof
../SiH/SiH_kurucz.dat
30SiH
${DIRECTORY}/30SiH-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof


#------------------------------------------------------------------
# FeH BPz 23/08-99
#------------------------------------------------------------------

${prog} <<eof
../FeH/FeH_Plez_scaledLanghoff.list
FeH
${DIRECTORY}/FeH-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof



#------------------------------------------------------------------
# TiO VALD Plez
#------------------------------------------------------------------

foreach iso (48 )

${prog} <<eof
../TiOVALD/linelist_reduced${iso}_all_deltacorr_lab.dat
${iso}TiOV
${DIRECTORY}/${iso}TiOVALD-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

end

foreach iso (46 47 49 50)

${prog} <<eof
../TiOVALD/linelist_reduced${iso}_all_deltacorr.dat
${iso}TiOV
${DIRECTORY}/${iso}TiOVALD-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

end

#------------------------------------------------------------------
# TiO BPz 20/01-99   outdated
#------------------------------------------------------------------

#foreach iso (46 47 48 49 50)
#
#${prog} <<eof
#../TiOnew/linelist/TiO${iso}_lab.dat
#${iso}TiO
#${DIRECTORY}/${iso}TiO-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
#${LAMBDAMIN}
#${LAMBDAMAX}
#${tempselect}
#${weakratio}
#eof
#
#end

#------------------------------------------------------------------
# VO Plez
#------------------------------------------------------------------

${prog} <<eof
../VO/linelistVO_ALL.dat
VO
${DIRECTORY}/VO-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof


#------------------------------------------------------------------
# ZrO Plez
#------------------------------------------------------------------

foreach iso (90 91 92 93 94 96)

#gunzip ../ZrO/linelist/linelist${iso}ZrO.dat.gz
${prog} <<eof
../ZrO/linelist${iso}ZrO.dat
${iso}ZrO
${DIRECTORY}/${iso}ZrO-bsyn_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof
#gzip ../ZrO/linelist/linelist${iso}ZrO.dat

end

#------------------------------------------------------------------
# CO Goorvitch
#------------------------------------------------------------------

foreach co (26 27 28 36 37 38 46)

${prog} <<eof
../CO/CO_all_Goorvitch.linelist
${co}CO
${DIRECTORY}/${co}CO_Goorvitch_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

end

#------------------------------------------------------------------
# CO from Li et al.     DOES NOT WORK YET !
#------------------------------------------------------------------

#foreach co (26 27 28 36 37 38 46 47 48)
#
#${prog} <<eof
#../CO/CO_dV11_stable.par
#${co}COL
#${DIRECTORY}/${co}CO_Li_${LAMBDAMIN}-${LAMBDAMAX}.list
#${LAMBDAMIN}
#${LAMBDAMAX}
#${tempselect}
#${weakratio}
#eof

#end

#------------------------------------------------------------------
# SiS Cami et al.
#------------------------------------------------------------------

${prog} <<eof
../SiS/SiS_Camietal_2009.dat
SiS
${DIRECTORY}/SiS_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

#------------------------------------------------------------------
# SiO from Langhoff & Bauschlicher
#------------------------------------------------------------------

${prog} <<eof
../SiO/SiO_all_Langhoff.linelist
28SiO
${DIRECTORY}/28SiO_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../SiO/SiO_all_Langhoff.linelist
29SiO
${DIRECTORY}/29SiO_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

${prog} <<eof
../SiO/SiO_all_Langhoff.linelist
30SiO
${DIRECTORY}/30SiO_${LAMBDAMIN}-${LAMBDAMAX}.list
${LAMBDAMIN}
${LAMBDAMAX}
${tempselect}
${weakratio}
eof

#------------------------------------------------------------------

