import QtQuick 2.0

Rectangle
{
    id: view
    width: 250
    height: 125
    color: "transparent"
    property string backGroundColor: "transparent"
    property alias imageBase: imgDialBase.source
    property alias imageCenter: imgCenter.source
    property real circleOffset: width * 72.0/1024.0
    property int min: 0
    property int max: 5
    property real value: min - 1
    property real initialValue: min - 1
    property real centerX: width/2
    property real centerY: height
    property int largeHashCount: (max - min)/tickInterval + 1
    property real outerRadius: width/2 - circleOffset
    property real largeHashRadius: outerRadius - tickSize
    property var largeHashesOut
    property var largeHashesIn
    property var needleHashes
    property var textHashes
    property string outerCircleColor: "transparent"
    property real tickInterval: 1
    property int tickSize: 8
    property string tickColor: "#000000"
    property int textRadius: 18
    property string textFontColor: "#000000"
    property int textFontPixelSize: 12
    property string textFontFamily: "DejaVu Sans"
    property string textFontStyle: "normal"
    property string needleColor: "#FF0000"
    property int needleLength: outerRadius
    property int largestTextSize
    property real startOfGreenMarker: 100
    property real endOfGreenMarker: 140
    property real endOfOrangeMarker: 160
    property real markerWidth: 8
    property real hashSpacing

    property var values: []

    clip: true

    onWidthChanged: {
        height = width/2;
        needle.requestPaint();
    }

    onNeedleLengthChanged: needle.requestPaint();
    onNeedleColorChanged: needle.requestPaint();

    onTextRadiusChanged: canvas.requestPaint();
    onTextFontColorChanged: canvas.requestPaint();
    onTextFontPixelSizeChanged: canvas.requestPaint();
    onTextFontFamilyChanged: canvas.requestPaint();

    onMinChanged: canvas.requestPaint();
    onMaxChanged: canvas.requestPaint();

    onTickIntervalChanged: canvas.requestPaint();
    onTickSizeChanged: canvas.requestPaint();
    onTickColorChanged: canvas.requestPaint();

    onInitialValueChanged: {
        if (initialValue >= min)
        {
            canvas.requestPaint();
        }
    }

    onValueChanged: {
        if (value >= min && value <= max)
        {
            if (value != max)
            {
                var i=0;
                //We need to find the value in the list
                for (i=0; i<values.length; i++)
                {
                    if (value >= parseFloat(values[i]) && value < parseFloat(values[i+1]))
                        break;
                }

                if (values.length > 0)
                {
                    var diffVal = (value - parseFloat(values[i])) / (parseFloat(values[i+1]) - parseFloat(values[i]));
                    var diffAngle = textHashes[i+1].angle - textHashes[i].angle;

                    needleRotation.angle = textHashes[i].angle + diffVal*diffAngle;
                }
            }
            else
            {
                needleRotation.angle = textHashes[values.length-1].angle;
            }
        }
    }

    Image {
        id: imgDialBase
        source: "../images/meter/background.svg"
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        smooth: true
    }

    Canvas{
        id: canvas
        width: parent.width
        height: parent.height

        onPaint:{
            values = [];
            if (values.length == 0)
                buildValues();

            var ctx = canvas.getContext("2d");
            ctx.clearRect(0, 0, width, height);

            ctx.font = textFontStyle +  " " + textFontPixelSize + "px '" + textFontFamily + "'";
            largestTextSize = ctx.measureText(max.toString()).width;

            largeHashesOut = getNPointsOnCircle(centerX, centerY, outerRadius - largestTextSize, largeHashCount);
            largeHashesIn = getNPointsOnCircle(centerX, centerY, largeHashRadius - largestTextSize, largeHashCount);
            needleHashes = getNPointsOnCircle(centerX, centerY, outerRadius, largeHashCount);
            textHashes = getNTextPointsOnCircle(centerX, centerY, outerRadius - textRadius, largeHashCount, ctx);

            //fill the background
            ctx.beginPath();
            ctx.fillStyle = backGroundColor;
            ctx.arc(centerX, centerY, outerRadius, 0, Math.PI*2, false );
            ctx.closePath();
            ctx.fill();

            drawMarkers(ctx);
            drawMeter(ctx);

            if (initialValue >= min)
                value = initialValue;

            needle.requestPaint();
        }

        function degToRad(angle) {
            // Degrees to radians
            return ((angle * Math.PI) / 180);
        }

        function radToDeg(angle) {
            // Radians to degree
            return ((angle * 180) / Math.PI);
        }

        function getAngle(val)
        {
            for (var i=0; i<values.length; i++)
            {
                if (val >= parseFloat(values[i]) && val < parseFloat(values[i+1]))
                    break;
            }

            if (val != max)
            {
                var diffVal = (val - parseFloat(values[i])) / (parseFloat(values[i+1]) - parseFloat(values[i]));
                var diffAngle = textHashes[i+1].angle - textHashes[i].angle;

                return textHashes[i].angle + diffVal*diffAngle;
            }
            else
            {
                return textHashes[values.length-1].angle;
            }
        }

        function drawMeter(ctx) {
            // Outside border
            ctx.strokeStyle = outerCircleColor;
            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.arc(centerX, centerY, outerRadius, 0, Math.PI*2, false );
            ctx.closePath();
            ctx.stroke();

            // Large Hashes
            ctx.strokeStyle = tickColor;
            ctx.lineWidth = 1;
            for( var i = 0; i < largeHashesOut.length; i++ ) {
                ctx.beginPath();
                ctx.moveTo( largeHashesOut[i].x, largeHashesOut[i].y );
                ctx.lineTo( largeHashesIn[i].x, largeHashesIn[i].y );
                ctx.closePath();
                ctx.stroke();
            }

            //Text
            ctx.font = textFontStyle +  " " + textFontPixelSize + "px '" + textFontFamily + "'";
            ctx.textAlign = 'center';
            ctx.fillStyle = textFontColor;
            for (var j=0; j < textHashes.length; j++)
            {
                ctx.fillText(values[j], textHashes[j].x, textHashes[j].y);
            }

        }

        function drawMarkers(ctx)
        {
            var markerCenterPosition =  ((outerRadius - largestTextSize) + (largeHashRadius - largestTextSize)) / 2;

            var greenAngleStart = getAngle(startOfGreenMarker) - 90;
            var greenAngleStop = getAngle(endOfGreenMarker) - 90;
            var orangeAngleStop = getAngle(endOfOrangeMarker) - 90;
            var redAngleStop = getAngle(max) - 90;

            var offSet = degToRad(markerWidth)/3;

            //Draw green arc
            ctx.beginPath();
            ctx.strokeStyle = "lime";
            ctx.lineCap = "square";
            ctx.lineWidth = markerWidth;
            ctx.arc(centerX, centerY, markerCenterPosition, degToRad(greenAngleStart) + offSet, degToRad(greenAngleStop) - offSet, false);
            ctx.stroke();

            //Draw orange arc
            ctx.beginPath();
            ctx.strokeStyle = "orange";
            ctx.lineCap = "square";
            ctx.lineWidth = markerWidth;
            ctx.arc(centerX, centerY, markerCenterPosition, degToRad(greenAngleStop) + offSet, degToRad(orangeAngleStop) - offSet, false);
            ctx.stroke();

            //Draw red arc
            ctx.beginPath();
            ctx.strokeStyle = "#FF0000";
            ctx.lineCap = "square";
            ctx.lineWidth = markerWidth;
            ctx.arc(centerX, centerY, markerCenterPosition, degToRad(orangeAngleStop) + offSet, degToRad(redAngleStop) - offSet, false);
            ctx.stroke();


        }

        function getNPointsOnCircle( x, y, radius, n) {
            // Found out the spacing of each point based on n points in 360 degrees

            hashSpacing = Math.PI / n;
            var start = degToRad(180) + hashSpacing/2;
            var points = [];

            // For each point of n, find it's position based on the given radius and starting x, y
            for( var i = 0; i < n; i++ ){
                var a = start + hashSpacing * i;
                points.push( { x: x + (Math.cos(a) * radius), y: y + (Math.sin(a) * radius), angle: (a) } );
            }

            return points;
        }

        function getNTextPointsOnCircle( x, y, radius, n) {
            // Found out the spacing of each point based on n points in 360 degrees
            var hashSpacing = Math.PI / n;
            var start = degToRad(180) + hashSpacing/2;
            var points = [];

            // For each point of n, find it's position based on the given radius and starting x, y
            for( var i = 0; i < n; i++ ){
                var a = start + hashSpacing * i;
                var degree = parseInt(radToDeg(a));
                points.push( { x: x + (Math.cos(a) * radius), y: y + (Math.sin(a) * radius) + textFontPixelSize/2, angle: (degree - 270) } );
            }

            return points;
        }

    }

    Canvas {
        id: needle
        height: parent.height
        width: parent.width

        onPaint:{
            var ctx = needle.getContext("2d");
            ctx.clearRect(0, 0, width, height);

            var needleHeight = (parent.width/1024.0) * 83.0 / 4;

            //Draw the needle
            context.beginPath();
            context.moveTo(centerX + needleHeight, centerY - needleHeight);
            context.lineTo(centerX - needleHeight, centerY - needleHeight);
            context.lineTo(centerX, centerY - needleLength);
            context.closePath();
            context.lineWidth = 1;
            context.strokeStyle = needleColor;
            context.stroke();
            // the fill color
            context.fillStyle = needleColor;
            context.fill();
        }

        transform: Rotation {
            id: needleRotation
            Behavior on angle {
                SpringAnimation {
                    spring: 1.4
                    damping: .15
                }
            }
        }

        Component.onCompleted: {
            needleRotation.origin.x = centerX;
            needleRotation.origin.y = centerY;
        }
    }

    Image {
        id: imgCenter
        visible: true
        sourceSize.width: (parent.width/768.0) * 83.0
        sourceSize.height: (parent.width/768.0) * 83.0
        source: "../images/meter/center.png"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    function buildValues()
    {
        var precision = 0;
        if ((tickInterval + "").indexOf(".") >= 0)
            precision = (tickInterval + "").split(".")[1].length;
        //Create the values array
        for (var i=min; i <= max; i=i+tickInterval)
        {
            values.push(i.toFixed(precision));
        }

    }

    Component.onCompleted : {
    }

}


