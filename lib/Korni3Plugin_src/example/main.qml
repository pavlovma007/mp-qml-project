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
    function openFile(path){
        // TODO escape
        Korni3Api.execInBack('browse "'+path+'"  ') //
    }
    Component.onCompleted: {
//        Korni3Api.newCommandResult.connect(function(cid, data){
//            dataId.text = data
//        })

        //dataId.text = Korni3Api.runCommand("ls1", "ls /")
        openFile('/home/mp/Документы/Haas_J._Anatomia_tanca.pdf')
        dataId.text = Korni3Api.runCommand("korni1", "korni3 db yt")

    }
}
