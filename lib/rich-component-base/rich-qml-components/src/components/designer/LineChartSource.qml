import QtQuick 2.0
import "components"

LineChart {
    width: 440
    height: 180
    scaleOverlay : true
    scaleLineColor : "rgba(0,0,0,0.1)"
    scaleLineWidth : 1
    scaleShowLabels : true
    scaleLabel : "<%=value%>"
    scaleFontSize: 10
    scaleFontFamily : "DejaVu Sans"
    scaleFontStyle : "normal"
    scaleFontColor : "#666"
    scaleShowGridLines : true
    scaleGridLineColor : "rgba(0,0,0,0.05)"
    scaleGridLineWidth : 1
    showLegend : true
    bezierCurve : true
    pointDot : true
    pointDotRadius : 4
    pointDotStrokeWidth : 2
    datasetStroke : true
    datasetStrokeWidth : 2
    datasetFill : true
}
