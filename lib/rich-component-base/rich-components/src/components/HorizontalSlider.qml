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
import QtQuick 1.0

Item {
    id: slider;
    width: 184
    height: 48

    property bool allowDrag: true
    property bool completed: false;
    property int value: 0
    property int maximum: 10
    property int minimum: 0
    property int xMax: sliderTrack.width - handle.width
    property int xMin: 0
    property alias handleY: handle.y
    property alias imageTrack: sliderTrack.source
    property alias imageHandle: handle.source
    property alias imageOverlay: overlay.source
    property bool showHint: true
    property bool mousePressed: false
    property alias hintFontFamily: txtValue.font.family
    property alias hintFontPixelSize: txtValue.font.pixelSize
    property alias hintFontPointSize: txtValue.font.pointSize
    property alias hintFontBold: txtValue.font.bold
    property alias hintFontItalic: txtValue.font.italic
    property alias hintFontUnderline: txtValue.font.underline
    property alias hintFontStrikeout: txtValue.font.strikeout
    property int hintWidth: 40
    property int hintHeight: 40
    property color hintBackgroundColor: "#ffffff"
    property int hintRadius: 9
    property color hintBorderColor: "#000000"
    property int hintBorderWidth: 2
    property color hintFontColor: "#000000"

    onValueChanged: {
        if (completed && value < minimum)
            value = minimum;
        if (completed && value > maximum)
            value = maximum;

        if (!mousePressed)
        {
            handle.x = (value - minimum) * ((slider.xMax - slider.xMin) / (maximum - minimum));
            if (overlay.source)
                overlay.width = handle.x + handle.width/2;
        }

    }

    onAllowDragChanged: {
        if (!allowDrag)
            horizontalMouse.enabled = false;
    }

    Image{
        id: sliderTrack
        source: "../images/slider_htrack.png"
        anchors.fill: parent
    }

    BorderImage{
        id: overlay
        smooth: true;
        source: ""
        border { left: 10; top: 4; right: 2; bottom: 4 }
             horizontalTileMode: BorderImage.Stretch
             verticalTileMode: BorderImage.Stretch
    }

    Image {
        id: handle;
        smooth: true
        y: 2;
        source: "../images/slider_handle.png"

        MouseArea {
            id: horizontalMouse
            anchors.fill: parent; drag.target: parent
            drag.axis: Drag.XAxis; drag.minimumX: slider.xMin; drag.maximumX: slider.xMax

            onPressed: mousePressed = true;
            onReleased: mousePressed = false;

            onPositionChanged: {
                value = handle.x / ((slider.xMax - slider.xMin) / (maximum - minimum)) + minimum

                if (overlay.source)
                    overlay.width = handle.x + handle.width/2;

                if (handle.x < slider.xMax - recValue.width)
                    recValue.x = handle.x + handle.width;
                else
                    recValue.x = handle.x - recValue.width;

            }
        }

    }

    Rectangle{
        id: recValue
        height: hintHeight
        radius: hintRadius
        border.width: hintBorderWidth
        border.color: hintBorderColor
        width: hintWidth
        visible: showHint && horizontalMouse.pressed
        anchors.verticalCenter:  parent.verticalCenter
        color: hintBackgroundColor

        Text {
            id: txtValue
            anchors.centerIn: parent
            text: slider.value.toFixed(1).toString();
            font.pixelSize: 14
            color: hintFontColor
        }

    }

    Component.onCompleted: {
        handle.x = (slider.value - minimum) * ((slider.xMax - slider.xMin) / (maximum - minimum));

        if (handle.x < xMin)
            handle.x = xMin;
        else if (handle.x > xMax)
            handle.x = xMax;

        if (overlay.source)
            overlay.width = handle.x + handle.width/2;

        handle.y = slider.handleY
        recValue.x = handle.x + recValue.width;
        completed = true;
    }
}

