import QtQuick 2.0
import "components"

StripChart{
    width: 400
    height: 200
    scaleLineColor : "rgba(0,0,0,1.0)"
    scaleLineWidth : 1
    scaleShowLabels : true
    scaleLabel : "<%=value%>"
    scaleFontFamily : "DejaVu Sans"
    scaleFontSize : 12
    scaleFontStyle : "normal"
    scaleFontColor : "#666"
    scaleShowGridLines : true
    scaleGridLineColor : "rgba(50,205,50,0.5)"
    scaleGridLineWidth : 1
    datasetStrokeWidth : 2
    maxYValue: 10
    minYValue: -10
    scaleBgColor: "#000000"
    bgColor: "#EEEEEE"
    minTime: 0
    maxTime: 100
    line1PenColor: "#ffffff"
}
