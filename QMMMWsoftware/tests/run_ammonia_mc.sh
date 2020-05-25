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

#echo "++++++++++run ammonia (Mechanical coupling)++++++++++"
cd ${QMMMW_DIR}/examples/ammonia_mc
chmod +x job.sh
./job.sh

#echo "++++++++++get xyz++++++++++"
cd ${QMMMW_DIR}/examples/ammonia_mc/master
python $QMMMW_DIR/tools/xyz_tool.py dump.xyz -s -d data.nh3 -o out.xyz

#echo "++++++++++plot++++++++++"
jmol out.xyz
#vmd out.xyz
#avogadro out.xyz

#echo "++++++++++gnuplot++++++++++"
#cd ${QMMMW_DIR}/examples/ammonia_mc/qe
#gnuplot
#plot"ms2.rdf.dat" w l
#plot "ms2.msd.dat" w l