import QtQml 2.3
import QtQuick 2.3
import '../Components' 1.0 as C

Rectangle {
    //anchors.fill: parent
    width : parent.width
    height: 510

    property alias source: playerId.source
    property alias state: playerId.state

//    color: 'red'
    C.VideoPlayer2 {
        id: playerId
        anchors.fill: parent
//        anchors.top: parent.top
//        anchors.topMargin: 50
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 40

        width : parent.width
//        height: 900
    }
}
