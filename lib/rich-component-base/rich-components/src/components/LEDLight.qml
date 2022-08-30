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

Item {
    id: control
    property bool on: false
    property alias imageOn: imgOn.source
    property alias imageOff: imgOff.source
    property string textPosition: "bottom"
    property int fieldSpacing: 4
    property alias label: txtField.text
    property alias textColor: txtField.color
    property alias font: txtField.font

    onTextPositionChanged: {
        updateTextPosition();
    }

    onFieldSpacingChanged: {
        updateTextPosition();
    }

    function updateTextPosition()
    {
        if (textPosition === "bottom")
        {
            txtField.anchors.top = imgOn.bottom;
            txtField.anchors.topMargin = fieldSpacing;
            txtField.anchors.horizontalCenter = control.horizontalCenter
        }
        else if (textPosition === "right")
        {
            txtField.anchors.left = imgOn.right;
            txtField.anchors.leftMargin = fieldSpacing;
        }
        else if (textPosition === "left")
        {
            txtField.anchors.right = imgOn.left;
            txtField.anchors.rightMargin = fieldSpacing;
        }
        else
        {
            txtField.anchors.bottom = imgOn.top;
            txtField.anchors.bottomMargin = fieldSpacing;
            txtField.anchors.horizontalCenter = control.horizontalCenter
        }



    }

    Image {
        id: imgOn
        width: 58
        height: 58
        visible: on
        source: "../images/ledon.bmp"
    }

    Image {
        id: imgOff
        width: 58
        height: 58
        visible: !on
        source: "../images/ledoff.bmp"
    }

    Text{
        id: txtField
        text: "Label"
        font.family: "DejaVu Sans"
        font.pixelSize: 12
    }

    Component.onCompleted: updateTextPosition();
}
