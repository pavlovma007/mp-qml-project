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
    id: root
    property string startPosition : "left"
    property int increment: 19
    property int minValue: 0
    property int maxValue: 10
    property int value: 0
    property real valueScale: 1.0
    property string symbol: ""
    property alias imageOverlay: overlay.source
    property alias imageBase: base.source
    width: base.width
    height: base.height
    clip: true
    property bool showHint: true
    property alias hintFontFamily: txtValue.font.family
    property alias hintFontPixelSize: txtValue.font.pixelSize
    property alias hintFontPointSize: txtValue.font.pointSize
    property alias hintFontBold: txtValue.font.bold
    property alias hintFontItalic: txtValue.font.italic
    property alias hintFontUnderline: txtValue.font.underline
    property alias hintFontStrikeout: txtValue.font.strikeout
    property color hintFontColor: "#000000"

    onStartPositionChanged: {
        updateOverlayX();
    }

    onValueChanged: {
        if (value > maxValue)
            value = maxValue;
        else if (value < minValue)
            value = minValue;

        updateOverlayX();
    }

    Image{
        id:base
        source: "../images/tank.png"
    }

    Image{
       id: overlay
       source: "../images/tank_overlay.png"
    }

    Text{
        id: txtValue
        anchors.centerIn: base
        text: (root.value * root.valueScale).toFixed(0).toString() + root.symbol;
        font.pixelSize: 14
        color: hintFontColor
        visible: showHint
    }

    function updateOverlayX() {
    if (startPosition == "right")
        overlay.x = 0 - increment * Math.abs(value - minValue);
    else
        overlay.x = 0 + increment * Math.abs(value - minValue);

    }

    Component.onCompleted: {
        updateOverlayX();
    }
}

