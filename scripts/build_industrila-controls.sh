#!/bin/bash 


rm -rf build/industrial-controls 
mkdir -p build/industrial-controls
cd build/industrial-controls
cmake  ../../lib/industrial-controls
make 

rm -rf  !(libindustrial_controls.so)
cp ../../lib/industrial-controls/example/result/example ./
