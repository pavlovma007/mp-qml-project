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
import QtQuick 1.1

Rectangle{
    id: root
    // Canvas context
    property variant ctx
    //String - Background color
    property string color: "#ffffff"
    //Number - Border width of the draw area
    property int borderWidth: 4
    //Number - Border color of the draw area
    property string borderColor: "#000000"
    //Number - radius of the drawing area
    property int borderRadius: 0
    property int paintX
    property int paintY
    //Number - width of the drawing pen
    property int penWidth: 2
    //String - color of the drawing pen
    property string penColor: "#000000"

    border.width: borderWidth
    border.color: borderColor
    radius: borderRadius

    Canvas {
        id: canvas
        color: root.color
        anchors.fill: parent
    }

    MouseArea {
        id:mousearea
        hoverEnabled:true
        anchors.fill: parent

        onClicked:{
            drawPoint();
        }

        onPositionChanged:  {
            if (mousearea.pressed)
                drawLineSegment();
            paintX = mouseX;
            paintY = mouseY;
        }

    }

    function drawLineSegment() {
        ctx.beginPath();
        ctx.strokeStyle = penColor
        ctx.lineWidth = penWidth
        ctx.moveTo(paintX, paintY);
        ctx.lineTo(mousearea.mouseX, mousearea.mouseY);
        ctx.stroke();
        ctx.closePath();
    }

    function drawPoint() {
        ctx.lineWidth = penWidth
        ctx.fillStyle = penColor
        ctx.fillRect(mousearea.mouseX, mousearea.mouseY, 2, 2);
    }

    function clear() {
        ctx.clearRect(0, 0, width, height);
    }

    function getPixels()
    {
        return ctx.getImageData(0,0,width, height);
    }


    onColorChanged: canvas.requestPaint();

    Component.onCompleted: ctx = canvas.getContext("2d");
}
