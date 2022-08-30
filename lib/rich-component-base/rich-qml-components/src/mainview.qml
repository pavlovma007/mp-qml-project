import QtQuick 2.0
import "components"

Rectangle {
    id: rectangle1
    width: 640
    height: 480
    color: "#aaaaaa"

    Text {
        id: text1
        x: 66
        y: 39
        width: 444
        height: 54
        text: qsTr("Drag and drop components from the Library on the left pane \nof the  Designer.  Under the tab QML Types you will see the \nReach Components and Reach Graph Components")
        visible: true
        font.bold: false
        horizontalAlignment: Text.AlignLeft
        font.family: "DejaVu Sans"
        font.pixelSize: 16
    }

}
