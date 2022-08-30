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

Rectangle {
    id: root
    color: "transparent"
    property url imageOn: "../images/ledon.png"
    property url imageOff: "../images/ledoff.png"
    property string textPosition: "bottom"
    property alias label: txtField.text
    property int fieldSpacing: 4
    property alias textColor: txtField.color
    property alias font: txtField.font
    width: imgOn.width
    height: imgOn.height
    clip: false
    property bool on: false

    onTextPositionChanged: {
        updateTextPosition();
    }

    Image{
        id: imgOn
        source: on ? imageOn : imageOff
    }

    Text{
        id: txtField
        text: "label"
    }

    onFieldSpacingChanged: updateTextPosition();

    function updateTextPosition()
    {
        txtField.anchors.bottom = undefined;
        txtField.anchors.top = undefined;
        txtField.anchors.left = undefined;
        txtField.anchors.right = undefined;
        txtField.anchors.horizontalCenter = undefined;
        txtField.anchors.verticalCenter = undefined;

        if (textPosition == "top")
        {
            txtField.anchors.bottom = imgOn.top;
            txtField.anchors.bottomMargin = fieldSpacing;
            txtField.anchors.horizontalCenter = root.horizontalCenter;
        }
        else if (textPosition == "bottom")
        {
            txtField.anchors.top = imgOn.bottom;
            txtField.anchors.topMargin = fieldSpacing;
            txtField.anchors.horizontalCenter = root.horizontalCenter;
        }
        else if (textPosition == "right")
        {
            txtField.anchors.left = imgOn.right;
            txtField.anchors.leftMargin = fieldSpacing;
            txtField.anchors.verticalCenter = root.verticalCenter;
        }
        else
        {
            txtField.anchors.right = imgOn.left;
            txtField.anchors.rightMargin = fieldSpacing;
            txtField.anchors.verticalCenter = root.verticalCenter;
        }
    }

    Component.onCompleted: {
        updateTextPosition();
    }

}
