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

Column {
    id: control
    property url normalKeyIcon: "../images/key_off.png"
    property url pressedlKeyIcon: "../images/key_on.png"
    property int keySpacing: 10
    property int keyWidth: 28
    property int keyHeight: 40
    property bool loaded: false;
    property variant popupEditor
    property color keyTextColor: "#ffffff"
    property bool keyTextBold: false
    property int keyTextFontSize: 14

    signal mouseEvent
    spacing: control.keySpacing


    Row{
        id: row1
        objectName: "row1"
        spacing: control.keySpacing
    }


    Row{
        id: row2
        objectName: "row2"
        spacing: control.keySpacing
        Item{
            width: control.keyWidth/2
            height: control.keyHeight
        }
    }


    Row{
        id: row3
        objectName: "row3"
        spacing: control.keySpacing
        Item{
            width: control.keyWidth/2
            height: control.keyHeight
        }

        Switch {
            id: switchAlt
            width: keyWidth
            height: keyHeight
            on: true
            textOff: KeyCodes.keyUpArrow
            textOn: KeyCodes.keyDownArrow
            textOnBold: control.keyTextBold
            textOnFontFamily: "DejaVu Sans"
            textOffFontFamily: "DejaVu Sans"
            textOnFontSize: control.keyTextFontSize
            textOffFontSize: control.keyTextFontSize
            imageOn: normalKeyIcon
            imageOff: normalKeyIcon
            textOnColor: "Yellow"
            textOffColor: "Yellow"
            textOffBold: control.keyTextBold

            onButtonPress: showAltCodes();
        }

    }



    Row{
        id: row4
        objectName: "row4"
        spacing: control.keySpacing
        Item{
            id: row4Spacer
            width: control.keyWidth/2
            height: control.keyHeight
        }


        Switch {
            id: switchSpecialChars
            width: keyWidth
            height: keyHeight
            on: true
            textOff: "ABC"
            textOn: "12#"
            textOnBold: control.keyTextBold
            textOnFontFamily: "DejaVu Sans"
            textOffFontFamily: "DejaVu Sans"
            textOnFontSize: control.keyTextFontSize
            textOffFontSize: control.keyTextFontSize
            imageOn: normalKeyIcon
            imageOff: normalKeyIcon
            textOnColor: keyTextColor
            textOffColor: keyTextColor
            textOffBold: control.keyTextBold
            onButtonPress: showSpecialChars();
        }
    }


    function showAltCodes()
    {
        if (switchAlt.on)
        {
            updateRows(['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'], ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'], row1, 0);
            updateRows(['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'], ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'], row2, 1);
            updateRows(['', 'z', 'x', 'c', 'v', 'b', 'n', 'm', 'Back'], ['', 'z', 'x', 'c', 'v', 'b', 'n', 'm', KeyCodes.keyBackspace], row3, 2);
        }
        else
        {
            updateRows(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], row1, 0);
            updateRows(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], row2, 1);
            updateRows(['', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'Back'], ['', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', KeyCodes.keyBackspace], row3, 2);
        }
    }

    function showSpecialChars()
    {
        if (switchSpecialChars.on)
        {
            switchAlt.visible = false;
            row4Spacer.visible = false;
            updateRows(['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'], ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'], row1, 0);
            updateRows(['!', '@', '#', '$', '%', '&', '*', '?', '/'], ['!', '@', '#', '$', '%', '&', '*', '?', '/'], row2, 1);
            updateRows(['_', '"', '\'', '(', ')', '-', '+', ';', 'Back'], ['_', '"', '\'', '(', ')', '-', '+', ';', KeyCodes.keyBackspace], row3, 2);
            updateRows([':', ',', 'Space', '.', 'Done'], [':', ',', ' ', '.', KeyCodes.keyEnter] , row4, 2);

        }
        else
        {
            updateRows(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], row1, 0);
            updateRows(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], row2, 1);
            updateRows(['', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'Back'], ['', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', KeyCodes.keyBackspace], row3, 2);
            updateRows(['', ',', 'Space', '.', 'Done'], ['', ',', ' ', '.', KeyCodes.keyEnter] , row4, 2);
            switchAlt.visible = true;
            row4Spacer.visible = true;
        }

    }


    function updateRows(texts, codes, parent, offset)
    {
        for (var i=0; i < parent.children.length; i++)
        {
            if (parent.children[i].objectName)
            {
                parent.children[i].keyCap = texts[i-offset];
                parent.children[i].keyCode = codes[i-offset];

                if (texts[i-offset] === '')
                {
                    parent.children[i].visible = false;
                }
                else
                {
                    parent.children[i].visible = true;
                }
            }
        }
    }

    function createKeys(texts, codes, parent)
    {
        for (var i = 0; i < texts.length; ++i)
        {
            KeyCodes.createKey(popupEditor, parent, texts[i],  codes[i], control.normalKeyIcon, control.pressedlKeyIcon, control.keyHeight, control.keyWidth,
                control.keySpacing, control.keyTextColor, control.keyTextBold, control.keyTextFontSize);
        }
    }


    Component.onCompleted: {
        createKeys(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], row1);
        createKeys(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], row2);
        createKeys(['', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'Back'], ['', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', KeyCodes.keyBackspace], row3);
        createKeys(['', ',', 'Space', '.', 'Done'], ['', ',', ' ', '.', KeyCodes.keyEnter] , row4);
    }
}



