import QtQuick 2.5
import QtQuick.Window 2.2
import Korni3Plugin 1.0

Rectangle {
    id: mainWindow
    visible: true
    width: 640
    height: 480

    Korni3Api {
        id: k3pl
    }

    Rectangle {
        id: infoRect
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 250
        color: "gray"
        opacity: 0.8

    }
}
