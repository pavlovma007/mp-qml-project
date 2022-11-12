#!/bin/bash 

rm -rf build/Industrial
mkdir -p build/Industrial
cd build/Industrial
cmake  ../../lib/industrial-controls
make 

rm -rf `find .  ! -name "libindustrial_controls.so"    ! -name "." ! -name ".."  ! -name "qmldir" `
cp ./libindustrial_controls.so  ../../lib/industrial-controls/

cp -R ../../lib/industrial-controls/Industrial/*   ./

echo module  Industrial    >qmldir 
echo plugin  industrial_controls    	>>qmldir 
