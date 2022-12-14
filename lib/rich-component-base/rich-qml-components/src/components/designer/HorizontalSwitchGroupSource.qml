import QtQuick 2.0
import "components"

HorizontalSwitchGroup {
    spacing: 4
    font.pixelSize: 16
    font.bold: false
    font.family: "DejaVu Sans"
    textOffColor: "#000000"
    textOnColor: "#000000"
    model: ListModel{
        ListElement{
            val: "1";
            text_on: "On 1";
            text_off: "Off 1";
            image_on: "../images/internal_button_dn.bmp";
            image_off: "../images/internal_button_up.bmp"
            item_width: 60
            item_height: 40
        }
        ListElement{
            val: "2";
            text_on: "On 2";
            text_off: "Off 2";
            image_on: "../images/internal_button_dn.bmp";
            image_off: "../images/internal_button_up.bmp"
            item_width: 60
            item_height: 40
        }
    }

}
