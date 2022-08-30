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
 ** Based on Chart.js
 **
 ** Chart.js
 ** http://chartjs.org/
 **
 ** Copyright 2013 Nick Downie
 ** Released under the MIT license
 ** https://github.com/nnnick/Chart.js/blob/master/LICENSE.md
 **
****************************************************************************/
import QtQuick 2.0

Rectangle {
    id: root
    width: 280
    height: 240
    color: "#424242"
    radius: borderRadius
    border.width: borderWidth
    border.color: borderColor
    property alias backgroundColor: root.color
    property alias buttonBackgroundColor: rowButtons.color
    property color borderColor: "#ffffff"
    property int borderWidth: 2
    property int borderRadius: 4
    property int spacing: 10
    property string caption: "Set Date"
    property alias captionFontColor: txtMessage.color
    property alias captionFont: txtMessage.font
    property alias dateFontColor: txtDate.color
    property alias dateFont: txtDate.font
    property alias imagePlusUp: btnMonthPlus.imageUp
    property alias imagePlusDown: btnMonthPlus.imageDown
    property alias imageMinusUp: btnMonthMinus.imageUp
    property alias imageMinusDown: btnMonthMinus.imageDown
    property alias dateBgImage: monthBg.source
    property alias buttonImageUp: btnSet.imageUp
    property alias buttonImageDown: btnSet.imageDown
    property alias buttonFontColor: btnSet.textColor
    property alias buttonFont: btnSet.font
    property int month

    function setVisibleMonth()
    {
        switch (month) {
        case 1:
            visibleMonth = "Jan";
            maxDay = 31;
            break;
        case 2:
            visibleMonth = "Feb"
            if (year % 4 == 0)
                maxDay = 29;
            else
                maxDay = 28;
            if (day > maxDay)
                day = maxDay;
            break;
        case 3:
            visibleMonth = "Mar";
            maxDay = 31;
            break;
        case 4:
            visibleMonth = "Apr";
            maxDay = 30;
            if (day > maxDay)
                day = maxDay;
            break;
        case 5:
            visibleMonth = "May";
            maxDay = 31;
            break;
        case 6:
            visibleMonth = "Jun";
            maxDay = 30;
            if (day > maxDay)
                day = maxDay;
            break;
        case 7:
            visibleMonth = "Jul";
            maxDay = 31;
            break;
        case 8:
            visibleMonth = "Aug";
            maxDay = 31;
            break;
        case 9:
            visibleMonth = "Sep";
            maxDay = 30;
            if (day > maxDay)
                day = maxDay;
            break;
        case 10:
            visibleMonth = "Oct";
            maxDay = 31;
            break;
        case 11:
            visibleMonth = "Nov";
            maxDay = 30;
            if (day > maxDay)
                day = maxDay;
            break;
        case 12:
            visibleMonth = "Dec";
            maxDay = 31;
            break;
        }

    }

    onMonthChanged: {
        if (month > maxMonth)
            month = minMonth;
        else if (month < minMonth)
            month = maxMonth;

        setVisibleMonth();
    }

    property string visibleMonth
    property int minMonth: 1
    property int maxMonth: 12
    property int day

    onDayChanged: {
        if (day > maxDay)
            day = minDay;
        else if (day < minDay)
            day = maxDay;
    }

    property string visibleDay: day < 10 ? "0" + day.toString() : day.toString()
    property int minDay: 1
    property int maxDay: 31
    property int year

    onYearChanged: {
        if (year > maxYear)
            year = minYear;
        else if (year < minYear)
            year = maxYear;

        if (year % 4 == 0 && month == 2)
            maxDay = 29;
    }

    property int minYear: 2000
    property int maxYear: 2030

    property string visibleYear: year.toString()
    property variant editor

    signal handleSet
    signal handleCancel

    onHandleSet: {
        if (editor)
            editor.handleSet();
    }

    onHandleCancel: {
        if (editor)
            editor.handleCancel();
    }

    Text{
        id: txtDate
        font.family: "DejaVu Sans"
        font.pixelSize: 22
    }

    Row {
        id: rowText
        width: parent.width
        height: txtMessage.height + (root.spacing*2)

        Item {
            width: parent.width
            height: parent.height
            Text {
                id: txtMessage
                anchors.centerIn: parent
                text: root.caption
                font.family: "DejaVu Sans"
                font.bold: false
                font.pixelSize: 24
                color: "#ffffff"
            }
        }
    }


    Row {
        id: rowDate
        spacing: 0
        anchors.horizontalCenter: root.horizontalCenter
        anchors.horizontalCenterOffset: -root.spacing
        anchors.top : rowText.bottom

        Column {
            id: colMonth

            Image {
                id: monthBg
                source: "../images/pickerBg.png"

                ImageButton {
                    id: btnMonthPlus
                    width: 62
                    height: 39
                    anchors.top: parent.top
                    text: ""
                    font.bold: false
                    textColor: "#000000"
                    imageDown: "../images/plusDown.png"
                    font.family: "DejaVu Sans"
                    font.pixelSize: 18
                    imageUp: "../images/plusUp.png"
                    autoRepeat: true
                    autoRepeatInterval: 100

                    onButtonClick: {
                        month += 1;
                    }
                }

                Text {
                    text: visibleMonth
                    font: txtDate.font
                    anchors.centerIn: parent
                    color: dateFontColor
                }

                ImageButton {
                    id: btnMonthMinus
                    width: 62
                    height: 39
                    anchors.bottom: parent.bottom
                    text: ""
                    font.bold: false
                    textColor: "#000000"
                    imageDown: "../images/minusDown.png"
                    font.family: "DejaVu Sans"
                    font.pixelSize: 18
                    imageUp: "../images/minusUp.png"
                    autoRepeat: true
                    autoRepeatInterval: 100

                    onButtonClick: {
                        month -= 1;
                    }
                }
            }
        }

        Column {
            width: root.spacing
            height: parent.height

            Item {
                width: parent.width
                height: parent.height
                Text {
                    text: ""
                    font: txtDate.font
                    anchors.centerIn: parent
                }
            }
        }

        Column {
            id: colDay

            Image {
                source: monthBg.source

                ImageButton {
                    id: btnDayPlus
                    width: 62
                    height: 39
                    anchors.top: parent.top
                    text: ""
                    font.bold: false
                    textColor: "#000000"
                    imageDown: btnMonthPlus.imageDown
                    font.family: "DejaVu Sans"
                    font.pixelSize: 18
                    imageUp: btnMonthPlus.imageUp
                    autoRepeat: true
                    autoRepeatInterval: 100

                    onButtonClick: {
                        day += 1;
                    }
                }

                Text {
                    text: visibleDay
                    font: txtDate.font
                    anchors.centerIn: parent
                    color: dateFontColor
                }

                ImageButton {
                    id: btnDayMinus
                    width: 62
                    height: 39
                    anchors.bottom: parent.bottom
                    text: ""
                    font.bold: false
                    textColor: "#000000"
                    imageDown: btnMonthMinus.imageDown
                    font.family: "DejaVu Sans"
                    font.pixelSize: 18
                    imageUp: btnMonthMinus.imageUp
                    autoRepeat: true
                    autoRepeatInterval: 100

                    onButtonClick: {
                        day -= 1;
                    }
                }
            }
        }

        Column {
            id: colYearSpacer
            width: root.spacing
            height: parent.height

            Item{
                width: parent.width
                height: parent.height
                Text {
                    text: ""
                    font: txtDate.font
                    anchors.centerIn: parent
                    color: "#ffffff"
                }
            }
        }

        Column {
            id: colYear
            Image {
                source: monthBg.source

                ImageButton {
                    id: btnYearPlus
                    width: 62
                    height: 39
                    anchors.top: parent.top
                    text: ""
                    font.bold: false
                    textColor: "#000000"
                    imageDown: btnMonthPlus.imageDown
                    font.family: "DejaVu Sans"
                    font.pixelSize: 18
                    imageUp: btnMonthPlus.imageUp
                    autoRepeat: true
                    autoRepeatInterval: 100

                    onButtonClick: {
                        year += 1;
                    }
                }

                Text {
                    text: visibleYear
                    font: txtDate.font
                    anchors.centerIn: parent
                    color: dateFontColor
                }

                ImageButton {
                    id: btnYearMinus
                    width: 62
                    height: 39
                    anchors.bottom: parent.bottom
                    text: ""
                    font.bold: false
                    textColor: "#000000"
                    imageDown: btnMonthMinus.imageDown
                    font.family: "DejaVu Sans"
                    font.pixelSize: 18
                    imageUp: btnMonthMinus.imageUp
                    autoRepeat: true
                    autoRepeatInterval: 100

                    onButtonClick: {
                        year -= 1;
                    }
                }
            }
        }

    }

    Row {
        id: rowSpacer
        height: 16
        width: parent.width
        anchors.top : rowDate.bottom
    }

    Rectangle {
        id: rowButtons
        width: parent.width - (root.border.width * 2)
        height: btnSet.height + root.spacing
        anchors.top : rowSpacer.bottom
        color: "#bbb7bb"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.border.width
        anchors.left: parent.left
        anchors.leftMargin: root.border.width

        Row {
            spacing: root.spacing
            anchors.centerIn: parent
            Column {
                ImageButton {
                    id: btnSet
                    width: 131
                    height: 43
                    text: "Set"
                    font.bold: false
                    textColor: "#000000"
                    imageDown: "../images/widthButtonDown.png"
                    font.family: "DejaVu Sans"
                    font.pixelSize: 18
                    imageUp: "../images/widthButtonUp.png"

                    onButtonClick: handleSet();
                }
            }

            Column {
                ImageButton {
                    id: btnCancel
                    width: 131
                    height: 43
                    text: "Cancel"
                    font: btnSet.font
                    textColor: btnSet.textColor
                    imageDown: btnSet.imageDown
                    imageUp: btnSet.imageUp

                    onButtonClick: handleCancel();
                }
            }
        }
    }


    Component.onCompleted: {
        setVisibleMonth();
    }
}
