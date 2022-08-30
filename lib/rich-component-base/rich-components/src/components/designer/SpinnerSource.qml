import QtQuick 1.1
import "components"

Spinner {
    id: spinner1
    width: 90
    height: 216
    color: "#ffffff"
    radius: 2
    font.pixelSize: 24
    textColor: "#000000"
    initialIndex: 0
    border.color: "#000000"
    border.width: 3
    backGroundImage: "images/spinner-bg.png"
    font.family: "DejaVu Sans"
    font.bold: false
    highlightImage: "images/spinner-select.png"
    itemHeight: 34

    model:  ListModel{
        ListElement{ text: "1"; value: 1}
        ListElement{ text: "2"; value: 2}
        ListElement{ text: "3"; value: 3}
        ListElement{ text: "4"; value: 4}
        ListElement{ text: "5"; value: 5}
        ListElement{ text: "6"; value: 6}
        ListElement{ text: "7"; value: 7}
        ListElement{ text: "8"; value: 8}
        ListElement{ text: "9"; value: 9}
        ListElement{ text: "10"; value: 10}
    }
}
