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
import QtQuick 2.0
import "../js/stripchart.js" as Data

Canvas{
    id: graph
    width: 400
    height: 200
    //Bool - set if you do not want the scale to be calculated
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
    property string line2PenColor : ""
    //String - Color of the line3
    property string line3PenColor : ""
    //String - Color of the line2
    property string line4PenColor : ""
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
    //Number - number of vertical Grid Lines
    property int verticalGridLines: 0
    property int xAxisPosY: 0
    property int yAxisPosX: 0
    property int  xAxisLength: 0
    property int scaleHop: 0
    property real valueHop: 0
    property variant calculatedScale
    property int currentValue1
    property int currentValue2
    property int currentValue3
    property int currentValue4
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
    property bool point1Quit: false
    property bool point2Quit: false
    property bool point3Quit: false
    property bool point4Quit: false
    property int minXTime: 0
    property int minYTime: 0
    property int maxXTime: 0
    property int maxYTime: 0
    property int minTime: 0
    property int maxTime: 100
    property int startMinTime: 0
    property int startMaxTime: 0
    property int scaleHeight: 0
    property int topY: 0
    property int scale: 100
    property variant overlay
    property variant data
    property string color: "transparent"
    renderStrategy: Canvas.Threaded

    onPaint: {
        if (!completed)
        {
            var ctx = getContext("2d");
            var overlayCtx;

            if (scaleShowGridLines)
            {
                var canvasSrc = "import QtQuick 2.0; Canvas {id:overlay; z:100; anchors.fill: parent}";
                overlay = Qt.createQmlObject(canvasSrc, graph, "canvasObject");
                overlayCtx = overlay.getContext("2d");
            }

            data = Data.lineData;

            //Update data
            data.labels[0] = minTime.toString();
            data.labels[1] = maxTime.toString();

            var src = "import QtQuick 2.0; ListModel {}";
            pointData1 = Qt.createQmlObject(src, graph, "data1");

            if (line2PenColor.length > 0)
                pointData2 = Qt.createQmlObject(src, graph, "data2");

            if (line3PenColor.length > 0)
                pointData3 = Qt.createQmlObject(src, graph, "data3");

            if (line4PenColor.length > 0)
                pointData4 = Qt.createQmlObject(src, graph, "data4");

            if (imageBackground.source.toString().length > 0)
            {
                var imageSrc = "import QtQuick 2.0; Image{z: -10; width: graph.width; height: graph.height; source:\"" + imageBackground.source + "\"}";
                Qt.createQmlObject(imageSrc, graph, "bgImage");
            }

            if (verticalGridLines == 0)
                verticalGridLines = maxTime;
            draw(ctx, overlayCtx);
            valueHop = valueHop/maxTime;

            startMinTime = minTime;
            minTime -= 1;
            startMaxTime = maxTime;
            maxTime -= 1;
            if (scaleShowLabels)
                updateTime(ctx);
            completed = true;

        }

    }

    function draw(ctx, overlayCtx)
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
                populateLabels(labelTemplateString, calculatedScale.labels, calculatedScale.steps, scaleStartValue, scaleStepWidth);
        }

        scaleHop = Math.floor(scaleHeight/calculatedScale.steps);
        calculateXAxisSize();

        graph.calculatedScale = calculatedScale;

        drawScale();

        function calculateDrawingSizes(){
            maxSize = height;
            //Need to check the X axis first - measure the length of each text metric, and figure out if we need to rotate by 45 degrees.
            ctx.font = scaleFontStyle + " " + scaleFontSize+"px '" + scaleFontFamily + "'";
            widestXLabel = 1;
            for (var i=0; i<data.labels.length; i++){
                /* updated */
                var textLength = ctx.measureText(data.labels[i]).width;
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
            //Set 5 pixels greater than the font size to allow for a little padding from the X axis.

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
                ctx.font = scaleFontStyle + " " + scaleFontSize+"px '" + scaleFontFamily + "'";
                for (var i=0; i < calculatedScale.steps; i++)
                {
                    var measuredText = ctx.measureText(calculatedScale.labels[i]).width;
                    longestText = (measuredText > longestText)? measuredText : longestText;
                }

                //Add a little extra padding from the y axis
                longestText +=10;
            }

            xAxisLength = width - longestText - widestXLabel;

            valueHop = Math.floor(xAxisLength/(data.labels.length-1));
            scale = Math.ceil(valueHop/maxTime);

            yAxisPosX = width-widestXLabel/2-xAxisLength;
            xAxisPosY = scaleHeight + scaleFontSize/2;
        }


        function drawScale(){
                //Fill background
                ctx.fillStyle = scaleBgColor;
                ctx.fillRect(yAxisPosX, xAxisPosY + scaleLineWidth, xAxisLength, - (calculatedScale.steps * scaleHop)-scaleLineWidth);

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
                        if (rotateLabels > 0){
                                ctx.translate(yAxisPosX + i*valueHop,xAxisPosY + scaleFontSize);
                                ctx.rotate(-(rotateLabels * (Math.PI/180)));
                                ctx.fillText(data.labels[i], 0,0);
                                ctx.restore();
                        }
                        else{
                            if (i === 0)
                            {
                                minXTime = yAxisPosX + i*valueHop;
                                minYTime = xAxisPosY + scaleFontSize+3;
                            }
                            else
                            {
                                maxXTime = yAxisPosX + i*valueHop;
                                maxYTime = xAxisPosY + scaleFontSize+3;
                            }

                            if (scaleShowLabels)
                                ctx.fillText(data.labels[i], yAxisPosX + i*valueHop,xAxisPosY + scaleFontSize+3);
                        }

                        //Check i isnt 0, so we dont go over the Y axis twice.
                        if(scaleShowGridLines && i>0){
                            for (var k = 0; k <= valueHop; k += valueHop/verticalGridLines)
                            {
                                overlayCtx.beginPath()
                                overlayCtx.moveTo(yAxisPosX + k, xAxisPosY+3);
                                overlayCtx.lineWidth = scaleGridLineWidth;
                                overlayCtx.strokeStyle = scaleGridLineColor;
                                overlayCtx.lineTo(yAxisPosX + k, topY);
                                overlayCtx.stroke();
                            }
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
                            overlayCtx.beginPath();
                            overlayCtx.moveTo(yAxisPosX, xAxisPosY - ((j+1) * scaleHop));
                            overlayCtx.lineWidth = scaleGridLineWidth;
                            overlayCtx.strokeStyle = scaleGridLineColor;
                            //overlayCtx.lineTo(yAxisPosX + xAxisLength - 3, xAxisPosY - ((j+1) * scaleHop))
                            overlayCtx.lineTo(yAxisPosX + xAxisLength, xAxisPosY - ((j+1) * scaleHop))
                            overlayCtx.stroke();
                        }

                        if (scaleShowLabels){
                            ctx.fillText(calculatedScale.labels[j],yAxisPosX-8,xAxisPosY - ((j+1) * scaleHop) + scaleFontSize/2);
                        }
                }
        }

    /* end draw */
    }


    function drawLine(ctx, lastX, lastY, linePenColor, pointData)
    {
        if (pointData.count === 0)
        {
            console.debug("No data to draw line.")
            return;
        }

        var x = 0;
        ctx.strokeStyle = linePenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();
        if (lastX === 0)
        {
            ctx.moveTo(yAxisPosX, xAxisPosY - (calculateOffset(pointData.get(0).value,calculatedScale,scaleHop)))
        }
        else
        {
            ctx.moveTo(lastX, lastY);
            x = lastX;
        }

        lastX = xPos(pointData.count-1);
        lastY = yPos(pointData.count-1, pointData);

        //new
        if (x > 0)
            ctx.lineTo(x, lastY);
        else
            ctx.lineTo(yAxisPosX, lastY);

        ctx.lineTo(lastX,lastY);
        ctx.stroke();

        return {
            lastX: lastX,
            lastY: lastY
        }
    }


    function updateTime(ctx)
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
            var y = xAxisPosY - calculateOffset(pointData.get(iteration).value, calculatedScale,scaleHop);
            if (y == xAxisPosY)
                y = xAxisPosY - datasetStrokeWidth/2;
            else if (y < topY)
                y = topY;
            return y;
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

    function drawWaveFormLine1(ctx, sx, sy, sw, sh, dx, dy,
                                        x, y, w, h,
                                        x1, y1, x2, y2,
                                        drawBlock)
    {
        var copy = ctx.getImageData(sx, sy, sw, sh);

        if (scaleBgColor === "transparent")
            ctx.clearRect(dx, dy, sw, sh);

        ctx.drawImage(copy, dx, dy);

        if (scaleBgColor === "transparent")
            ctx.clearRect(x,y,w,h);
        else
        {
            ctx.fillStyle = scaleBgColor;
            ctx.fillRect(x,y,w,h);
        }

        //Draw the line
        ctx.strokeStyle = line1PenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();

        if (drawBlock)
        {
            ctx.moveTo(x1, y1);
            ctx.lineTo(x1, y2);
            ctx.moveTo(x1, y2);
            ctx.lineTo(x2, y2);
        }
        else
        {
            ctx.moveTo(x1, y1);
            ctx.lineTo(x2, y2);
        }

        ctx.stroke();
    }


    function drawWaveFormLine2(ctx, sx, sy, sw, sh, dx, dy,
                                        x, y, w, h,
                                        x11, y11, x12, y12,
                                        x21, y21, x22, y22,
                                        drawBlock)
    {
        var copy = ctx.getImageData(sx, sy, sw, sh);

        if (scaleBgColor  === "transparent")
            ctx.clearRect(dx, dy, sw, sh);

        ctx.drawImage(copy, dx, dy);

        if (scaleBgColor === "transparent")
            ctx.clearRect(x,y,w,h);
        else
        {
            ctx.fillStyle = scaleBgColor;
            ctx.fillRect(x,y,w,h);
        }

        //Draw line 1
        ctx.strokeStyle = line1PenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();

        if (drawBlock)
        {
            ctx.moveTo(x11, y11);
            ctx.lineTo(x11, y12);
            ctx.moveTo(x11, y12);
            ctx.lineTo(x12, y12);
        }
        else
        {
            ctx.moveTo(x11, y11);
            ctx.lineTo(x12, y12);
        }
        ctx.stroke();

        //Draw line 2
        ctx.strokeStyle = line2PenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();

        if (drawBlock)
        {
            ctx.moveTo(x21, y21);
            ctx.lineTo(x21, y22);
            ctx.moveTo(x21, y22);
            ctx.lineTo(x22, y22);
        }
        else
        {
            ctx.moveTo(x21, y21);
            ctx.lineTo(x22, y22);
        }
        ctx.stroke();
    }


    function drawWaveFormLine3(ctx, sx, sy, sw, sh, dx, dy,
                                        x, y, w, h,
                                        x11, y11, x12, y12,
                                        x21, y21, x22, y22,
                                        x31, y31, x32, y32,
                                        drawBlock)
    {
        var copy = ctx.getImageData(sx, sy, sw, sh);

        if (scaleBgColor  === "transparent")
            ctx.clearRect(dx, dy, sw, sh);

        ctx.drawImage(copy, dx, dy);

        if (scaleBgColor === "transparent")
            ctx.clearRect(x,y,w,h);
        else
        {
            ctx.fillStyle = scaleBgColor;
            ctx.fillRect(x,y,w,h);
        }

        //Draw line 1
        ctx.strokeStyle = line1PenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();

        if (drawBlock)
        {
            ctx.moveTo(x11, y11);
            ctx.lineTo(x11, y12);
            ctx.moveTo(x11, y12);
            ctx.lineTo(x12, y12);
        }
        else
        {
            ctx.moveTo(x11, y11);
            ctx.lineTo(x12, y12);
        }
        ctx.stroke();

        //Draw line 2
        ctx.strokeStyle = line2PenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();

        if (drawBlock)
        {
            ctx.moveTo(x21, y21);
            ctx.lineTo(x21, y22);
            ctx.moveTo(x21, y22);
            ctx.lineTo(x22, y22);
        }
        else
        {
            ctx.moveTo(x21, y21);
            ctx.lineTo(x22, y22);
        }
        ctx.stroke();

        //Draw line 3
        ctx.strokeStyle = line3PenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();

        if (drawBlock)
        {
            ctx.moveTo(x31, y31);
            ctx.lineTo(x31, y32);
            ctx.moveTo(x31, y32);
            ctx.lineTo(x32, y32);
        }
        else
        {
            ctx.moveTo(x31, y31);
            ctx.lineTo(x32, y32);
        }
        ctx.stroke();
    }


    function drawWaveFormLine4(ctx, sx, sy, sw, sh, dx, dy,
                                        x, y, w, h,
                                        x11, y11, x12, y12,
                                        x21, y21, x22, y22,
                                        x31, y31, x32, y32,
                                        x41, y41, x42, y42,
                                        drawBlock)
    {
        var copy = ctx.getImageData(sx, sy, sw, sh);

        if (scaleBgColor  === "transparent")
            ctx.clearRect(dx, dy, sw, sh);

        ctx.drawImage(copy, dx, dy);

        if (scaleBgColor === "transparent")
            ctx.clearRect(x,y,w,h);
        else
        {
            ctx.fillStyle = scaleBgColor;
            ctx.fillRect(x,y,w,h);
        }

        //Draw line 1
        ctx.strokeStyle = line1PenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();

        if (drawBlock)
        {
            ctx.moveTo(x11, y11);
            ctx.lineTo(x11, y12);
            ctx.moveTo(x11, y12);
            ctx.lineTo(x12, y12);
        }
        else
        {
            ctx.moveTo(x11, y11);
            ctx.lineTo(x12, y12);
        }
        ctx.stroke();

        //Draw line 2
        ctx.strokeStyle = line2PenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();

        if (drawBlock)
        {
            ctx.moveTo(x21, y21);
            ctx.lineTo(x21, y22);
            ctx.moveTo(x21, y22);
            ctx.lineTo(x22, y22);
        }
        else
        {
            ctx.moveTo(x21, y21);
            ctx.lineTo(x22, y22);
        }
        ctx.stroke();

        //Draw line 3
        ctx.strokeStyle = line3PenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();

        if (drawBlock)
        {
            ctx.moveTo(x31, y31);
            ctx.lineTo(x31, y32);
            ctx.moveTo(x31, y32);
            ctx.lineTo(x32, y32);
        }
        else
        {
            ctx.moveTo(x31, y31);
            ctx.lineTo(x32, y32);
        }
        ctx.stroke();

        //Draw line 4
        ctx.strokeStyle = line4PenColor;
        ctx.lineWidth = datasetStrokeWidth;
        ctx.beginPath();

        if (drawBlock)
        {
            ctx.moveTo(x41, y41);
            ctx.lineTo(x41, y42);
            ctx.moveTo(x41, y42);
            ctx.lineTo(x42, y42);
        }
        else
        {
            ctx.moveTo(x41, y41);
            ctx.lineTo(x42, y42);
        }
        ctx.stroke();
    }


    onCurrentValue1Changed: {
        if (completed && currentValue1 != maxYValue+1)
        {
            graph.requestPaint();
            if (pointData1.count === 0)
            {
                lastX1 = 0;
                lastY1 = currentValue1;
                var d = {'value': currentValue1};
                pointData1.append(d);
            }
            else if (!point1Quit && pointData1.count < maxTime+1)
            {
                var d = {'value': currentValue1};
                pointData1.append(d);
                var draw = drawLine(graph.getContext("2d"), lastX1, lastY1, line1PenColor, pointData1);
                lastX1 = draw.lastX;
                lastY1 = draw.lastY;
            }
            else{
                //We need to do some transforms
                //shift the pointData model
                pointData1.remove(0);
                var d = {'value': currentValue1};
                pointData1.append(d);
                point1Quit = true;

                if (line2PenColor.length == 0)
                {
                    drawWaveFormLine1(graph.getContext("2d"), yAxisPosX + valueHop, topY - scaleLineWidth, xPos(pointData1.count-1) - xPos(1), calculatedScale.steps * scaleHop,  yAxisPosX, topY - scaleLineWidth,
                                        xPos(pointData1.count-2), xAxisPosY + scaleLineWidth, valueHop + scaleLineWidth, - (calculatedScale.steps * scaleHop)-scaleLineWidth,
                                        xPos(pointData1.count-2), yPos(pointData1.count-2, pointData1)+0.5, xPos(pointData1.count-1), yPos(pointData1.count-1, pointData1)+0.5, true);
                    if (scaleShowLabels)
                        updateTime(graph.getContext("2d"));
                }
            }

            //To force the onChange event in the future
            currentValue1 = maxYValue + 1;
        }
    }

    onCurrentValue2Changed: {
        if (completed && pointData2 && currentValue2 != maxYValue+1)
        {
            if (pointData2.count === 0)
            {
                lastX2 = 0;
                lastY2 = currentValue2;
                var d = {'value': currentValue2};
                pointData2.append(d);
            }
            else if (!point2Quit && pointData2.count < maxTime+1)
            {
                var d = {'value': currentValue2};
                pointData2.append(d);
                var draw = drawLine(graph.getContext("2d"), lastX2, lastY2, line2PenColor, pointData2);
                lastX2 = draw.lastX;
                lastY2 = draw.lastY;
            }
            else{
                //We need to do some transforms
                //shift the pointData model
                pointData2.remove(0);
                var d = {'value': currentValue2};
                pointData2.append(d);
                point2Quit = true;

                if (line3PenColor.length == 0)
                {
                    drawWaveFormLine2(graph.getContext("2d"), yAxisPosX + valueHop, topY - scaleLineWidth, xPos(pointData1.count-1) - xPos(1), calculatedScale.steps * scaleHop,  yAxisPosX, topY - scaleLineWidth,
                                        xPos(pointData1.count-2), xAxisPosY + scaleLineWidth, valueHop + scaleLineWidth, - (calculatedScale.steps * scaleHop)-scaleLineWidth,
                                        xPos(pointData1.count-2), yPos(pointData1.count-2, pointData1)+0.5, xPos(pointData1.count-1), yPos(pointData1.count-1, pointData1)+0.5,
                                        xPos(pointData2.count-2), yPos(pointData2.count-2, pointData2)+0.5, xPos(pointData2.count-1), yPos(pointData2.count-1, pointData2)+0.5,
                                      true);

                    if (scaleShowLabels)
                        updateTime(graph.getContext("2d"));
                }

            }

            //To force the onChange event in the future
            currentValue2 = maxYValue + 1;
        }

    }

    onCurrentValue3Changed: {
        if (completed && pointData3 && currentValue3 != maxYValue+1)
        {
            if (pointData3.count === 0)
            {
                lastX3 = 0;
                lastY3 = currentValue3;
                var d = {'value': currentValue3};
                pointData3.append(d);
            }
            else if (!point3Quit && pointData3.count < maxTime+1)
            {
                var d = {'value': currentValue3};
                pointData3.append(d);
                var draw = drawLine(graph.getContext("2d"), lastX3, lastY3, line3PenColor, pointData3);
                lastX3 = draw.lastX;
                lastY3 = draw.lastY;
            }
            else{
                //We need to do some transforms
                //shift the pointData model
                pointData3.remove(0);
                var d = {'value': currentValue3};
                pointData3.append(d);
                point3Quit = true;

                if (line4PenColor.length == 0)
                {
                    drawWaveFormLine3(graph.getContext("2d"), yAxisPosX + valueHop, topY - scaleLineWidth, xPos(pointData1.count-1) - xPos(1), calculatedScale.steps * scaleHop,  yAxisPosX, topY - scaleLineWidth,
                                        xPos(pointData1.count-2), xAxisPosY + scaleLineWidth, valueHop + scaleLineWidth, - (calculatedScale.steps * scaleHop)-scaleLineWidth,
                                        xPos(pointData1.count-2), yPos(pointData1.count-2, pointData1)+0.5, xPos(pointData1.count-1), yPos(pointData1.count-1, pointData1)+0.5,
                                        xPos(pointData2.count-2), yPos(pointData2.count-2, pointData2)+0.5, xPos(pointData2.count-1), yPos(pointData2.count-1, pointData2)+0.5,
                                        xPos(pointData3.count-2), yPos(pointData3.count-2, pointData3)+0.5, xPos(pointData3.count-1) , yPos(pointData3.count-1, pointData3)+0.5,
                                        true);

                    if (scaleShowLabels)
                        updateTime(graph.getContext("2d"));
                }
            }

            //To force the onChange event in the future
            currentValue3 = maxYValue + 1;
        }

    }


    onCurrentValue4Changed: {
        if (completed && pointData4 && currentValue4 != maxYValue+1)
        {
            if (pointData4.count === 0)
            {
                lastX4 = 0;
                lastY4 = currentValue4;
                var d = {'value': currentValue4};
                pointData4.append(d);
            }
            else if (!point4Quit && pointData4.count < maxTime+1)
            {
                var d = {'value': currentValue4};
                pointData4.append(d);
                var draw = drawLine(graph.getContext("2d"), lastX4, lastY4, line4PenColor, pointData4);
                lastX4 = draw.lastX;
                lastY4 = draw.lastY;
            }
            else{
                //We need to do some transforms
                //shift the pointData model
                pointData4.remove(0);
                var d = {'value': currentValue4};
                pointData4.append(d);
                point4Quit = true;
                drawWaveFormLine4(graph.getContext("2d"), yAxisPosX + valueHop, topY - scaleLineWidth, xPos(pointData1.count-1) - xPos(1), calculatedScale.steps * scaleHop,  yAxisPosX, topY - scaleLineWidth,
                                    xPos(pointData1.count-2), xAxisPosY + scaleLineWidth, valueHop + scaleLineWidth, - (calculatedScale.steps * scaleHop)-scaleLineWidth,
                                    xPos(pointData1.count-2), yPos(pointData1.count-2, pointData1)+0.5, xPos(pointData1.count-1), yPos(pointData1.count-1, pointData1)+0.5,
                                    xPos(pointData2.count-2), yPos(pointData2.count-2, pointData2)+0.5, xPos(pointData2.count-1), yPos(pointData2.count-1, pointData2)+0.5,
                                    xPos(pointData3.count-2), yPos(pointData3.count-2, pointData3)+0.5, xPos(pointData3.count-1) , yPos(pointData3.count-1, pointData3)+0.5,
                                    xPos(pointData4.count-2), yPos(pointData4.count-2, pointData4)+0.5, xPos(pointData4.count-1) , yPos(pointData4.count-1, pointData4)+0.5,
                                    true);
                if (scaleShowLabels)
                    updateTime(graph.getContext("2d"));
            }

            //To force the onChange event in the future
            currentValue4 = maxYValue + 1;
        }

    }


    function getPixels()
    {
        return ctx.getImageData(yAxisPosX + valueHop, topY - scaleLineWidth, xPos(pointData.count-1) - xPos(1), calculatedScale.steps * scaleHop);
    }

    Image{
        id: imageBackground
        visible: false
        width: graph.width
        height: graph.height
    }

    function clearPens()
    {
        completed = false;
        graph.requestPaint();
        pointData1.clear();
        point1Quit = false;
        point2Quit = false;
        point3Quit = false;
        point4Quit = false;

        if (typeof pointData2 !== 'undefined')
            pointData2.clear();
        if (typeof pointData3 !== 'undefined')
            pointData3.clear();
        if (typeof pointData4 !== 'undefined')
            pointData4.clear();
        var ctx = graph.getContext("2d");
        ctx.clearRect(graph.width, graph.height);

        var overlayCtx;
        if (typeof overlay !== 'undefined')
        {
            overlayCtx = overlay.getContext("2d");
            overlayCtx.clearRect(overlay.width, overlay.height);
        }

        draw(ctx, overlayCtx);

        minTime = startMinTime;
        maxTime = startMaxTime;
        valueHop = valueHop/maxTime;
        minTime -=1;
        maxTime -=1;

        if (scaleShowLabels)
            updateTime(ctx);

        completed = true;
    }


}

