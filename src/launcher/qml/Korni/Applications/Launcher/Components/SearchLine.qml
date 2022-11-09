import QtQml 2.3
import QtQuick 2.3
import QtQuick.Controls 2.5

Rectangle {
    id: rootId
    height: 40
    width: parent.width

    property string placeholderText: "Введите запрос"
    property ListModel comboList // ["First", "Second", "Third"]

    Row {
        id: contentId
        anchors.fill: parent
        spacing: 5

        Item { // wrapper by content
            width: comboId.width
            height: comboId.height

            ComboBox {
                id: comboId
                height: rootId.height
                width: rootId.width - searchButtonId.width - spacing
                editable: true
                currentIndex: -1
                model: comboList

    //            indicator.width: 15
                indicator.visible: false
                property string _tmpVisText: editable ? editText : displayText
                onActiveFocusChanged: {
                    if(activeFocus && editText===rootId.placeholderText)
                        editText = ""
                }
                Component.onCompleted: {
                    editText = rootId.placeholderText
                }
            }
//            MouseArea {
//                anchors.fill: parent
//                hoverEnabled: true
//                onContainsMouseChanged: print(containsMouse)
//                propagateComposedEvents: true
////                preventStealing: true
//            }
        }


        Button {
            id: searchButtonId
//            flat: true
//            radius: 2 // TODO
            height: rootId.height
            width: 80
            Image {
                id: iconId
                width: 18
                height: 18
                source: "./icons/youtube-search-icon.svg"
//                anchors.centerIn: parent
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -5
//                anchors.left: parent.left
//                anchors.leftMargin: 5
            }
//            Text {
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.left: iconId.right
//                anchors.leftMargin: 5
//                text: "Искать"
//            }
        }
    }

}
