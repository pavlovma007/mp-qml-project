#!/bin/bash 


rm -rf build/industrial-controls 
mkdir -p build/industrial-controls
cd build/industrial-controls
cmake  ../../lib/industrial-controls
make 

rm -rf `find .  ! -name "libindustrial_controls.so"`
cp ./libindustrial_controls.so  ../../lib/industrial-controls/
