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
****************************************************************************/
import QtQuick 2.0

Rectangle{
    id: root
    //String - Background color
    property string color: "#ffffff"
    //Number - Border width of the draw area
    property int borderWidth: 4
    //Number - Border color of the draw area
    property string borderColor: "#000000"
    //Number - radius of the drawing area
    property int borderRadius: 0
    property int lastX
    property int lastY
    //Number - width of the drawing pen
    property int penWidth: 2
    //String - color of the drawing pen
    property string penColor: "#000000"
    property bool clear: false
    property bool drawLine: false
    property bool drawPoint: false
    property bool mousePressed: false

    border.width: borderWidth
    border.color: borderColor
    radius: borderRadius

    Canvas {
        id: canvas
        anchors.margins: root.borderWidth
        anchors.fill: parent
        renderStrategy: Canvas.Threaded

        onPaint: {
            var ctx = getContext('2d');
            if (root.clear)
            {
                ctx.clearRect(0, 0, width, height);
                ctx.fillStyle = root.color;
                ctx.fillRect(0, 0, width, height);
            }
            else if (root.drawPoint)
                root.drawPointSegment(ctx);
            else if (root.drawLine && mousearea.pressed)
                root.drawLineSegment(ctx);

            root.drawLine = false;
            root.clear = false;
            root.drawPoint = false;
        }
    }

    MouseArea {
        id:mousearea
        hoverEnabled:true
        anchors.fill: parent

        onClicked: {
            root.drawPoint = true;
            canvas.requestPaint();
        }

        onPressed: {
            lastX = mouseX;
            lastY = mouseY;
        }

        onPositionChanged:  {
            root.drawLine = true;
            canvas.requestPaint();
        }

    }

    function clearCanvas() {
        root.clear = true;
        canvas.requestPaint();
    }

    function getDataUrl()
    {
        return canvas.toDataURL();
    }


    function drawLineSegment(ctx) {
        ctx.beginPath();
        ctx.strokeStyle = penColor
        ctx.lineWidth = penWidth
        ctx.moveTo(lastX, lastY);
        ctx.lineTo(mousearea.mouseX, mousearea.mouseY);
        ctx.stroke();
        ctx.closePath();
        lastX = mousearea.mouseX;
        lastY = mousearea.mouseY;
    }

    function drawPointSegment(ctx) {
        ctx.lineWidth = penWidth
        ctx.fillStyle = penColor
        ctx.fillRect(mousearea.mouseX, mousearea.mouseY, penWidth, penWidth);
    }

    onColorChanged: {
        root.clear = true;
        canvas.requestPaint();
    }

}
