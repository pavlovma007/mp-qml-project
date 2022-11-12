#!/bin/bash 

rm -rf build/QMLExif
mkdir -p build/QMLExif
cd build/QMLExif
qmake  '../../lib/QMLExif_plugin/'
make 

rm -rf `find .  ! -name "libQMLExif.so" ! -name "qmldir"   ! -name "." ! -name ".."  `
