#!/bin/bash 


mkdir -p ../build/qsyncable
cd build/qsyncable
cmake  ../../lib/qsyncable
make 

# remove all except target lib
rm -rf  !(libqsyncable.so)
