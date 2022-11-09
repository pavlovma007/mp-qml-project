import QtQml 2.3
import QtQuick 2.3

Rectangle { 
    id: rootId
    property bool selected: false
    property alias text: textId.text
    property alias font: textId.font
    property alias textColor: textId.color

    height: 32
    width: textId.width + 28
    radius: width / 2
    color: selected ? '#030303 ': Qt.rgba(0, 0, 0, 0.05)

    signal clicked()

    Text {
        id: textId
//        anchors.verticalCenterOffset: 3
        anchors.centerIn: parent
        color: selected ? 'white' : 'black'
        text: "Радио"

    }
    MouseArea {
        anchors.fill: parent
        onClicked: { rootId.clicked() }
    }
}
