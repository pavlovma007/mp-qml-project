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
    id: graph
    width: 400
    height: 200
    property bool scaleOverride : false
    //** Required if scaleOverride is true **
    //Number - The number of steps in a hard coded scale
    property int scaleSteps : 0
    //Number - The value jump in the hard coded scale
    property int scaleStepWidth : 0
    //Number - The scale starting value
    property int scaleStartValue : minYValue
    //String - Color of the scale line - x and y axis lines
    property string scaleLineColor : "rgba(0,0,0,1.0)"
    //Number - Pixel width of the scale line
    property int scaleLineWidth : 1
    //Boolean - Whether to show labels on the scale
    property bool scaleShowLabels : true
    //Interpolated JS string - can access value
    property string scaleLabel : "<%=value%>"
    //String - Scale label font declaration for the scale label
    property string  scaleFontFamily : "DejaVu Sans"
    //Number - Scale label font size in pixels
    property int scaleFontSize : 12
    //String - Scale label font weight style
    property string scaleFontStyle : "normal"
    //String - Scale label font color
    property string scaleFontColor : "#666"
    //Boolean - Whether grid lines are shown across the chart
    property bool scaleShowGridLines : true
    //String - Color of the grid lines
    property string scaleGridLineColor : "rgba(50,205,50,0.5)"
    //Number - Width of the grid lines
    property int scaleGridLineWidth : 1
    //Number - Pixel width of dataset stroke
    property int datasetStrokeWidth : 2
    //String - Color of the line1
    property string line1PenColor : "#ffffff"
    //String - Color of the line2
    property string line2PenColor
    //String - Color of the line3
    property string line3PenColor
    //String - Color of the line4
    property string line4PenColor
    property variant overlay
    //Number - maximum value for the amplitude
    property int maxYValue: 10
    //Number - minimum value for the amplitude
    property int minYValue: -10
    //String - background color of the scale
    property string scaleBgColor: "#0000000"
    //String - background color for the chart
    property string bgColor: "#EEEEEE"
    //String - background image for the chart
    property alias bgImage: imageBackground.source
    //Boolean - Whether to show a dot for each point
    property bool drawPoints: false
    //Number - Radius of each point dot in pixels
    property int pointRadius: 2
    //bool - Whether to draw line from point to point
    property bool drawLines: true
    //bool - Whether to draw a smooth curved line
    property bool bezierCurve: true
    property int xAxisPosY: 0
    property int yAxisPosX: 0
    property int  xAxisLength: 0
    property int scaleHop: 0
    property real valueHop: 0
    property variant calculatedScale
    property string currentValue1
    property string currentValue2
    property string currentValue3
    property string currentValue4
    property variant pointData1
    property variant pointData2
    property variant pointData3
    property variant pointData4
    property int lastX1
    property int lastY1
    property int lastX2
    property int lastY2
    property int lastX3
    property int lastY3
    property int lastX4
    property int lastY4
    property bool completed: false
    property variant ctx
    property int minX: 0
    property int minY: 0
    property int maxX: 0
    property int maxY: 0
    property int scaleHeight: 0
    property int topY: 0
    color: "transparent"
    property variant xLabels
    property int xScale: Math.abs(maxX - minX)

    function draw()
    {
        if (bgColor.length > 0)
        {
            ctx.fillStyle = bgColor;
            ctx.fillRect(0,0, width, height);
        }

        var calculatedScale, maxSize, labelHeight, valueBounds, labelTemplateString, widestXLabel, rotateLabels = 0;

        calculateDrawingSizes();

        valueBounds = getValueBounds();
        //Check and set the scale
        labelTemplateString = (scaleShowLabels)? scaleLabel : "";
        if (!scaleOverride){

                calculatedScale = calculateScale(scaleHeight,valueBounds.maxSteps,valueBounds.minSteps,valueBounds.maxValue,valueBounds.minValue,labelTemplateString);
        }
        else {
                calculatedScale = {
                        steps : scaleSteps,
                        stepValue : scaleStepWidth,
                        graphMin : scaleStartValue,
                        labels : []
                }
                populateLabels(labelTemplateString, calculatedScale.labels,calculatedScale.steps, scaleStartValue, scaleStepWidth);
        }

        graph.calculatedScale = calculatedScale;

        scaleHop = Math.floor(scaleHeight/calculatedScale.steps);
        calculateXAxisSize();

        drawScale();


        function calculateDrawingSizes(){
            maxSize = height;
            //Need to check the X axis first - measure the length of each text metric, and figure out if we need to rotate by 45 degrees.
            ctx.font = scaleFontStyle + ";" + scaleFontSize+"px;" + scaleFontFamily;
            widestXLabel = 1;
            for (var i=0; i<xLabels.length; i++){
                /* updated */
                var textLength = ctx.measureText(xLabels[i]);
                //If the text length is longer - make that equal to longest text!
                widestXLabel = (textLength > widestXLabel)? textLength : widestXLabel;
            }
            if (width/xLabels.length < widestXLabel){
                rotateLabels = 45;
                if (width/data.labels.length < Math.cos(rotateLabels) * widestXLabel){
                    rotateLabels = 90;
                    maxSize -= widestXLabel;
                }
                else{
                    maxSize -= Math.sin(rotateLabels) * widestXLabel;
                }
            }
            else{
                maxSize -= scaleFontSize;
            }

            //Add a little padding between the x line and the text
            maxSize -= 10;
            labelHeight = scaleFontSize;
            maxSize -= labelHeight;
            scaleHeight = maxSize;
        };

        function getValueBounds() {
            var upperValue = maxYValue;
            var lowerValue = minYValue;

            var maxSteps = Math.floor((scaleHeight / (labelHeight*0.66)));
            var minSteps = Math.floor((scaleHeight / labelHeight*0.5));


            return {
                maxValue : upperValue,
                minValue : lowerValue,
                maxSteps : maxSteps,
                minSteps : minSteps
            }
        }

        function calculateScale(drawingHeight,maxSteps,minSteps,maxValue,minValue,labelTemplateString){
            var graphMin,graphMax,graphRange,stepValue,numberOfSteps,valueRange,rangeOrderOfMagnitude,decimalNum;

            valueRange = maxValue - minValue;
            rangeOrderOfMagnitude = calculateOrderOfMagnitude(valueRange);
            graphMin = minValue
            graphMax = maxValue
            graphRange = graphMax - graphMin;
            stepValue = Math.pow(10, rangeOrderOfMagnitude);
            numberOfSteps = Math.round(graphRange / stepValue);

            //Compare number of steps to the max and min for that size graph, and add in half steps if need be.
            while(numberOfSteps < minSteps || numberOfSteps > maxSteps) {
                if (numberOfSteps < minSteps){
                    stepValue /= 2;
                    numberOfSteps = Math.round(graphRange/stepValue);
                }
                else{
                    stepValue *=2;
                    numberOfSteps = Math.round(graphRange/stepValue);
                }
            };

            var labels = [];
            populateLabels(labelTemplateString, labels, numberOfSteps, graphMin, stepValue);

            return {
                steps : numberOfSteps,
                stepValue : stepValue,
                graphMin : graphMin,
                labels : labels

            }

            function calculateOrderOfMagnitude(val){
                return Math.floor(Math.log(val) / Math.LN10);
            }

        }

        //Populate an array of all the labels by interpolating the string.
        function populateLabels(labelTemplateString, labels, numberOfSteps, graphMin, stepValue) {
            if (labelTemplateString) {
                //Fix floating point errors by setting to fixed the on the same decimal as the stepValue.
                for (var i = 1; i < numberOfSteps + 1; i++) {
                    labels.push(tmpl(labelTemplateString, {value: (graphMin + (stepValue * i)).toFixed(getDecimalPlaces(stepValue))}));
                }
            }
        }


        function calculateXAxisSize(){
            var longestText = 1;
            //if we are showing the labels
            if (scaleShowLabels){
                ctx.font = scaleFontStyle + ";" + scaleFontSize+"px;" + scaleFontFamily;
                for (var i=0; i < calculatedScale.steps; i++)
                {
                    var measuredText = ctx.measureText(calculatedScale.labels[i]);
                    longestText = (measuredText > longestText)? measuredText : longestText;
                }

                //Add a little extra padding from the y axis
                longestText +=10;
            }

            //Add some padding for the right most data point
            widestXLabel += widestXLabel/2;
            xAxisLength = width - longestText - widestXLabel
            valueHop = xAxisLength/(xLabels.length-1);
            yAxisPosX = width-(widestXLabel/2)-xAxisLength;
            xAxisPosY = scaleHeight + scaleFontSize/2;
        }


        function drawScale(){
                //Fill background
                ctx.fillStyle = scaleBgColor;
                ctx.fillRect(yAxisPosX, xAxisPosY, xAxisLength -(valueHop/xScale) + scaleLineWidth, - (calculatedScale.steps * scaleHop) - scaleLineWidth);

                topY = height - (height - xAxisPosY + (calculatedScale.steps * scaleHop)-scaleLineWidth);

                //X axis line
                ctx.lineWidth = scaleLineWidth;
                ctx.strokeStyle = scaleLineColor;
                ctx.beginPath();
                ctx.moveTo(width-widestXLabel/2,xAxisPosY);
                ctx.lineTo(width-(widestXLabel/2)-xAxisLength-3,xAxisPosY);
                ctx.stroke();

                if (rotateLabels > 0){
                        ctx.save();
                        ctx.textAlign = "right";
                }
                else{
                        ctx.textAlign = "center";
                }
                ctx.fillStyle = scaleFontColor;

                for (var i=0; i<xLabels.length; i++){
                        ctx.save();
                        if (rotateLabels > 0  && scaleShowLabels){
                                ctx.translate(yAxisPosX + i*valueHop,xAxisPosY + scaleFontSize);
                                ctx.rotate(-(rotateLabels * (Math.PI/180)));
                                ctx.fillText(xLabels[i], 0,0);
                                ctx.restore();
                        }
                        else if (scaleShowLabels){
                                ctx.fillText(xLabels[i], yAxisPosX + i*valueHop,xAxisPosY + scaleFontSize+3);
                        }

                        ctx.beginPath();
                        ctx.moveTo(yAxisPosX + (i*valueHop), xAxisPosY+3);

                        //Check i isnt 0, so we dont go over the Y axis twice.
                        if(scaleShowGridLines && i>0){
                                ctx.lineWidth = scaleGridLineWidth;
                                ctx.strokeStyle = scaleGridLineColor;
                                ctx.lineTo(yAxisPosX + (i*valueHop), 5);
                        }                      
                        ctx.stroke();
                }
                //Y axis
                ctx.lineWidth = scaleLineWidth;
                ctx.strokeStyle = scaleLineColor;
                ctx.beginPath();
                ctx.moveTo(yAxisPosX,xAxisPosY+5);
                ctx.lineTo(yAxisPosX,5);
                ctx.stroke();

                ctx.textAlign = "right";
                ctx.textBaseline = "middle";
                for (var j=0; j<calculatedScale.steps; j++){
                        ctx.beginPath();
                        ctx.moveTo(yAxisPosX-3,xAxisPosY - ((j+1) * scaleHop));
                        if (scaleShowGridLines){
                            ctx.lineWidth = scaleGridLineWidth;
                            ctx.strokeStyle = scaleGridLineColor;
                            ctx.lineTo(yAxisPosX + xAxisLength, xAxisPosY - ((j+1) * scaleHop));
                        }                       
                        ctx.stroke();
                        if (scaleShowLabels){
                                ctx.fillText(calculatedScale.labels[j], yAxisPosX-8,xAxisPosY - ((j+1) * scaleHop) + scaleFontSize/2);
                        }
                }


        }

    /* end draw */
    }


    function drawLine(lastX, lastY, linePenColor, pointData)
    {
        ctx.strokeStyle = linePenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();
        ctx.moveTo(lastX, lastY);

        lastX = xPos(pointData.get(pointData.count-1).x);
        lastY = yPos(pointData.count-1, pointData);

        if (drawLines)
        {
            if (bezierCurve && pointData.count > 1)
            {
                ctx.bezierCurveTo(getControlXPosition(pointData.get(pointData.count-2).x, pointData.get(pointData.count-1).x), yPos(pointData.count-2, pointData), getControlXPosition(pointData.get(pointData.count-2).x, pointData.get(pointData.count-1).x), lastY, lastX, lastY);
            }
            else
                ctx.lineTo(lastX,lastY);
            ctx.stroke();
        }

        return {
            lastX: lastX,
            lastY: lastY
        }
    }

    function drawPoint(x, y, linePenColor) {
        ctx.fillStyle = linePenColor;
        ctx.strokeStyle = linePenColor;
        ctx.lineWidth = datasetStrokeWidth;

        ctx.beginPath();
        ctx.arc(x, y, pointRadius, 0, Math.PI*2, false);
        ctx.fill();
        ctx.stroke();
    }

    function isNumber(n) {
            return !isNaN(parseFloat(n)) && isFinite(n);
    }

    function getDecimalPlaces (num){
            var numberOfDecimalPlaces;
            if (num%1!=0){
                    return num.toString().split(".")[1].length
            }
            else{
                    return 0;
            }

    }

    //Javascript micro templating by John Resig - source at http://ejohn.org/blog/javascript-micro-templating/
    property variant cache : []

    function tmpl(str, data){
        // Figure out if we're getting a template, or if we need to
        // load the template - and be sure to cache the result.
        var fn = !/\W/.test(str) ?
          cache[str] = cache[str] ||
            tmpl(document.getElementById(str).innerHTML) :

          // Generate a reusable function that will serve as a template
          // generator (and which will be cached).
          new Function("obj",
            "var p=[],print=function(){p.push.apply(p,arguments);};" +

            // Introduce the data as local variables using with(){}
            "with(obj){p.push('" +

            // Convert the template into pure JavaScript
            str
              .replace(/[\r\t\n]/g, " ")
              .split("<%").join("\t")
              .replace(/((^|%>)[^\t]*)'/g, "$1\r")
              .replace(/\t=(.*?)%>/g, "',$1,'")
              .split("\t").join("');")
              .split("%>").join("p.push('")
              .split("\r").join("\\'")
          + "');}return p.join('');");

        // Provide some basic currying to the user
        return data ? fn( data ) : fn;
      }


    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    function getControlXPosition(i1, i2)
    {
        i1 = i1 - minX
        i2 = i2 - minX
        return yAxisPosX + ((valueHop * i1) + (valueHop * i2))/2
    }

    function xPos(x){
            //adjust x
            var xAdjusted = 1;
            if (minX < 0)
                xAdjusted = Math.abs(minX) + parseInt(x);
            else
                xAdjusted = parseInt(x) - minX;
            return yAxisPosX + (valueHop * xAdjusted);
    }

    function yPos(iteration, pointData){
            return xAxisPosY - calculateOffset(pointData.get(iteration).y,calculatedScale,scaleHop);
    }

    function capValue(valueToCap, maxValue, minValue){
            if (isNumber(maxValue) && valueToCap > maxValue)
                return maxValue;
            else if (isNumber(minValue) && valueToCap < minValue)
                return minValue;
            else
                return valueToCap;
    }

    function calculateOffset(val,calculatedScale,scaleHop){
        var outerValue = calculatedScale.steps * calculatedScale.stepValue;
        var adjustedValue = val - calculatedScale.graphMin;
        var scalingFactor = capValue(adjustedValue/outerValue,1,0);
        return (scaleHop*calculatedScale.steps) * scalingFactor;
    }


    onCurrentValue1Changed: {
        if (completed && currentValue1 !== (maxY+1).toString())
        {
            var values = currentValue1.split(",");
            if (values.length > 1)
            {
                var d = {'x': values[0], 'y' : values[1]};
                if (parseFloat(values[0]) > maxX || parseFloat(values[0]) < minX)
                    return;

                if (parseFloat(values[1]) > maxY || parseFloat(values[1]) < minY)
                    return;

                if (pointData1.count === 0)
                {
                    pointData1.append(d);
                    lastX1 = xPos(pointData1.get(0).x);
                    lastY1 = yPos(pointData1.count-1, pointData1);
                }
                else
                {
                    pointData1.append(d);
                    var draw = drawLine(lastX1, lastY1, line1PenColor, pointData1);
                    lastX1 = draw.lastX;
                    lastY1 = draw.lastY;
                }

                if (drawPoints)
                    drawPoint(lastX1, lastY1, line1PenColor)
            }

            //To force the onChange event in the future
            currentValue1 = (maxY + 1).toString();
        }
    }

    onCurrentValue2Changed: {
        if (completed && currentValue2 !== (maxY+1).toString())
        {
            var values = currentValue2.split(",");
            if (values.length > 1)
            {
                var d = {'x': values[0], 'y' : values[1]};
                if (parseFloat(values[0]) > maxX || parseFloat(values[0]) < minX)
                    return;

                if (parseFloat(values[1]) > maxY || parseFloat(values[1]) < minY)
                    return;

                if (pointData2.count === 0)
                {
                    pointData2.append(d);
                    lastX2 = xPos(pointData2.get(0).x);
                    lastY2 = yPos(pointData2.count-1, pointData2);
                }
                else
                {
                    pointData2.append(d);
                    var draw = drawLine(lastX2, lastY2, line2PenColor, pointData2);
                    lastX2 = draw.lastX;
                    lastY2 = draw.lastY;
                }
                if (drawPoints)
                    drawPoint(lastX2, lastY2, line2PenColor)
            }

            //To force the onChange event in the future
            currentValue2 = (maxY + 1).toString();
        }
    }

    onCurrentValue3Changed: {
        if (completed && currentValue3 !== (maxY+1).toString())
        {
            var values = currentValue3.split(",");
            if (values.length > 1)
            {
                var d = {'x': values[0], 'y' : values[1]};
                if (parseFloat(values[0]) > maxX || parseFloat(values[0]) < minX)
                    return;

                if (parseFloat(values[1]) > maxY || parseFloat(values[1]) < minY)
                    return;

                if (pointData3.count === 0)
                {
                    pointData3.append(d);
                    lastX3 = xPos(pointData3.get(0).x);
                    lastY3 = yPos(pointData3.count-1, pointData3);
                }
                else
                {
                    pointData3.append(d);
                    var draw = drawLine(lastX3, lastY3, line3PenColor, pointData3);
                    lastX3 = draw.lastX;
                    lastY3 = draw.lastY;
                }
                if (drawPoints)
                    drawPoint(lastX3, lastY3, line3PenColor)
            }

            //To force the onChange event in the future
            currentValue3 = (maxY + 1).toString();
        }
    }

    onCurrentValue4Changed: {
        if (completed && currentValue4 !== (maxY+1).toString())
        {
            var values = currentValue4.split(",");
            if (values.length > 1)
            {
                var d = {'x': values[0], 'y' : values[1]};
                if (parseFloat(values[0]) > maxX || parseFloat(values[0]) < minX)
                    return;

                if (parseFloat(values[1]) > maxY || parseFloat(values[1]) < minY)
                    return;

                if (pointData4.count === 0)
                {
                    pointData4.append(d);
                    lastX4 = xPos(pointData4.get(0).x);
                    lastY4 = yPos(pointData4.count-1, pointData4);
                }
                else
                {
                    pointData4.append(d);
                    var draw = drawLine(lastX4, lastY4, line4PenColor, pointData4);
                    lastX4 = draw.lastX;
                    lastY4 = draw.lastY;
                }
                if (drawPoints)
                    drawPoint(lastX4, lastY4, line4PenColor)
            }

            //To force the onChange event in the future
            currentValue4 = (maxY + 1).toString();
        }
    }

    Image{
        id: imageBackground
        visible: false
        width: graph.width
        height: graph.height
    }

    function returnLabels()
    {
        var tmp = [];
        tmp.push(minX.toString());
        var inc = xScale/10;
        var val = minX;

        for (var i=0; i < 9; i++)
        {
            val += inc;
            tmp.push(val.toString());
        }

        tmp.push(maxX.toString());
        return tmp;
    }

    function clearPens()
    {
        draw();
        pointData1.clear();
        if (typeof pointData2 !== 'undefined')
            pointData2.clear();
        if (typeof pointData3 !== 'undefined')
            pointData3.clear();
        if (typeof pointData4 !== 'undefined')
            pointData4.clear();
        valueHop = xAxisLength/xScale;
        completed = true;
    }

    Component.onCompleted: {
        ctx = getContext();
        xLabels = returnLabels();

        var src = "import QtQuick 1.1; ListModel {}";
        pointData1 = Qt.createQmlObject(src, graph, "data1");
        if (line2PenColor.length > 0)
            pointData2 = Qt.createQmlObject(src, graph, "data2");

        if (line3PenColor.length > 0)
            pointData3 = Qt.createQmlObject(src, graph, "data3");

        if (line4PenColor.length > 0)
            pointData4 = Qt.createQmlObject(src, graph, "data4");

        if (imageBackground.source.toString().length > 0)
        {
            var imageSrc = "import QtQuick 1.1; Image{z: -10; width: graph.width; height: graph.height; source:\"" + imageBackground.source + "\"}";
            Qt.createQmlObject(imageSrc, graph, "bgImage");
        }

        draw();
        valueHop = xAxisLength/xScale;
        completed = true;
    }
}


