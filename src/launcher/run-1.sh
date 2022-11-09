#!/bin/bash
# -x 

# find old runned instance 
pid=$(ps -alF | grep qt5/bin/qmlscene | head -n 1 | awk '{print $4}')
# run new instance 
qmlscene 	-I ../../lib/industrial-controls/     -I ../../build/   \
	-I ./qml/Korni/Applications/Launcher \
	./qml/Korni/Applications/Launcher/Tube.qml & 
# get new instance pid
newPid=$!
# wait loading 
sleep 3
# if new ok: kill old
if ps -p $newPid &> /dev/null
then
   #echo "$PID is running"
   kill -9 $pid 2>/dev/null
fi
