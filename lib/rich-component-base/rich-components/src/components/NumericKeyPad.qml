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

Grid {
    id: control
    property url normalKeyIcon: "../images/key_off.png"
    property url pressedlKeyIcon: "../images/key_on.png"
    property int keySpacing: 10
    property int keyWidth: 28
    property int keyHeight: 40
    property color keyTextColor: "#ffffff"
    property bool keyTextBold: false
    property int keyTextFontSize: 14

    property variant keyDefs: 

            [
                {keyCap: '1', keyCode: '1', normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon},
                {keyCap: '2', keyCode: '2', normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon},
                {keyCap: '3', keyCode: '3', normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon},
                {keyCap: '4', keyCode: '4', normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon},
                {keyCap: '5', keyCode: '5', normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon},
                {keyCap: '6', keyCode: '6', normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon},
                {keyCap: '7', keyCode: '7', normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon},
                {keyCap: '8', keyCode: '8', normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon},
                {keyCap: '9', keyCode: '9', normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon},
                {keyCap: '0', keyCode: '0', normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon},
                {keyCap: '-', keyCode: '-', normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon},
                {keyCap: 'Backspace', keyCode: KeyCodes.keyBackspace, normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon},
                {keyCap: 'Enter', keyCode: KeyCodes.keyEnter, normalKeyIcon: control.normalKeyIcon, pressedlKeyIcon: control.pressedlKeyIcon}
            ]
    columns: 3
    spacing: control.keySpacing

    Repeater {
        id: repeater

        model: control.keyDefs

        Key {
            keyCap: repeater.model[index].keyCap
            keyCode: repeater.model[index].keyCode
            width: control.keyWidth
            height: control.keyHeight
            textColor: control.keyTextColor
            font.bold: control.keyTextBold
            font.pixelSize: control.keyTextFontSize
            normalKeyIcon: repeater.model[index].normalKeyIcon ? repeater.model[index].normalKeyIcon: normalKeyIcon//control.normalKeyIcon
            pressedKeyIcon: repeater.model[index].pressedKeyIcon ? repeater.model[index].pressedKeyIcon : pressedlKeyIcon//control.pressedlKeyIcon
            onReleased: handleKeyPress(keyCode)
        }
    }
}
