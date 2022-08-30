#!/bin/bash 

qmlscene 	-I ../../lib/industrial-controls/  	\
			-I ../../build/qsyncable/   		\
			-I ../../build/						\
	./demo-industrial-control.qml
