import QtQuick 2.0
import "components"

DateField {
    width: 160
    height: 36
    year: 2015
    day: 1;
    month: 1;
    dateFontColor: "#000000"
    borderColor: "#ffffff"
    labelFontBold: false
    labelFontFamily: "DejaVu Sans"
    inputFontFamily: "DejaVu Sans"
    fieldSpacing: 8
    labelText: "Date"
    labelFontPixelSize: 15
    inputFontPixelSize: 15
    dateFont.pixelSize: 18
    dateFont.bold: true
    dateFont.family: "DejaVu Sans"
    caption: "System Date"
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
    dateMask: "mon dd yyyy"
    minYear: 2000
    maxYear: 2030
}

