#!/bin/bash 


rm -rf build/qsyncable 
mkdir -p build/qsyncable
cd build/qsyncable
cmake  ../../lib/qsyncable
make 

# remove all except target lib
rm -rf `find .  ! -name "libqsyncable.so"`




#cmake lib/qsyncable '-GCodeBlocks - Unix Makefiles' 
