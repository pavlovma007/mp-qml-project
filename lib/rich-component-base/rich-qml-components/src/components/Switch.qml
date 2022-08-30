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
    property url imageOn: "../images/internal_button_dn.bmp"
    property url imageOff: "../images/internal_button_up.bmp"
    property alias textOn: textOn.text
    property alias textOnFontFamily: textOn.font.family
    property alias textOnFontSize: textOn.font.pixelSize
    property alias textOnColor: textOn.color
    property alias textOnBold: textOn.font.bold
    property alias textOff: textOff.text
    property alias textOffFontFamily: textOff.font.family
    property alias textOffFontSize: textOff.font.pixelSize
    property alias textOffColor: textOff.color
    property alias textOffBold: textOff.font.bold
    property bool on : false
    property string value : ""
    property bool enabled: true
    color: "Transparent"

    width: 64
    height:64

    signal buttonClick()
    onButtonClick: {
    }

    signal buttonPress()
    onButtonPress: {
        on = !on;
    }

    signal buttonRelease()
    onButtonRelease: {
    }

    BorderImage {
        id: border_image1
        source: on ? imageOn : imageOff
        anchors.fill: parent
        opacity: !root.disabled ? 1.0 : 0.5
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.enabled
        onClicked: buttonClick()
        onPressed: buttonPress()
        onReleased: buttonRelease()
    }

    Text {
        id: textOn
        text: "On"
        anchors.centerIn: parent
        font.pixelSize: 12
        visible: on
        color: textOnColor
    }

    Text {
        id: textOff
        text: "Off"
        anchors.centerIn: parent
        font.pixelSize: 12
        visible: !on
        color: textOffColor
    }

}
