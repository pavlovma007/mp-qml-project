#!/bin/bash 

rm -rf build/QMLExif_plugin
mkdir -p build/QMLExif_plugin
cd build/QMLExif_plugin
qmake  '../../lib/QMLExif_plugin/'
make 

rm -rf `find .  ! -name "libQMLExif.so" ! -name "qmldir"   ! -name "." ! -name ".."  `
