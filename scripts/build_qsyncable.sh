#!/bin/bash 


rm -rf build/QSyncable
mkdir -p build/QSyncable
cd build/QSyncable
cmake  ../../lib/qsyncable
make 

# remove all except target lib
rm -rf `find .  ! -name "libqsyncable.so"    ! -name "." ! -name ".." `

cp ../../lib/qsyncable/qmldir ./
