import QtQml 2.3
import QtQuick 2.3
import '.' 1.0 as C


// TODO make flickable OR "Flow"
Column {
    property alias model: repeaterId.model

    Rectangle {
        height: 1
        width: parent.width
        color: 'lightgray'
    }
    Flow {
        x: 16
        //height: 55
        width: parent.width


        spacing : 6
        Repeater {
            id: repeaterId
            model : [
                {text:"Все", selected: true },
                {text:"Музыка", selected: false },
                {text:"Джемы", selected: true },
                {text:"Сейчас в эфире", selected: false }
            ]
            C.Tag {
//                anchors.verticalCenter: parent.verticalCenter
                text: modelData.text
                selected: modelData.selected
            }
        }
    }
    Rectangle {
        height: 1
        width: parent.width
        color: 'lightgray'
    }}
