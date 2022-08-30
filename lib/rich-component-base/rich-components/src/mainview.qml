import QtQuick 1.1
import "components"

Rectangle {
    id: rectangle1
    width: 480
    height: 272
    color: "#aaaaaa"

    Text {
        id: text1
        x: 18
        y: 13
        width: 444
        height: 54
        text: qsTr("Drag and drop components from the Library on the left pane \nof the  Designer.  Under the tab QML Types you will see the \nReach Components and Reach Graph Components")
        horizontalAlignment: Text.AlignLeft
        font.family: "DejaVu Sans"
        font.pixelSize: 14

    }

}
