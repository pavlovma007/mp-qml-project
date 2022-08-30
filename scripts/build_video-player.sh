#!/bin/bash 

sudo apt  --fix-broken install libmpeg2-4-dev



rm -rf build/VideoPlayer
mkdir -p build/VideoPlayer
cd build/VideoPlayer
qmake  ../../lib/VideoPlayer
make 

# remove all except target lib
#rm -rf `find .  ! -name "libqsyncable.so"    ! -name "." ! -name ".." `

#cp ../../lib/qsyncable/qmldir ./
