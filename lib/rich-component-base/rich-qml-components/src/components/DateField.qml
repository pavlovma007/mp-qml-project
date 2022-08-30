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
    objectName: "dateField"

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

    property color backgroundColor: "#424242"
    property color buttonBackgroundColor: "#bbb7bb"
    property color borderColor: "#ffffff"
    property int borderWidth: 2
    property int borderRadius: 4
    property int spacing: 10
    property string caption: "Set Date"
    property color captionFontColor: "#ffffff"
    property alias captionFont: captionFont.font
    property color dateFontColor: "#000000"
    property alias dateFont : dateFont.font
    property url imagePlusUp: "../images/plusUp.png"
    property url imagePlusDown: "../images/plusDown.png"
    property url imageMinusUp: "../images/minusUp.png"
    property url imageMinusDown: "../images/minusDown.png"
    property url imagePeriodUp: "../images/ampmUp.png"
    property url imagePeriodDown: "../images/ampmDown.png"
    property url dateBgImage:  "../images/pickerBg.png"
    property url buttonImageUp: "../images/widthButtonUp.png"
    property url buttonImageDown: "../images/widthButtonDown.png"
    property color buttonFontColor: "#000000"
    property alias buttonFont : buttonFont.font

    property int year
    property int minYear
    property int maxYear
    property int day
    property int month
    property string visibleMonth
    property string visibleDay
    property string dateMask: "mm/dd/yyyy"
    property string date: ""

    color: "Transparent"

    width: labelItem.width + textItem.width + fieldSpacing
    height: Math.max(labelItem.font.pixelSize, textItem.height + 4)
    clip: true

    onDateMaskChanged: createMask();

    onYearChanged: createMask();

    onMonthChanged: {
        if (dateMask.indexOf("mon") >= 0)
        {
            if (month > 12)
                month = 12;
            else if (month < 1)
                month = 1;

            switch (month) {
            case 1:
                visibleMonth = "Jan";
                break;
            case 2:
                visibleMonth = "Feb"
                break;
            case 3:
                visibleMonth = "Mar";
                break;
            case 4:
                visibleMonth = "Apr";
                break;
            case 5:
                visibleMonth = "May";
                break;
            case 6:
                visibleMonth = "Jun";
                break;
            case 7:
                visibleMonth = "Jul";
                break;
            case 8:
                visibleMonth = "Aug";
                break;
            case 9:
                visibleMonth = "Sep";
                break;
            case 10:
                visibleMonth = "Oct";
                break;
            case 11:
                visibleMonth = "Nov";
                break;
            case 12:
                visibleMonth = "Dec";
                break;
            }
        }
        else
        {
            if (month > 9)
                visibleMonth = month.toString();
            else
                visibleMonth = "0" + month.toString();
        }

        createMask();
    }

    onDayChanged: {
        if (day > 9)
            visibleDay = day.toString();
        else
            visibleDay = "0" + day.toString();
        createMask();
    }

    Text{
        id: captionFont
        font.family: "DejaVu Sans"
        font.bold: false
        font.pixelSize: 24
        visible: false
    }

    Text{
        id: dateFont
        font.family: "DejaVu Sans"
        font.bold: false
        font.pixelSize: 22
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
            text: date
        }
    }


    MouseArea {
        anchors.fill: parent
        z: 100

        onReleased: {
            //var rootObject = control.parent;
            var keypad = popupEditor.createObject(control);
            if (keypad) {
                keypad.year = year;
                keypad.month = month;
                keypad.day = day;
                keypad.show();
            }
        }
    }

    Component {
        id: popupEditor

        PopupDateEditor {
            bgImage: control.keyboardBackGroundImage
            animationSpeed: control.keyboardAnimationSpeed
            backgroundColor: control.backgroundColor
            buttonBackgroundColor: control.buttonBackgroundColor
            borderColor: control.borderColor
            borderWidth: control.borderWidth
            borderRadius: control.borderRadius
            spacing: control.spacing
            caption: control.caption
            captionFontColor: control.captionFontColor
            captionFont: control.captionFont
            dateFontColor: control.dateFontColor
            dateFont: control.dateFont
            imagePlusUp: control.imagePlusUp
            imagePlusDown: control.imagePlusDown
            imageMinusUp: control.imageMinusUp
            imageMinusDown: control.imageMinusDown
            imagePeriodUp: control.imagePeriodUp
            imagePeriodDown: control.imagePeriodDown
            dateBgImage: control.dateBgImage
            buttonImageUp: control.buttonImageUp
            buttonImageDown: control.buttonImageDown
            buttonFontColor: control.buttonFontColor
            buttonFont: control.buttonFont
            minYear: control.minYear
            maxYear: control.maxYear
        }

    }

    function getYear()
    {
        return year;
    }

    function setYear(year)
    {
        control.year = year;
    }

    function getMonth()
    {
        return month;
    }

    function setMonth(month)
    {
        control.month = month;
    }

    function getDay()
    {
        return day;
    }

    function setDay(day)
    {
        control.day = day;
    }

    function getDate()
    {
        return textItem.text;
    }

    function createMask()
    {
        var mask = dateMask;
        var mm = "";
        if (month > 10)
            mm = month.toString();
        else
            mm = "0" + month.toString();

        mask = mask.replace("mon", visibleMonth);
        mask = mask.replace("mm", mm);
        mask = mask.replace("yyyy", year);
        mask = mask.replace("yy", year.toString().substring(2,4));
        mask = mask.replace("dd", visibleDay);
        date = mask;
    }

    Component.onCompleted: {
        if (month > 0)
            createMask();
    }
}

