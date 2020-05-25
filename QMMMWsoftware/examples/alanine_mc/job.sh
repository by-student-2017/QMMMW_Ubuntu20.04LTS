#!/bin/bash

#echo "++++++++++environment setting ++++++++++"
run_PATH=`pwd`
cd ../../
QMMMWsoftware_PATH=`pwd`
export QMMMW_DIR=${QMMMWsoftware_PATH}/qmmmw-1.0
QMMMWsoftware_PATH=`pwd`
export ESPRESSO_DIR=${QMMMWsoftware_PATH}/espresso-5.0.2
QMMMWsoftware_PATH=`pwd`
export LAMMPS_DIR=${QMMMWsoftware_PATH}/lammps-30Oct14
cd $run_PATH
num_core=`grep 'core id' /proc/cpuinfo | sort -u | wc -l`

source $QMMMW_DIR/bin/ms2.env

cd master
$LAMMPS_DIR/src/lmp_ms2 < alanine.in > alanine.out &

sleep 5

cd ../slave
$LAMMPS_DIR/src/lmp_ms2 < alanine_reduced.in > alanine_reduced.out &

sleep 5

cd ../qe
export OMP_NUM_THREADS=1
mpirun -np $num_core $ESPRESSO_DIR/bin/pw.x < alanine_qm.in > alanine_qm.out

#echo "++++++++++get xyz++++++++++"
cd ../master
python $QMMMW_DIR/tools/xyz_tool.py dump.xyz -s -d data.ala -o out.xyz

#echo "++++++++++plot++++++++++"
jmol out.xyz
