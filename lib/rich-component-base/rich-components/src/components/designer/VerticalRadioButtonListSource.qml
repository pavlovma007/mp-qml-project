import QtQuick 1.0
import "components"

VerticalRadioButtonList {
    id: radiobutton_list1
    textColor: "#000000"
    font.pixelSize: 16
    font.bold: false
    font.family: "DejaVu Sans"
    spacing: 4
    itemSpacing: 10
    imageHeight: 28
    imageWidth: 28
    imageChecked: "images/radiobutton_click.png"
    imageUnChecked: "images/radiobutton.png"
    model: ListModel{
        ListElement{item_value: "1"; item_text: "radio 1"; item_checked: true}
        ListElement{item_value: "2"; item_text: "radio 2"; item_checked: false}

    }
}
