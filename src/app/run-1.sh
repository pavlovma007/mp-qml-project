#!/bin/bash
# -x 

# find old runned instance 
pid=$(ps -alF | grep qt5/bin/qmlscene | head -n 1 | awk '{print $4}')
# run new instance 

#	-I ./qml/Korni/Applications/Launcher \

QT_LOGGING_RULES=1 qmlscene 	-I ../../build  \
	./qml/Korni/Applications/Launcher/Tube.qml &   # Light
	#./qml/Korni/Applications/Launcher/Views/VideoPreviewItemByLine.qml & 
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


# мягкая опалубка как это работает
