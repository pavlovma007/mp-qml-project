import QtQuick 2.0
import "components"

ListField{
    width: 160
    height: 36
    labelText: "Label"
    labelFontPixelSize: 15
    inputFontPixelSize: 15
    visible: true
    value: 1
    listFontColor: "#000000"
    borderColor: "#ffffff"
    labelFontBold: false
    labelFontFamily: "DejaVu Sans"
    inputFontFamily: "DejaVu Sans"
    fieldSpacing: 8
    listFont.pixelSize: 18
    listFont.bold: false
    listFont.family: "DejaVu Sans"
    caption: "Set List"
    captionFontColor: "#ffffff"
    captionFont.family: "DejaVu Sans"
    captionFont.pixelSize: 20
    captionFont.bold: true
    borderWidth: 2
    borderRadius: 4
    spacing: 10
    listItemHeight: 32
    scrollBarWidth: 10
    backgroundColor: "#424242"

    model:
        ListModel {

            ListElement {
                text: "Choice 1"
                value: 1
            }
            ListElement {
                text: "Choice 2"
                value: 2
            }
            ListElement {
                text: "Choice 3"
                value: 3
            }
            ListElement {
                text: "Choice 4"
                value: 4
            }
            ListElement {
                text: "Choice 5"
                value: 5
            }
            ListElement {
                text: "Choice 6"
                value: 6
            }
            ListElement {
                text: "Choice 7"
                value: 7
            }
            ListElement {
                text: "Choice 8"
                value: 8
            }
            ListElement {
                text: "Choice 9"
                value: 9
            }
            ListElement {
                text: "Choice 10"
                value: 10
            }
        }

}
