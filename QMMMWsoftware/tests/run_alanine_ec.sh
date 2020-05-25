#!/bin/bash

#echo "++++++++++environment setting ++++++++++"
cd ..
QMMMWsoftware_PATH=`pwd`
export QMMMW_DIR=${QMMMWsoftware_PATH}/qmmmw-1.0
QMMMWsoftware_PATH=`pwd`
export ESPRESSO_DIR=${QMMMWsoftware_PATH}/espresso-5.0.2
QMMMWsoftware_PATH=`pwd`
export LAMMPS_DIR=${QMMMWsoftware_PATH}/lammps-30Oct14
source $QMMMW_DIR/bin/ms2.env

#echo "++++++++++run alanine (Electrostatic coupling)++++++++++"
cd ${QMMMW_DIR}/examples/alanine_ec
chmod +x job.sh
./job.sh

#echo "++++++++++get xyz++++++++++"
cd ${QMMMW_DIR}/examples/alanine_ec/master
python $QMMMW_DIR/tools/xyz_tool.py dump.xyz -s -d data.alanine -o out.xyz

#echo "++++++++++plot++++++++++"
jmol out.xyz
#vmd out.xyz
#avogadro out.xyz

#echo "++++++++++gnuplot++++++++++"
#cd ${QMMMW_DIR}/examples/alanine_ec/qe
#gnuplot
#plot"ms2.rdf.dat" w l
#plot "ms2.msd.dat" w l