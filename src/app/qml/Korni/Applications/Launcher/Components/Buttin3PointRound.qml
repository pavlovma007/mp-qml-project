import QtQml 2.3
import QtQuick 2.6
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

RoundButton {
    id: rootId
    height: 32
    width: height
    flat: true

//    highlighted: true

//    background.lor : (ma.containsMouse) ? '#F2F2F2' : 'white'

    Column {
        leftPadding: parent.width / 2.0 - 2
        spacing: -9
        Text {
            font.pixelSize: 14
            font.bold: true
            color: 'black'
            text: "."
        }
        Text {
            font.pixelSize: 14
            font.bold: true
            color: 'black'
            text: "."
        }
        Text {
            font.pixelSize: 14
            font.bold: true
            color: 'black'
            text: "."
        }
    }
//    MouseArea {
//        id: ma
//        anchors.fill: parent
//        preventStealing: true
//        onContainsMouseChanged: {rootId.background.color = (containsMouse) ? '#F2F2F2' : 'white'}
//        onClicked: { rootId.clicked() }
//    }
}
