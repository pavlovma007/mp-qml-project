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
import "../js/scopechart.js" as Data

Canvas{
    id: graph
    width: 400
    height: 200
    property bool scaleOverlay : false
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
    property variant data
    //Number - maximum value for the amplitude
    property int maxYValue: 10
    //Number - minimum value for the amplitude
    property int minYValue: -10
    //String - background color of the scale
    property string scaleBgColor: "#0000000"
    //String - background color for the chart
    property string bgColor: "#EEEEEE"
    //Number - the distance between the new line and the old line
    property int xPixels : 20;
    //String - background image for the chart
    property alias bgImage: imageBackground.source
    //bool - Whether to draw a smooth curved line
    property bool bezierCurve: true
    property int xAxisPosY: 0
    property int yAxisPosX: 0
    property int  xAxisLength: 0
    property int scaleHop: 0
    property real valueHop: 0
    property variant calculatedScale
    property real currentValue1
    property real currentValue2
    property real currentValue3
    property real currentValue4
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
    property variant overlayCtx
    property int minXTime: 0
    property int minYTime: 0
    property int maxXTime: 0
    property int maxYTime: 0
    property int minTime: 0
    property int maxTime: 100
    property int scaleHeight: 0
    property int topY: 0
    property bool blankOut: false
    property int xScale: Math.abs(maxTime - minTime)
    color: "transparent"

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
            for (var i=0; i<data.labels.length; i++){
                /* updated */
                var textLength = ctx.measureText(data.labels[i]);
                //If the text length is longer - make that equal to longest text!
                widestXLabel = (textLength > widestXLabel)? textLength : widestXLabel;
            }
            if (width/data.labels.length < widestXLabel){
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
            maxSize -= 5;
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

            //graphMin = Math.floor(minValue / (1 * Math.pow(10, rangeOrderOfMagnitude))) * Math.pow(10, rangeOrderOfMagnitude);
            graphMin = minValue

            //graphMax = Math.ceil(maxValue / (1 * Math.pow(10, rangeOrderOfMagnitude))) * Math.pow(10, rangeOrderOfMagnitude);
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
            xAxisLength = width - longestText - widestXLabel;
            valueHop = xAxisLength/10;
            yAxisPosX = width-widestXLabel/2-xAxisLength;
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

                for (var i=0; i<data.labels.length; i++){
                        ctx.save();
                        if (rotateLabels > 0  && scaleShowLabels){
                                ctx.translate(yAxisPosX + i*valueHop,xAxisPosY + scaleFontSize);
                                ctx.rotate(-(rotateLabels * (Math.PI/180)));
                                ctx.fillText(data.labels[i], 0,0);
                                ctx.restore();
                        }

                        else if (scaleShowLabels){
                                ctx.fillText(data.labels[i], yAxisPosX + i*valueHop,xAxisPosY + scaleFontSize+3);
                        }


                        //Check i isnt 0, so we dont go over the Y axis twice.
                        if(scaleShowGridLines && i>0){
                                overlayCtx.beginPath();
                                overlayCtx.moveTo(yAxisPosX + (i * valueHop) + scaleLineWidth, xAxisPosY+3);
                                overlayCtx.lineWidth = scaleGridLineWidth;
                                overlayCtx.strokeStyle = scaleGridLineColor;
                                overlayCtx.lineTo(yAxisPosX + (i * valueHop) + scaleLineWidth, 5);
                                overlayCtx.stroke();
                        }
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
                        if (scaleShowGridLines){
                            overlayCtx.lineWidth = scaleGridLineWidth;
                            overlayCtx.strokeStyle = scaleGridLineColor;
                            overlayCtx.beginPath();
                            overlayCtx.moveTo(yAxisPosX-3,xAxisPosY - ((j+1) * scaleHop));
                            overlayCtx.lineTo(yAxisPosX + xAxisLength, xAxisPosY - ((j+1) * scaleHop));
                            overlayCtx.stroke();
                        }

                        if (scaleShowLabels){
                                ctx.fillText(calculatedScale.labels[j], yAxisPosX-8,xAxisPosY - ((j+1) * scaleHop) + scaleFontSize/2);
                        }
                }
        /* end draw scale */
        }

    /* end draw */
    }

    function drawLine(lastX, lastY, linePenColor, pointData)
    {
        ctx.strokeStyle = linePenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();
        if (lastX === 0)
        {
            ctx.moveTo(yAxisPosX + scaleLineWidth, xAxisPosY - (calculateOffset(lastY ,calculatedScale,scaleHop)))
        }
        else
        {
            ctx.moveTo(lastX, lastY);
        }

        lastX = xPos(pointData.count-1);
        lastY = yPos(pointData.count-1, pointData);

        if (bezierCurve && pointData.count > 1)
            ctx.bezierCurveTo(xPos(pointData.count-1.5), yPos(pointData.count-2, pointData), xPos(pointData.count-1.5), lastY, lastX, lastY);
        else
            ctx.lineTo(lastX,lastY);

        ctx.stroke();

        return {
            lastX: lastX,
            lastY: lastY
        }
    }

    function updateTime()
    {
        //Clear the rect
        ctx.fillStyle = bgColor;
        ctx.fillRect(0, xAxisPosY, width, xAxisPosY);

        ctx.lineWidth = scaleLineWidth;
        ctx.strokeStyle = scaleLineColor;

        minTime += 1;
        maxTime += 1;

        //Now write out new times
        ctx.textAlign = "center";
        ctx.fillStyle = scaleFontColor;
        ctx.fillText(minTime.toString(), minXTime, minYTime);
        ctx.fillText(maxTime.toString(), maxXTime-5, maxYTime);
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

    function xPos(iteration){
            return yAxisPosX + (valueHop * iteration);
    }

    function yPos(iteration, pointData){
            return xAxisPosY - calculateOffset(pointData.get(iteration).value,calculatedScale,scaleHop);
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


    function valueChanged(pointData, currentValue, linePenColor, lastX, lastY, clear)
    {
        if (pointData.count === 0)
        {
            lastX = 0;
            lastY = currentValue;
            var d = {'value': currentValue};
            pointData.append(d);
        }
        else if (pointData.count < xScale)
        {
            var d = {'value': currentValue};
            pointData.append(d);

            if (blankOut && clear)
            {
                //var end = xAxisLength + yAxisPosX - scaleLineWidth*2;
                var end = xAxisLength + yAxisPosX;
                var distance = xPixels;
                if (xPos(pointData.count-1) + xPixels > end)
                    distance = end - xPos(pointData.count-1);

                if (imageBackground.source.toString().length > 0)
                    ctx.clearRect(xPos(pointData.count-1), topY-datasetStrokeWidth, distance+2, (calculatedScale.steps * scaleHop) + 2*datasetStrokeWidth);
                else
                {
                    ctx.fillStyle = scaleBgColor;
                    ctx.fillRect(xPos(pointData.count-1), xAxisPosY, distance, - (calculatedScale.steps * scaleHop) - scaleLineWidth);
                }
                if (scaleShowLabels)
                    updateTime();
            }

            var draw = drawLine(lastX, lastY, linePenColor, pointData);
            lastX = draw.lastX;
            lastY = draw.lastY;
        }
        else{
            var d = {'value': currentValue};
            pointData.append(d);
            var draw = drawLine(lastX, lastY, linePenColor, pointData);

            lastX = 0;
            lastY = currentValue;

            pointData.clear();
            pointData.append(d);

            if (clear)
            {
                if (imageBackground.source.toString().length > 0)
                    ctx.clearRect(xPos(pointData.count-1), topY-datasetStrokeWidth, distance+2, (calculatedScale.steps * scaleHop) + 2*datasetStrokeWidth);
                else
                {
                    ctx.fillStyle = scaleBgColor;
                    ctx.fillRect(xPos(0), xAxisPosY, xPixels, - (calculatedScale.steps * scaleHop));
                }

                if (scaleShowLabels)
                    updateTime();

                blankOut = true;
            }
        }

        return {
            lastX: lastX,
            lastY: lastY
        }

    }

    onCurrentValue1Changed: {
        if (completed && currentValue1 != maxYValue+1)
        {
            var data = valueChanged(pointData1, currentValue1, line1PenColor, lastX1, lastY1, true);
            lastX1 = data.lastX;
            lastY1 = data.lastY;
            //To force the onChange event in the future
            currentValue1 = maxYValue + 1;
        }
    }

    onCurrentValue2Changed: {
        if (completed && currentValue2 != maxYValue+1)
        {
            var data = valueChanged(pointData2, currentValue2, line2PenColor, lastX2, lastY2, false)
            lastX2 = data.lastX;
            lastY2 = data.lastY;
            //To force the onChange event in the future
            currentValue2 = maxYValue + 1;
        }
    }

    onCurrentValue3Changed: {
        if (completed && currentValue3 != maxYValue+1)
        {
            var data = valueChanged(pointData3, currentValue3, line3PenColor, lastX3, lastY3, false)
            lastX3 = data.lastX;
            lastY3 = data.lastY;
            //To force the onChange event in the future
            currentValue3 = maxYValue + 1;
        }
    }

    onCurrentValue4Changed: {
        if (completed && currentValue4 != maxYValue+1)
        {
            var data = valueChanged(pointData4, currentValue4, line4PenColor, lastX4, lastY4, false)
            lastX4 = data.lastX;
            lastY4 = data.lastY;
            //To force the onChange event in the future
            currentValue4 = maxYValue + 1;
        }
    }

    Image{
        id: imageBackground
        visible: false
        width: graph.width
        height: graph.height
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
        data = Data.lineData;
        //Update data
        data.labels[0] = minTime.toString();
        data.labels[9] = maxTime.toString();

        if (scaleShowGridLines)
        {
            var canvasSrc = "import QtQuick 1.1; Canvas {id:overlay; z:100; color: \"transparent\"; anchors.fill: parent}";
            overlay = Qt.createQmlObject(canvasSrc, graph, "canvasObject");
            overlayCtx = overlay.getContext();
        }

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

        valueHop = xAxisLength/(xScale);
        xPixels = Math.max(xPixels, Math.floor(valueHop));

        currentValue1 = maxYValue + 1;
        currentValue2 = maxYValue + 1;
        currentValue3 = maxYValue + 1;
        currentValue4 = maxYValue + 1;

        //Set x and y coordinates for the time text
        minXTime = yAxisPosX;
        minYTime = xAxisPosY + scaleFontSize+3;
        maxXTime = yAxisPosX + (maxTime-minTime)*valueHop;
        maxYTime = xAxisPosY + scaleFontSize+3;

        minTime -= 1;
        maxTime -= 1;
        if (scaleShowLabels)
            updateTime();

        completed = true;


    }
}


