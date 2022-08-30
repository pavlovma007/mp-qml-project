import QtQuick 2.0
import "components"

GaugeIndicator{
    width: 250
    height: 250
    backGroundColor: "transparent"
    needleColor: "#FF0000"
    needleLength: 82
    tickSize: 8
    tickInterval: 10
    textRadius: 18
    textFontColor: "#000000"
    textFontPixelSize: 12
    textFontFamily: "DejaVu Sans"
    textFontStyle: "normal"
    imageBase: "images/gauge/background.svg"
    imageCenter: "images/gauge/center.svg"
    outerCircleColor: "transparent"
    initialValue: 0
    min: 0
    max: 100
}
