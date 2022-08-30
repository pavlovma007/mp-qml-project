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
    id: slider;
    width: 48;
    height: 184
    property bool completed: false
    property int value: 0
    onValueChanged: {
        if (completed && value < minimum)
            value = minimum;
        if (completed && value > maximum)
            value = maximum;

        if (!mousePressed)
        {
            handle.y = -increment * (value - maximum)
            if (overlay.source)
                overlay.height = handle.y + handle.height/2;
        }
    }

    property bool allowDrag: true
    onAllowDragChanged: {
        if (!allowDrag)
        {
            verticalMouse.enabled = false;
        }
    }

    property real maximum: 10
    property real minimum: 0
    property alias handleX: handle.x
    property int yMin: 2
    property int yMax: sliderTrack.height - handle.height
    property bool mousePressed: false
    property real increment: (yMax - yMin)/(maximum - minimum)
    property alias imageTrack: sliderTrack.source
    property alias imageHandle: handle.source
    property alias imageOverlay: overlay.source
    property bool showHint: true
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

    Image{
        id: sliderTrack
        source: "../images/slider_track.bmp"
        anchors.fill: parent
    }

    BorderImage{
        id: overlay
        smooth: true;

        source: ""
        border { left: 4; top: 10; right: 4; bottom: 10 }
             horizontalTileMode: BorderImage.Stretch
             verticalTileMode: BorderImage.Stretch
    }

    Rectangle{
        id: recValue
        height: hintHeight
        radius: hintRadius
        border.width: hintBorderWidth
        border.color: hintBorderColor
        width: hintWidth
        visible: showHint && verticalMouse.pressed
        anchors.horizontalCenter:  parent.horizontalCenter
        color: hintBackgroundColor
        Text {
            id: txtValue
            anchors.centerIn: parent
            text: slider.value.toFixed(1).toString();
            font.pixelSize: 14
            color: hintFontColor
        }

    }

    Image {
        id: handle
        smooth: true
        x: 0
        source: "../images/slider_handle.png"


        MouseArea {
            id: verticalMouse
            anchors.fill: parent; drag.target: parent
            drag.axis: Drag.YAxis; drag.minimumY: slider.yMin; drag.maximumY: slider.yMax

            onPressed: mousePressed = true;
            onReleased: mousePressed = false;

            onPositionChanged: {
                value = ((-handle.y + yMin)/increment) + maximum;

                if (overlay.source)
                    overlay.height = handle.y + handle.height/2;

                if (handle.y < handle.height/2)
                {
                    //Set to bottom of handle
                    recValue.y = handle.y + handle.height;
                }
                else
                {
                    //Set to top of handle
                    recValue.y = handle.y - recValue.height;
                }


            }
        }
    }


    Component.onCompleted: {
        handle.y = (maximum - value) * increment;
        handle.x = slider.handleX
        recValue.y = handle.y - recValue.height;
        if (overlay.source)
            overlay.height = handle.y + handle.height/2;
        completed = true;
    }
}
