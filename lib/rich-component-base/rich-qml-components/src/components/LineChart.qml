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
import "../js/linechart.js" as Data

Canvas{
    id: graph
    width: 440
    height: 180
    //Boolean - If we show the scale above the chart data
    property bool scaleOverlay : false
    onScaleOverlayChanged: graph.requestPaint();
    //Boolean - If we want to override with a hard coded scale
    property bool scaleOverride : false
    //** Required if scaleOverride is true **
    //Number - The number of steps in a hard coded scale
    property int scaleSteps : 0
    //Number - The value jump in the hard coded scale
    property int scaleStepWidth : 0
    //Number - The scale starting value
    property int scaleStartValue : 0
    //String - Color of the scale line
    property string scaleLineColor : "rgba(0,0,0,.1)"
    onScaleLineColorChanged: graph.requestPaint();
    //Number - Pixel width of the scale line
    property int scaleLineWidth : 1
    onScaleLineWidthChanged: graph.requestPaint();
    //Boolean - Whether to show labels on the scale
    property bool scaleShowLabels : true
    onScaleShowLabelsChanged: graph.requestPaint();
    //Interpolated JS string - can access value
    property string scaleLabel : "<%=value%>"
    //String - Scale label font declaration for the scale label
    property string  scaleFontFamily : "DejaVu Sans"
    onScaleFontFamilyChanged: graph.requestPaint();
    //Number - Scale label font size in pixels
    property int scaleFontSize : 12
    onScaleFontSizeChanged: graph.requestPaint();
    //String - Scale label font weight style
    property string scaleFontStyle : "normal"
    onScaleFontStyleChanged: graph.requestPaint();
    //String - Scale label font color
    property string scaleFontColor : "#666"
    onScaleFontColorChanged: graph.requestPaint();
    ///Boolean - Whether grid lines are shown across the chart
    property bool scaleShowGridLines : true
    onScaleShowGridLinesChanged: graph.requestPaint();
    //String - Color of the grid lines
    property string scaleGridLineColor : "rgba(0,0,0,.05)"
    onScaleGridLineColorChanged: graph.requestPaint();
    //Number - Width of the grid lines
    property int scaleGridLineWidth : 1
    onScaleGridLineWidthChanged: graph.requestPaint();
    //Boolean - Whether the line is curved between points
    property bool bezierCurve : true
    onBezierCurveChanged: graph.requestPaint();
    //Boolean - Whether to show a dot for each point
    property bool pointDot : true
    onPointDotChanged: graph.requestPaint();
    //Number - Radius of each point dot in pixels
    property int pointDotRadius : 4
    onPointDotRadiusChanged: graph.requestPaint();
    //Number - Pixel width of point dot stroke
    property int pointDotStrokeWidth : 2
    onPointDotStrokeWidthChanged: graph.requestPaint();
    //Boolean - Whether to show a stroke for datasets
    property bool datasetStroke : true
    onDatasetStrokeChanged: graph.requestPaint();
    //Number - Pixel width of dataset stroke
    property int datasetStrokeWidth : 2
    onDatasetStrokeWidthChanged: graph.requestPaint();
    //Boolean - Whether to fill the dataset with a color
    property bool datasetFill : true
    onDatasetFillChanged: graph.requestPaint();
    //Bool - Determines if we should show a legend
    property bool showLegend : true
    onShowLegendChanged: graph.requestPaint();
    //Variant - The data structure for the chart
    property variant data: []
    onDataChanged: graph.requestPaint();

    onPaint:{
        if (data.length == 0)
            data = Data.lineData;
        var ctx = graph.getContext("2d");
        draw(ctx);
    }

    function draw(ctx)
    {
        ctx.clearRect(0, 0, width, height);
        var maxSize, scaleHop, calculatedScale, labelHeight, scaleHeight, valueBounds, labelTemplateString, valueHop,widestXLabel, xAxisLength,yAxisPosX,xAxisPosY, rotateLabels = 0;

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

        scaleHop = Math.floor(scaleHeight/calculatedScale.steps);
        if (showLegend)
            scaleHop -= 1;

        calculateXAxisSize();

        if (!scaleOverlay)
            drawScale();

        for (var i=0; i<data.datasets.length; i++){
                ctx.strokeStyle = data.datasets[i].strokeColor;
                ctx.lineWidth = datasetStrokeWidth;
                ctx.beginPath();
                ctx.moveTo(yAxisPosX, xAxisPosY - (calculateOffset(data.datasets[i].data[0],calculatedScale,scaleHop)))

                for (var j=1; j<data.datasets[i].data.length; j++){
                        if (bezierCurve){
                                ctx.bezierCurveTo(xPos(j-0.5), yPos(i,j-1), xPos(j-0.5), yPos(i,j), xPos(j), yPos(i,j));
                        }
                        else{
                                ctx.lineTo(xPos(j),yPos(i,j));
                        }
                }

                if (datasetStroke)
                    ctx.stroke();

                if (datasetFill){
                        ctx.lineTo(yAxisPosX + (valueHop*(data.datasets[i].data.length-1)),xAxisPosY);
                        ctx.lineTo(yAxisPosX,xAxisPosY);
                        ctx.closePath();
                        ctx.fillStyle = data.datasets[i].fillColor;
                        ctx.fill();
                }
                else{
                        ctx.closePath();
                }
                if(pointDot){
                        ctx.fillStyle = data.datasets[i].pointColor;
                        ctx.strokeStyle = data.datasets[i].pointStrokeColor;
                        ctx.lineWidth = pointDotStrokeWidth;
                        for (var k=0; k<data.datasets[i].data.length; k++){
                                ctx.beginPath();
                                ctx.arc(yAxisPosX + (valueHop *k),xAxisPosY - (calculateOffset(data.datasets[i].data[k],calculatedScale,scaleHop)),pointDotRadius,0,Math.PI*2,true);
                                ctx.fill();
                                ctx.stroke();
                        }
                }
        }

        if (scaleOverlay)
            drawScale();

        if (showLegend)
            drawLegend();

        function yPos(dataSet,iteration){
                return xAxisPosY - (calculateOffset(data.datasets[dataSet].data[iteration],calculatedScale,scaleHop));
        }
        function xPos(iteration){
                return yAxisPosX + (valueHop * iteration);
        }

        function calculateDrawingSizes(){
            maxSize = height;
            //Need to check the X axis first - measure the length of each text metric, and figure out if we need to rotate by 45 degrees.
            ctx.font = scaleFontStyle + " " + scaleFontSize+"px '" + scaleFontFamily + "'";
            widestXLabel = 1;
            for (var i=0; i<data.labels.length; i++){
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

            labelHeight = scaleFontSize + 5;

            maxSize -= labelHeight;
            //Set 5 pixels greater than the font size to allow for a little padding from the X axis.

            scaleHeight = maxSize;
        };

        function getValueBounds() {
            var upperValue = Number.MIN_VALUE;
            var lowerValue = Number.MAX_VALUE;
            for (var i=0; i<data.datasets.length; i++){
                for (var j=0; j<data.datasets[i].data.length; j++){
                    if ( data.datasets[i].data[j] > upperValue) { upperValue = data.datasets[i].data[j] };
                    if ( data.datasets[i].data[j] < lowerValue) { lowerValue = data.datasets[i].data[j] };
                }
            }

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

            graphMin = Math.floor(minValue / (1 * Math.pow(10, rangeOrderOfMagnitude))) * Math.pow(10, rangeOrderOfMagnitude);

            graphMax = Math.ceil(maxValue / (1 * Math.pow(10, rangeOrderOfMagnitude))) * Math.pow(10, rangeOrderOfMagnitude);

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

        function calculateOffset(val,calculatedScale,scaleHop){
            var outerValue = calculatedScale.steps * calculatedScale.stepValue;
            var adjustedValue = val - calculatedScale.graphMin;
            var scalingFactor = CapValue(adjustedValue/outerValue,1,0);
            return (scaleHop*calculatedScale.steps) * scalingFactor;
        }

        //Apply cap a value at a high or low number
        function CapValue(valueToCap, maxValue, minValue){
                if(isNumber(maxValue)) {
                        if( valueToCap > maxValue ) {
                                return maxValue;
                        }
                }
                if(isNumber(minValue)){
                        if ( valueToCap < minValue ){
                                return minValue;
                        }
                }
                return valueToCap;
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

            yAxisPosX = width-widestXLabel/2-xAxisLength;
            xAxisPosY = scaleHeight + scaleFontSize/2;
        }

        function isNumber(n) {
                return !isNaN(parseFloat(n)) && isFinite(n);
        }

        function drawScale(){
                //X axis line
                ctx.lineWidth = scaleLineWidth;
                ctx.strokeStyle = scaleLineColor;
                ctx.beginPath();
                ctx.moveTo(width-widestXLabel/2+5,xAxisPosY);
                ctx.lineTo(width-(widestXLabel/2)-xAxisLength-5,xAxisPosY);
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
                                ctx.fillText(data.labels[i], yAxisPosX + i*valueHop,xAxisPosY + scaleFontSize+3);
                        }

                        ctx.beginPath();
                        ctx.moveTo(yAxisPosX + i * valueHop, xAxisPosY+3);

                        //Check i isnt 0, so we dont go over the Y axis twice.
                        if(scaleShowGridLines && i>0){
                                ctx.lineWidth = scaleGridLineWidth;
                                ctx.strokeStyle = scaleGridLineColor;
                                //ctx.lineTo(yAxisPosX + i * valueHop, 5);
                                if (showLegend)
                                    ctx.lineTo(yAxisPosX + i * valueHop, scaleFontSize+1);
                                else
                                    ctx.lineTo(yAxisPosX + i * valueHop, 5);
                        }
                        else{
                                ctx.lineTo(yAxisPosX + i * valueHop, xAxisPosY+3);
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
                                ctx.lineTo(yAxisPosX + xAxisLength + 5,xAxisPosY - ((j+1) * scaleHop));
                        }
                        else{
                                ctx.lineTo(yAxisPosX-0.5,xAxisPosY - ((j+1) * scaleHop));
                        }

                        ctx.stroke();

                        if (scaleShowLabels){
                                ctx.fillText(calculatedScale.labels[j], yAxisPosX-8, xAxisPosY - ((j+1) * scaleHop) + scaleFontSize/2);
                        }
                }


        }


        function drawLegend()
        {
            //first get the length of the legend

            var length = 0;
            var dataText = new Array();
            var dataLength = new Array();
            var dataColor = new Array();

            for (var i=0; i < data.datasets.length; i++)
            {
                dataText[i] = data.datasets[i].text;
                dataLength[i] = ctx.measureText(data.datasets[i].text).width + scaleFontSize;
                dataColor[i] = data.datasets[i].strokeColor;
                length += dataLength[i];
            }

            var center = yAxisPosX + (xAxisLength)/2;
            var x = center - length/2;

            ctx.font = scaleFontStyle + " " + scaleFontSize+"px '" + scaleFontFamily + "'";

            //Now lets place boxes and text at the top of the chart
            for (i=0; i < data.datasets.length; i++)
            {
                //Draw box
                ctx.fillStyle = dataColor[i];
                ctx.fillRect(x - scaleFontSize, 1, scaleFontSize, scaleFontSize);
                ctx.fillStyle = scaleFontColor;
                ctx.textAlign = "left"
                ctx.fillText(dataText[i], x + 4, scaleFontSize - 3);
                x += dataLength[i] + scaleFontSize;
            }

        }

    /* end draw */
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

}

