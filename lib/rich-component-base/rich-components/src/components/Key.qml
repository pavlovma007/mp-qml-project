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
import "../js/keycodes.js" as KeyCodes

Item {
    id: control
    property string keyCap
    property url normalKeyIcon: "../images/key_off.png"
    property url pressedKeyIcon: "../images/key_on.png"
    property string keyCode
    property bool isPressed: false
    property variant editor
    property alias textColor: keyText.color
    property alias font: keyText.font

    signal pressed
    signal released

    width: 28
    height: 40

    onPressed: {
        if (editor)
            editor.handleKeyPress(keyCode);
    }

    onReleased: {
        if (editor)
            editor.showKeyHint(keyCode);
    }

    BorderImage {
        id: img
        width: control.width
        height: control.height
        asynchronous: true
        border { left: 2; top: 2; right: 2; bottom: 2 }
        source: control.isPressed && control.pressedKeyIcon.toString().length
                ? control.pressedKeyIcon : control.normalKeyIcon
    }

    Text {
        id: keyText

        anchors.centerIn: img
        text: keyCap
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: {
            control.isPressed = true;
            control.pressed();
        }
        onReleased:  {
            control.isPressed = false;
            control.released();
        }
    }

}

