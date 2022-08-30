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

Image {
    id: spinner
    property string displayText: ""
    property real min: 0
    property real max: 10
    property real value: 0
    property real increment: 1
    property int precision: 0
    property bool autoRepeat: true
    property int autoRepeatInterval: 50
    property alias leftImageUp: btnLeft.imageUp
    property alias leftImageDown: btnLeft.imageDown
    property alias rightImageUp: btnRight.imageUp
    property alias rightImageDown: btnRight.imageDown
    property alias textColor: txtNumber.color
    property alias textFontFamily: txtNumber.font.family
    property alias textFontPixelSize: txtNumber.font.pixelSize
    property alias textFontBold: txtNumber.font.bold
    property alias textFontItalic: txtNumber.font.italic
    property alias textFontUnderline: txtNumber.font.underline
    property alias textFontStrikeout: txtNumber.font.strikeout

    fillMode: Image.TileHorizontally
    source: "../images/bg_numericedit.png"
    asynchronous: true
    width: 100
    height: 30

    ImageButton {
        id: btnLeft
        anchors.left: parent.left
        width: parent.height
        height: parent.height
        text: ""
        autoRepeat: spinner.autoRepeat
        autoRepeatInterval: spinner.autoRepeatInterval
        imageUp: "../images/left_arrow_spin.png"
        imageDown: "../images/left_arrow_spin_off.png"
        onButtonClick: {
            value -= increment;
            if (value < min)
            {
                value = min;
                btnLeft.enabled = false;
                btnLeft.opacity = 0.6;
            }
            else
            {
                btnRight.enabled = true;
                btnRight.opacity = 1.0;
            }
        }
    }

    ImageButton {
        id: btnRight
        anchors.right: parent.right
        width: parent.height
        height: parent.height
        autoRepeat: spinner.autoRepeat
        autoRepeatInterval: spinner.autoRepeatInterval
        anchors.rightMargin: 0
        text: ""
        imageUp: "../images/right_arrow_spin.png"
        imageDown: "../images/right_arrow_spin_off.png"
        onButtonClick: {
            value += increment;
            if (value > max)
            {
                value = max;
                btnRight.enabled = false;
                btnRight.opacity = 0.6;
            }
            else
            {
                btnLeft.enabled = true;
                btnLeft.opacity = 1.0;
            }
        }
    }

    Text{
        id: txtNumber
        height: parent.height
        text: parent.displayText.length > 0 ? parent.value.toFixed(parent.precision) + parent.displayText
                                     : parent.value.toFixed(parent.precision)
        font.pixelSize: 16
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.left: btnLeft.right
        anchors.right: btnRight.left

    }
}
