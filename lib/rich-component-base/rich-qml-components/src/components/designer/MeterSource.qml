import QtQuick 2.0
import "components"

Meter{
    width: 280
    height: 140
    backGroundColor: "transparent"
    markerWidth: 10
    startOfGreenMarker: 100
    endOfGreenMarker: 140
    endOfOrangeMarker: 180
    textRadius: 10
    textFontColor: "#000000"
    textFontPixelSize: 12
    textFontFamily: "DejaVu Sans"
    textFontStyle: "normal"
    tickSize: 14
    needleColor: "#FF0000"
    needleLength: 78
    initialValue: 100
    min: 100
    max: 200
    tickInterval: 20
    imageBase: "images/meter/background.svg"
    imageCenter: "images/meter/center.png"

}
