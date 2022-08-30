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
    id: control
    objectName: "timeField"

    property alias label: labelItem
    property alias input: textItem
    property int fieldSpacing: 6
    property url keyboardBackGroundImage: "../images/keyboardbg.png"
    property int keyboardAnimationSpeed: 100

    property alias labelText: labelItem.text
    property alias labelColor: labelItem.color
    property alias labelFontFamily: labelItem.font.family
    property alias labelFontPixelSize: labelItem.font.pixelSize
    property alias labelFontPointSize: labelItem.font.pointSize
    property alias labelFontBold: labelItem.font.bold
    property alias labelFontItalic: labelItem.font.italic
    property alias labelFontUnderline: labelItem.font.underline
    property alias labelFontStrikeout: labelItem.font.strikeout

    property alias inputText: textItem.text
    property alias inputColor: textItem.color
    property alias inputFontFamily: textItem.font.family
    property alias inputFontPixelSize: textItem.font.pixelSize
    property alias inputFontPointSize: textItem.font.pointSize
    property alias inputFontBold: textItem.font.bold
    property alias inputFontItalic: textItem.font.italic
    property alias inputFontUnderline: textItem.font.underline
    property alias inputFontStrikeout: textItem.font.strikeout
    property bool showSeconds: true
    property bool showPeriod: true

    property color backgroundColor: "#424242"
    property color buttonBackgroundColor: "#bbb7bb"
    property color borderColor: "#ffffff"
    property int borderWidth: 2
    property int borderRadius: 4
    property int spacing: 10
    property string caption: "Set Time"
    property color captionFontColor: "#ffffff"
    property alias captionFont: captionFont.font
    property color timeFontColor: "#000000"
    property alias timeFont : timeFont.font
    property url imagePlusUp: "../images/plusUp.png"
    property url imagePlusDown: "../images/plusDown.png"
    property url imageMinusUp: "../images/minusUp.png"
    property url imageMinusDown: "../images/minusDown.png"
    property url imagePeriodUp: "../images/ampmUp.png"
    property url imagePeriodDown: "../images/ampmDown.png"
    property url timeBgImage:  "../images/pickerBg.png"
    property url buttonImageUp: "../images/widthButtonUp.png"
    property url buttonImageDown: "../images/widthButtonDown.png"
    property color buttonFontColor: "#000000"
    property alias buttonFont : buttonFont.font

    property int hours: 12
    property string visibleHours: hours < 10 ? "0" + hours.toString() : hours.toString()
    property int minutes: 12
    property string visibleMinutes: minutes < 10 ? ":0" + minutes.toString() : ":" + minutes.toString()
    property int seconds: 12
    property string visibleSeconds: seconds < 10 ? (showSeconds ? ":0" + seconds.toString() : "")  :  (showSeconds ? ":" + seconds.toString() : "")
    property string period: "PM"
    property string visiblePeriod: showPeriod ? " " + period : ""

    color: "Transparent"

    width: labelItem.width + textItem.width + fieldSpacing
    height: Math.max(labelItem.font.pixelSize, textItem.height + 4)
    clip: true

    Text{
        id: captionFont
        font.family: "DejaVu Sans"
        font.bold: false
        font.pixelSize: 24
        visible: false
    }

    Text{
        id: timeFont
        font.family: "DejaVu Sans"
        font.bold: false
        font.pixelSize: 24
        visible: false
    }

    Text{
        id: buttonFont
        font.family: "DejaVu Sans"
        font.bold: false
        font.pixelSize: 14
        visible: false
    }

    Row {
        id: content
        height: parent.height;
        spacing: control.fieldSpacing

        Text {
            id: labelItem
            text: "Label"
            font.pixelSize: 12
            anchors.verticalCenter: parent.verticalCenter

        }

        LineEdit{
            id: textItem
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 12
            width: control.width - labelItem.width - fieldSpacing
            text: control.hours > 0 ? control.visibleHours + control.visibleMinutes + control.visibleSeconds + control.visiblePeriod : ""
        }
    }


    MouseArea {
        anchors.fill: parent
        z: 100

        onReleased: {
            //var rootObject = control.parent;
            var keypad = popupEditor.createObject(control);
            if (keypad) {
                keypad.hours = hours;
                keypad.minutes = minutes;
                keypad.seconds = seconds;
                keypad.period = period;
                keypad.show();
            }
        }
    }

    Component {
        id: popupEditor

        PopupTimeEditor {
            bgImage: control.keyboardBackGroundImage
            animationSpeed: control.keyboardAnimationSpeed
            showPeriod: control.showPeriod
            showSeconds: control.showSeconds
            backgroundColor: control.backgroundColor
            buttonBackgroundColor: control.buttonBackgroundColor
            borderColor: control.borderColor
            borderWidth: control.borderWidth
            borderRadius: control.borderRadius
            spacing: control.spacing
            caption: control.caption
            captionFontColor: control.captionFontColor
            captionFont: control.captionFont
            timeFontColor: control.timeFontColor
            timeFont: control.timeFont
            imagePlusUp: control.imagePlusUp
            imagePlusDown: control.imagePlusDown
            imageMinusUp: control.imageMinusUp
            imageMinusDown: control.imageMinusDown
            imagePeriodUp: control.imagePeriodUp
            imagePeriodDown: control.imagePeriodDown
            timeBgImage: control.timeBgImage
            buttonImageUp: control.buttonImageUp
            buttonImageDown: control.buttonImageDown
            buttonFontColor: control.buttonFontColor
            buttonFont: control.buttonFont
        }

    }

    function getHour()
    {
        return hours;
    }

    function setHour(hour)
    {
        hours = hour;
    }

    function getMinute()
    {
        return minutes;
    }

    function setMinute(minute)
    {
        minutes = minute;
    }

    function getSecond()
    {
        return seconds;
    }

    function setSecond(second)
    {
        seconds = second;
    }

    function getPeriod()
    {
        return period;
    }

    function setPeriod(text)
    {
        period = text;
    }

    function getTime()
    {
        return textItem.text;
    }
}

