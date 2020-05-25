#!/bin/bash

source $QMMMW_DIR/bin/ms2.env

cd master
$LAMMPS_DIR/src/lmp_ms2 < nh3.in > nh3.out &

sleep 5

cd ../slave
$LAMMPS_DIR/src/lmp_ms2 < nh3.in > nh3.out &

sleep 5

cd ../qe
$ESPRESSO_DIR/bin/pw.x < nh3.in > nh3.out
