import QtQuick 1.1
import "components"

BarChart {
    id: barChart
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
    barShowStroke : true
    barStrokeWidth : 2
    barValueSpacing : 5
    barDatasetSpacing : 1
    showLegend : true
}
