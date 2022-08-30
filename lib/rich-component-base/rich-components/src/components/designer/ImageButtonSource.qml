import QtQuick 1.1
import "components"

ImageButton {
    id: image_button1
    x: 200
    y: 88
    width: 60
    height: 40
    text: "Test"
    imageUp: "images/internal_button_up.bmp"
    imageDown: "images/internal_button_dn.bmp"
    font.pixelSize: 18
    textColor: "#000000"
    font.bold: false
    font.family: "DejaVu Sans"
}
