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

Item {
    id: root
    property alias imageUp: border_image1.source
    property alias imageDown: border_image2.source
    property alias text: text.text
    property int textXCenterOffSet: 0
    property int textYCenterOffSet: 0
    property alias textColor: text.color
    property bool disabled: false
    property bool autoRepeat: false
    property int autoRepeatInterval: 200
    property alias font: text.font

    width: 64
    height:64

    signal buttonClick()
    onButtonClick: {
    }

    signal buttonPress()
    onButtonPress: {
    }

    signal buttonRelease()
    onButtonRelease: {
    }

    Timer {
        id: autoRepeatTimer
        triggeredOnStart: false
        interval: autoRepeatInterval
        repeat: true
        running: autoRepeat && mouseArea.pressed
        onTriggered: {
            buttonPress();
            buttonRelease();
            buttonClick();
        }
    }

    BorderImage {
        id: border_image1
        visible: !mouseArea.pressed
        anchors.fill: parent
        opacity: !root.disabled ? 1.0 : 0.5
        asynchronous: true
    }

    BorderImage {
        id: border_image2
        visible: mouseArea.pressed
        anchors.fill: parent
        asynchronous: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: buttonClick()
        onPressed: buttonPress()
        onReleased: buttonRelease()
        enabled: !root.disabled
    }

    Text {
        id: text
        text: ""
        color: "#000000"
        anchors.verticalCenterOffset: textYCenterOffSet
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: textXCenterOffSet
        font.pixelSize: 12
    }
}
