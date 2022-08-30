import QtQuick 1.1
import "components"

Knob {
    id: knob1
    width: 180
    height: 180
    hintBorderColor: "#000000"
    imageNeedleHeight: 108
    imageBase: "images/dialbase.png"
    showHint: true
    hintBorderWidth: 2
    hintFontFamily: "DejaVu Sans"
    imageNeedle: "images/dialneedle.png"
    hintBackgroundColor: "#ffffff"
    hintFontColor: "#000000"
    hintFontPixelSize: 16
    remove: false
    initialIndex: 0
    mouseAreaWidth: 77
    mouseAreaHeight: 77
    textColor: "#ffffff"
    imageNeedleWidth: 108
    font.family: "DejaVu Sans"
    imageBaseHeight: 108
    font.bold: false
    hintRadius: 9
    imageBaseWidth: 108
    hintWidth: 40
    add: false
    hintHeight: 40
    font.pixelSize: 16

    model:  ListModel{
            id: data
            ListElement{
                index: 0
                value: 0
            }
            ListElement{
                index: 1
                value: 1
            }
            ListElement{
                index: 2
                value: 2
            }
            ListElement{
                index: 3
                value: 3
            }
            ListElement{
                index: 4
                value: 4
            }
            ListElement{
                index: 5
                value: 5
            }
        }

}
