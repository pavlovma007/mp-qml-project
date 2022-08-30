import QtQuick 1.1
import "components"

DoughnutChart{
    id: doughnutChart
    width: 200
    height: 200
    segmentShowStroke : true
    segmentStrokeColor : "#ffffff"
    segmentStrokeWidth : 2
    percentageInnerCutout: 50.0
    innerCutoutColor: "#ffffff"
    showLegend: true
    legendFontFamily : "DejaVu Sans"
    legendFontSize : 10
    legendFontStyle : "normal"
    legendFontColor : "#000"
}

