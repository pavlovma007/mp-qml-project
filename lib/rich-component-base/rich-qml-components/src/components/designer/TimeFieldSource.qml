import QtQuick 2.0
import "components"

TimeField {
    width: 160
    height: 36
    timeFontColor: "#000000"
    borderColor: "#ffffff"
    labelFontBold: false
    labelFontFamily: "DejaVu Sans"
    inputFontFamily: "DejaVu Sans"
    fieldSpacing: 10
    labelText: "Time"
    labelFontPixelSize: 15
    inputFontPixelSize: 15
    showPeriod: true
    showSeconds: true
    hours: 12
    minutes: 0
    seconds: 0
    period: "PM"
    timeFont.pixelSize: 18
    timeFont.bold: true
    timeFont.family: "DejaVu Sans"
    caption: "System Time"
    captionFontColor: "#ffffff"
    captionFont.family: "DejaVu Sans"
    captionFont.pixelSize: 20
    captionFont.bold: true
    borderWidth: 2
    borderRadius: 4
    spacing: 10
    backgroundColor: "#424242"
    buttonBackgroundColor: "#bbb7bb"
    buttonFontColor: "#000000"
    buttonFont.pixelSize: 15
    buttonFont.bold: false
    buttonFont.family: "DejaVu Sans"
}


