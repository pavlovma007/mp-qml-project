import QtQuick 2.0
import "components"

HorizontalRadioButtonList {
    textColor: "#000000"
    font.pixelSize: 16
    font.bold: false
    font.family: "DejaVu Sans"
    imageHeight: 28
    imageWidth: 28
    spacing: 4
    itemSpacing: 10
    imageChecked: "images/radiobutton_click.png"
    imageUnChecked: "images/radiobutton.png"
    model: ListModel{
        ListElement{item_value: "1"; item_text: "radio 1"; item_checked: true}
        ListElement{item_value: "2"; item_text: "radio 2"; item_checked: false}

    }
}
