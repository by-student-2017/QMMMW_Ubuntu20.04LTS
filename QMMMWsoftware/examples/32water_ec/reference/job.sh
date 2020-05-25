source $QMMMW_DIR/bin/ms2.env

cd master
$LAMMPS_DIR/src/lmp_ms2 < water.in > water.out &

sleep 5

cd ../slave
$LAMMPS_DIR/src/lmp_ms2 < water_single.in > water_single.out &

sleep 5

cd ../qe
$ESPRESSO_DIR/bin/pw.x < water.in > water.out
