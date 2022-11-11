import QtQml 2.3
import QtQuick 2.5
import QtQuick.Window 2.2
import Korni3Plugin 1.0

Rectangle {
    id: mainWindow
    visible: true
    width: 640
    height: 480



    Rectangle {
        id: infoRect
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 250
        color: "gray"
        opacity: 0.8

    }
    Text {
        id: dataId
        x:255; y: 32
        //text: qsTr("text")
    }
    Component.onCompleted: {
        Korni3Api.newCommandResult.connect(function(cid, data){
//            print('qml read result', cid, data)
            dataId.text = data
        })
        Korni3Api.runCommand("ls1", "ls /")
    }
}
