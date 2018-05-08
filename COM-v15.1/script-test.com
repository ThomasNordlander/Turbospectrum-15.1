#!/bin/csh -f

date
set mpath=models

foreach MODEL (5777g4.44z+0.00a+0.00t01-ref107857)

#set Cabu = 8.656
#set Nabu = 7.78
#set Oabu = 8.66
 
set lam_min    = '3000'
set lam_max    = '4000'

# was 0.01
# Note, R=300'000 means the step should be 0.01 Å at 3000 Å, but 0.1 Å at 30'000 Å.
# Can we make it uniform in frequency instead?
set deltalam   = '0.01'
set METALLIC   = '     0.000'
set TURBVEL    = '1.0'
set SUFFIX     = _${lam_min}-${lam_max}_xit${TURBVEL}.spec
set result     = ${MODEL}${SUFFIX}

#
# ABUNDANCES FROM THE MODEL ARE NOT USED !!!

# babsma: compute continuous opacities
../exec-v15.1/babsma_lu << EOF
'LAMBDA_MIN:'  '${lam_min}'
'LAMBDA_MAX:'  '${lam_max}'
'LAMBDA_STEP:' '${deltalam}'
'MODELINPUT:' '$mpath/${MODEL}'
'MARCS-FILE:' '.true.'
'MODELOPAC:' 'contopac/${MODEL}opac'
'METALLICITY:'    '${METALLIC}'
'ALPHA/Fe   :'    '0.00'
'HELIUM     :'    '0.00'
'R-PROCESS  :'    '0.00'
'S-PROCESS  :'    '0.00'
'INDIVIDUAL ABUNDANCES:'   '0'
'XIFIX:' 'T'
$TURBVEL
EOF

########################################################################

# bsyn: compute the spectrum
../exec-v15.1/bsyn_lu <<EOF
'LAMBDA_MIN:'     '${lam_min}'
'LAMBDA_MAX:'     '${lam_max}'
'LAMBDA_STEP:'    '${deltalam}'
'INTENSITY/FLUX:' 'Flux'
'COS(THETA)    :' '1.00'
'ABFIND        :' '.false.'
'MODELOPAC:' 'contopac/${MODEL}opac'
'RESULTFILE :' 'syntspec/${result}'
'METALLICITY:'    '${METALLIC}'
'ALPHA/Fe   :'    '0.00'
'HELIUM     :'    '0.00'
'R-PROCESS  :'    '0.00'
'S-PROCESS  :'    '0.00'
'INDIVIDUAL ABUNDANCES:'   '1'
3  1.05
'ISOTOPES : ' '2'
3.006  0.075
3.007  0.925
'NFILES   :' '2'
DATA/Hlinedata
linelists/atoms_3000-30000.list
'SPHERICAL:'  'F'
  30
  300.00
  15
  1.30
EOF
########################################################################
date
end
