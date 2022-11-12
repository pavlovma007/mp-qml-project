#!/bin/bash -x 
# запускать из папки Korni-UI над scripts

#sudo apt-get install -y libqt5webkit5-dev
#sudo apt-get install -y libqt5webchannel5-dev libqt5webengine5 

rm -rf build/Korni3Plugin
mkdir -p build/Korni3Plugin
cd build/Korni3Plugin
qmake  ../../lib/Korni3Plugin_src
qmake 
make all

rm -rf `find .  ! -name "libKorni3Plugin.so"    ! -name "." ! -name ".." ! -name "qmldir"`
