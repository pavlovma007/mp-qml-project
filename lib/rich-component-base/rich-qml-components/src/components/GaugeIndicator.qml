import QtQuick 2.0

Rectangle
{
    id: view
    width: 250
    height: 250
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
    property real centerY: width/2
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

    property var values: []

    onWidthChanged: {
        height = width;
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
        source: "../images/gauge/background.svg"
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
            largeHashesOut = getNPointsOnCircle(centerX, centerY, outerRadius, largeHashCount);
            largeHashesIn = getNPointsOnCircle(centerX, centerY, largeHashRadius, largeHashCount);
            needleHashes = getNPointsOnCircle(centerX, centerY, outerRadius, largeHashCount);
            textHashes = getNTextPointsOnCircle(centerX, centerY, outerRadius - textRadius, largeHashCount, ctx);

            //fill the background
            ctx.beginPath();
            ctx.fillStyle = backGroundColor;
            ctx.arc(centerX, centerY, outerRadius, 0, Math.PI*2, false );
            ctx.closePath();
            ctx.fill();

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

        function drawMeter(ctx) {
            // Outside border
            ctx.strokeStyle = outerCircleColor;
            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.arc(centerX, centerY, outerRadius, 0, Math.PI * 2, false );
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

        function getNPointsOnCircle( x, y, radius, n) {
            // Found out the spacing of each point based on n points in 360 degrees
            var hashSpacing = Math.PI * 2.0 / n;
            var start = degToRad(90) + hashSpacing/2;
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
            var hashSpacing = Math.PI * 2.0 / n;
            var start = degToRad(90) + hashSpacing/2;
            var points = [];

            // For each point of n, find it's position based on the given radius and starting x, y
            for( var i = 0; i < n; i++ ){
                var a = start + hashSpacing * i;
                var degree = parseInt(radToDeg(a));
                //console.debug(degree + " " + values[i])
                if (degree >= 90 && degree <= 180)
                    points.push( { x: x + (Math.cos(a) * radius), y: y + (Math.sin(a) * radius) + textFontPixelSize/3, angle: (degree) } );
                else if (degree > 360)
                    points.push( { x: x + (Math.cos(a) * radius), y: y + (Math.sin(a) * radius) + textFontPixelSize/3, angle: (degree) } );
                else
                    points.push( { x: x + (Math.cos(a) * radius), y: y + (Math.sin(a) * radius) + textFontPixelSize/2, angle: (degree) } );

            }

            return points;
        }

    }

    Canvas {
        id: needle
        height: parent.width
        width: parent.width

        onPaint:{
            var ctx = needle.getContext("2d");
            ctx.clearRect(0, 0, width, height);

            var needleHeight = (parent.width/1024.0) * 83.0 / 4;

            //Draw the needle
            context.beginPath();
            context.moveTo(centerX, centerY + needleHeight);
            context.lineTo(centerX, centerY - needleHeight);
            context.lineTo(centerX + needleLength , centerY);
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
        sourceSize.width: (parent.width/1024.0) * 83.0
        sourceSize.height: (parent.width/1024.0) * 83.0
        source: "../images/gauge/center.svg"
        anchors.centerIn: parent
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

