import QtQuick 1.0
import "components"

HorizontalCheckBoxList {
    id: checkboxlist1
    imageHeight: 28
    imageWidth: 28
    textColor: "#000000"
    font.pixelSize: 16
    font.bold: false
    font.family: "DejaVu Sans"
    spacing: 8
    itemSpacing: 10
    imageChecked: "images/checkbox_click.png"
    imageUnChecked: "images/checkbox.png"
    model: ListModel{
        ListElement{item_value: "1"; item_text: "check 1"; item_checked: true;}
        ListElement{item_value: "2"; item_text: "check 2"; item_checked: false;}
    }

}

