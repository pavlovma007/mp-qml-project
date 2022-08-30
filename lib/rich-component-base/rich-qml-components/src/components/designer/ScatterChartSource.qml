import QtQuick 2.0
import "components"

ScatterChart{
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
    minX: 0
    maxX: 100
    scaleBgColor: "#000000"
    bgColor: "#EEEEEE"
    line1PenColor: "#ffffff"
    drawLines: true;
    drawPoints: false
    pointRadius: 2
    bezierCurve: true
}
