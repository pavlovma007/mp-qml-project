/****************************************************************************
 **
 ** Copyright (C) 2013-2014 Reach Technology Inc.
 ** All rights reserved.
 **
 ** This code is protected by international copyright laws. This file may
 ** only be used in accordance with a license and cannot be used on
 ** hardware other than supplied by Reach Technology Inc. We appreciate
 ** your understanding and fairness.
 **
 ** Based on Chart.js
 **
 ** Chart.js
 ** http://chartjs.org/
 **
 ** Copyright 2013 Nick Downie
 ** Released under the MIT license
 ** https://github.com/nnnick/Chart.js/blob/master/LICENSE.md
 **
****************************************************************************/
import QtQuick 1.1

Canvas{
    width: 200
    height: 200
    //Boolean - Whether we should show a stroke on each segment
    property bool segmentShowStroke : true
    //String - The color of each segment stroke
    property string segmentStrokeColor : "#ffffff"
    //Number - The width of each segment stroke
    property int segmentStrokeWidth : 2
    //Number - The size of the doughnut hole
    property real percentageInnerCutout: 50.0
    //String - The Inner Cutout Color
    property string innerCutoutColor: "#ffffff"
    //Bool: - Whether we should show a legend
    property bool showLegend: true
    //String - Legend label font declaration for the legend label
    property string legendFontFamily : "'Arial'"
    //Number - Legend label font size in pixels
    property int legendFontSize : 10
    //Number - Legend Width
    property int legendWidth: 0
    //String - Legend label font weight style
    property string legendFontStyle : "normal"
    //String - Legend label font colour
    property string legendFontColor : "#000"

    property variant data : [
        {
            text: "Series 1",
            value: 30,
            color:"#F7464A"
        },
        {
            text: "Series 2",
            value : 50,
            color : "#E2EAE9"
        },
        {
            text: "Series 3",
            value : 100,
            color : "#D4CCC5"
        },
        {
            text: "Series 4",
            value : 40,
            color : "#949FB1"
        },
        {
            text: "Series 5",
            value : 120,
            color : "#4D5360"
        }

    ]

    onDataChanged: draw();

    function draw(){
        var ctx = getContext();

        ctx.clearRect(0, 0, width, height);

        if (showLegend)
           drawLegend(ctx);

        var segmentTotal = 0;

        //In case we have a canvas that is not a square. Minus 5 pixels as padding round the edge.
        var doughnutRadius = Math.min((height)/2, (width - legendWidth - legendFontSize*2)/2) - 5;

        //Now lets find our circle center
        var xCenter = Math.max((width - legendWidth)/2 , doughnutRadius) - 5;
        var yCenter = Math.max(height/2, doughnutRadius);

        var cutoutRadius = doughnutRadius * (percentageInnerCutout/100.0);

        for (var i=0; i<data.length; i++){
                segmentTotal += data[i].value;
        }

        var cumulativeAngle = -Math.PI/2,
        scaleAnimation = 1,
        rotateAnimation = 1;

        for (var i=0; i<data.length; i++){
                var segmentAngle = rotateAnimation * ((data[i].value/segmentTotal) * (Math.PI*2));
                ctx.beginPath();
                ctx.arc(xCenter, yCenter, scaleAnimation * doughnutRadius, cumulativeAngle, cumulativeAngle + segmentAngle, false);
                ctx.lineTo(xCenter, yCenter);
                ctx.closePath();
                ctx.fillStyle = data[i].color;
                ctx.fill();

                if(segmentShowStroke){
                        ctx.lineWidth = segmentStrokeWidth;
                        ctx.strokeStyle = segmentStrokeColor;
                        ctx.stroke();
                }
                cumulativeAngle += segmentAngle;
         }


         //Now we need to draw the hole in the middle
         ctx.fillStyle = innerCutoutColor;
         ctx.beginPath();
         ctx.arc(xCenter, yCenter, cutoutRadius, 0, Math.PI*2, true);
         ctx.fill();
         ctx.stroke();
    }

    function drawLegend(ctx)
    {
        ctx.font = legendFontStyle + ";" + legendFontSize + "px;" + legendFontFamily;
        legendWidth = 0;

        //first get the length of the legend
        var dataText = new Array();
        var dataLength = new Array();
        var dataColor = new Array();

        for (var i=0; i < data.length; i++)
        {
            dataText[i] = data[i].text;
            dataLength[i] = ctx.measureText(data[i].text) + legendFontSize;
            dataColor[i] = data[i].color;
            if (legendWidth < dataLength[i])
                legendWidth = dataLength[i];

        }

        var x = width - legendWidth;
        var y = (height - (i - 1) * legendFontSize)/2

        //Now lets place boxes and text to the right of the chart
        for (i=0; i < data.length; i++)
        {
            //Draw box
            ctx.fillStyle = dataColor[i];
            ctx.fillRect(x - legendFontSize - legendFontSize/2, y - legendFontSize, legendFontSize, legendFontSize);
            ctx.fillStyle = legendFontColor;
            ctx.textAlign = "left"
            ctx.fillText(dataText[i], x, y);
            y += legendFontSize + legendFontSize/2;
        }

    }


}

