import QtQml 2.3
import QtQuick 2.3
import '../Components' 1.0 as C

Rectangle {
    width : parent.width
    height: 510
    property alias player: playerId.player
    property alias stateIn: playerId.stateIn
    property alias stateOut: playerId.state

    //    color: 'red'
    C.VideoPlayer2 {
        id: playerId
        anchors.fill: parent

        width : parent.width
    }
}
