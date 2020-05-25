#!/bin/bash

#
if [ -d ./qmmmw-1.0 ];
then
  echo "detect old qmmmw-1.0 directory !"
  echo "delet old qmmmw-1.0 directory"
  rm -f -r ./qmmmw-1.0
fi
#
if [ -d ./espresso-5.0.2 ];
then
  echo "detect old espresso-5.0.2 directory !"
  echo "delet old espresso-5.0.2 directory"
  rm -f -r ./espresso-5.0.2
fi
#
if [ -d ./lammps-30Oct14 ];
then
  echo "detect old lammps-30Oct14 directory !"
  echo "delet old lammps-30Oct14 directory"
  rm -f -r ./lammps-30Oct14
fi
#

echo "++++++++++download++++++++++"
sudo apt update
sudo apt install -y libopenmpi-dev
sudo apt install -y g++
sudo apt install -y gcc
sudo apt install -y bulid-essential
sudo apt install -y gfortran
sudo apt install -y liblapack-dev
sudo apt install -y libfftw3-dev
sudo apt install -y fftw-dev
sudo apt install -y python
sudo apt install -y python2
sudo apt install -y libpython2-dev
sudo apt install -y libssl-dev
sudo apt install -y csh
sudo apt install -y zlib1g-dev
sudo apt install -y make
sudo apt install -y jmol
sudo apt install -y nkf

echo "++++++++++unpack++++++++++"
tar zxvf qmmmw-1.0.tar.gz
tar zxvf espresso-5.0.2.tar.gz
tar zxvf lammps-stable.tar.gz

echo "++++++++++environment setting for compilation++++++++++"
QMMMWsoftware_PATH=`pwd`
export QMMMW_DIR=${QMMMWsoftware_PATH}/qmmmw-1.0
QMMMWsoftware_PATH=`pwd`
export ESPRESSO_DIR=${QMMMWsoftware_PATH}/espresso-5.0.2
QMMMWsoftware_PATH=`pwd`
export LAMMPS_DIR=${QMMMWsoftware_PATH}/lammps-30Oct14

echo "++++++++++qmmmw++++++++++"
cd $QMMMW_DIR
./configure --prefix=$QMMMW_DIR ESPRESSO_DIR=$ESPRESSO_DIR LAMMPS_DIR=$LAMMPS_DIR
make patch
make
make install

echo "++++++++++quantum espresso++++++++++"
cd $ESPRESSO_DIR
./configure
make pw

echo "++++++++++lammps++++++++++"
cd $LAMMPS_DIR/src
make yes-RIGID
make yes-KSPACE
make yes-MOLECULE
make package-status
cd $LAMMPS_DIR/src/STUBS
make
cd $LAMMPS_DIR/src
make ms2

#echo "++++++++++environment setting++++++++++"
#QMMMWsoftware_PATH=`pwd`
#echo "export QMMMW_DIR=${QMMMWsoftware_PATH}/qmmmw-1.0" >> $HOME/.bashrc
#QMMMWsoftware_PATH=`pwd`
#echo "export ESPRESSO_DIR=${QMMMWsoftware_PATH}/espresso-5.0.2" >> $HOME/.bashrc
#QMMMWsoftware_PATH=`pwd`
#echo "export LAMMPS_DIR=${QMMMWsoftware_PATH}/lammps-30Oct14" >> $HOME/.bashrc
#echo "source $QMMMW_DIR/bin/ms2.env" >> $HOME/.bashrc
#bash
cd ${QMMMWsoftware_PATH}/tests
nkf -Lu --in-place ./run_32water_mc.sh
nkf -Lu --in-place ./run_32water_ec.sh
nkf -Lu --in-place ./run_alanine_mc.sh
nkf -Lu --in-place ./run_alanine_ec.sh
nkf -Lu --in-place ./run_ammonia_mc.sh
nkf -Lu --in-place ./run_ammonia_ec.sh
nkf -Lu --in-place ./run_benz_in_meth_mc.sh
nkf -Lu --in-place ./run_benz_in_meth_ec.sh
chmod +x ./run_32water_mc.sh
chmod +x ./run_32water_ec.sh
chmod +x ./run_alanine_mc.sh
chmod +x ./run_alanine_ec.sh
chmod +x ./run_ammonia_mc.sh
chmod +x ./run_ammonia_ec.sh
chmod +x ./run_benz_in_meth_mc.sh
chmod +x ./run_benz_in_meth_ec.sh
