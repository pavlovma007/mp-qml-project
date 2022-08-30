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
    width: 300
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
    property int spacing: 6
    property string caption: "Set Time"
    property alias captionFontColor: txtMessage.color
    property alias captionFont: txtMessage.font
    property alias timeFontColor: txtTime.color
    property alias timeFont: txtTime.font
    property alias imagePlusUp: btnHoursPlus.imageUp
    property alias imagePlusDown: btnHoursPlus.imageDown
    property alias imageMinusUp: btnHoursMinus.imageUp
    property alias imageMinusDown: btnHoursMinus.imageDown
    property alias imagePeriodUp: imagePeriod.imageUp
    property alias imagePeriodDown: imagePeriod.imageDown
    property alias timeBgImage: hoursBg.source
    property alias buttonImageUp: btnSet.imageUp
    property alias buttonImageDown: btnSet.imageDown
    property alias buttonFontColor: btnSet.textColor
    property alias buttonFont: btnSet.font
    property int hours: 0

    onHoursChanged: {
        if (hours > maxHours)
            hours = minHours;
        else if (hours < minHours)
            hours = maxHours;
    }

    property string visibleHours: hours < 10 ? "0" + hours.toString() : hours.toString()
    property int minHours: 1
    property int maxHours: 12
    property int minutes: 0

    onMinutesChanged: {
        if (minutes > maxMinutes)
            minutes = minMinutes;
        else if (minutes < minMinutes)
            minutes = maxMinutes;
    }

    property string visibleMinutes: minutes < 10 ? "0" + minutes.toString() : minutes.toString()
    property int minMinutes: 0
    property int maxMinutes: 59
    property int seconds: 0

    onSecondsChanged: {
        if (seconds > maxMinutes)
            seconds = minMinutes;
        else if (seconds < minMinutes)
            seconds = maxMinutes;
    }

    property string visibleSeconds: seconds < 10 ? "0" + seconds.toString() : seconds.toString()
    property bool showSeconds: true
    property bool showPeriod: true
    property variant editor
    property string period: "AM"

    signal handleSet
    signal handleCancel

    onHandleSet: {
        if (editor)
            editor.handleSet(getTime());
    }

    onHandleCancel: {
        if (editor)
            editor.handleCancel();
    }

    Text{
        id: txtTime
        font.family: "DejaVu Sans"
        font.pixelSize: 28
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
                font.family: captionFont.family
                font.bold: captionFont.bold
                font.pixelSize: captionFont.pixelSize
                color: captionFontColor
            }
        }
    }

    Row {
        id: rowTime
        spacing: 0
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.top : rowText.bottom
        anchors.left : parent.left
        anchors.leftMargin: root.spacing

        Column {
            id: colHours

            Image {
                id: hoursBg
                source: "../images/pickerBg.png"

                ImageButton {
                    id: btnHoursPlus
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
                        hours += 1;
                    }
                }

                Text {
                    text: visibleHours
                    font: txtTime.font
                    anchors.centerIn: parent
                    color: timeFontColor
                }

                ImageButton {
                    id: btnHoursMinus
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
                        hours -= 1;
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
                    text: ":"
                    font: txtTime.font
                    anchors.centerIn: parent
                    color: "#ffffff"
                }
            }
        }

        Column {
            id: colMinutes

            Image {
                source: hoursBg.source

                ImageButton {
                    id: btnMinutesPlus
                    width: 62
                    height: 39
                    anchors.top: parent.top
                    text: ""
                    font.bold: false
                    textColor: "#000000"
                    imageDown: btnHoursPlus.imageDown
                    font.family: "DejaVu Sans"
                    font.pixelSize: 18
                    imageUp: btnHoursPlus.imageUp
                    autoRepeat: true
                    autoRepeatInterval: 100

                    onButtonClick: {
                        minutes += 1;
                    }
                }

                Text {
                    text: visibleMinutes
                    font: txtTime.font
                    anchors.centerIn: parent
                    color: timeFontColor
                }

                ImageButton {
                    id: btnMinutesMinus
                    width: 62
                    height: 39
                    anchors.bottom: parent.bottom
                    text: ""
                    font.bold: false
                    textColor: "#000000"
                    imageDown: btnHoursMinus.imageDown
                    font.family: "DejaVu Sans"
                    font.pixelSize: 18
                    imageUp: btnHoursMinus.imageUp
                    autoRepeat: true
                    autoRepeatInterval: 100

                    onButtonClick: {
                        minutes -= 1;
                    }
                }
            }
        }

        Column {
            id: colSecondsSpacer
            visible: showSeconds
            width: root.spacing
            height: parent.height

            Item{
                width: parent.width
                height: parent.height
                Text {
                    text: ":"
                    font: txtTime.font
                    anchors.centerIn: parent
                    color: "#ffffff"
                }
            }
        }

        Column {
            id: colSeconds
            visible: showSeconds
            Image {
                source: hoursBg.source

                ImageButton {
                    id: btnSecondsPlus
                    width: 62
                    height: 39
                    anchors.top: parent.top
                    text: ""
                    font.bold: false
                    textColor: "#000000"
                    imageDown: btnHoursPlus.imageDown
                    font.family: "DejaVu Sans"
                    font.pixelSize: 18
                    imageUp: btnHoursPlus.imageUp
                    autoRepeat: true
                    autoRepeatInterval: 100

                    onButtonClick: {
                        seconds += 1;
                    }
                }

                Text {
                    text: visibleSeconds
                    font: txtTime.font
                    anchors.centerIn: parent
                    color: timeFontColor
                }

                ImageButton {
                    id: btnSecondsMinus
                    width: 62
                    height: 39
                    anchors.bottom: parent.bottom
                    text: ""
                    font.bold: false
                    textColor: "#000000"
                    imageDown: btnHoursMinus.imageDown
                    font.family: "DejaVu Sans"
                    font.pixelSize: 18
                    imageUp: btnHoursMinus.imageUp
                    autoRepeat: true
                    autoRepeatInterval: 100

                    onButtonClick: {
                        seconds -= 1;
                    }
                }
            }
        }

        Column {
            id: colPeriodSpacer
            width: root.spacing
            height: parent.height
            visible: showPeriod
        }

        Column {
            id: colPeriod
            visible: showPeriod
            height: colHours.height
            width: colHours.width
            Item {
                width: parent.width
                height: parent.height

                ImageButton {
                    id: imagePeriod
                    anchors.verticalCenter: parent.verticalCenter
                    width: 64
                    height: 41
                    text: root.period
                    textColor: timeFontColor
                    imageDown: "../images/ampmDown.png"
                    font: timeFont
                    imageUp: "../images/ampmUp.png"

                    onButtonClick: {
                        if (root.period == "AM")
                            root.period = "PM";
                        else
                            root.period = "AM";
                    }
                }
            }
        }
    }

    Row {
        id: rowSpacer
        height: 16
        width: parent.width
        anchors.top : rowTime.bottom
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

                    onButtonClick: handleSet(getTime());
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

}
