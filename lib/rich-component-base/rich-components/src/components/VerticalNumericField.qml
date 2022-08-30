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

Rectangle {
    id: control

    property alias label: labelItem
    property alias input: textItem
    property int fieldSpacing: 6
    property real max
    property real min
    property variant value: maskedInput.length > 0 ? input.text : parseFloat(input.text)
    property url normalKeyIcon: "../images/key_off.png"
    property url pressedKeyIcon: "../images/key_on.png"
    property int keyWidth: 38
    property int keyHeight: 40
    property url keyboardBackGroundImage: "../images/keyboardbg.png"
    property int keyboardAnimationSpeed: 100
    property string keyTextColor: "#ffffff"
    property bool keyTextBold: false
    property int keyTextFontSize: 14

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
    property alias maskedInput : textItem.maskedInput
    property string validator : ""

    color: "Transparent"

    width: Math.max(labelItem.width, textItem.width)
    height: labelItem.height + textItem.height + fieldSpacing
    clip: true

    Column {
        id: content
        height: parent.height;
        width: parent.width
        spacing: control.fieldSpacing

        Text {
            id: labelItem
            text: "Label"
            font.pixelSize: 12
            width: parent.width
        }

        LineEdit{
            id: textItem
            font.pixelSize: 12
            width: parent.width
        }

    }


    MouseArea {
        anchors.fill: parent
        z: 100
        onReleased: {
            var rootObject = control.parent;
            var keypad = popupEditor.createObject(control);
            if (keypad) {
                keypad.label.text = label.text;
                keypad.text.text = input.text;               
                keypad.show();
            }
        }
    }

    Component {
        id: popupEditor

        VerticalPopupNumericEditor {
            label.font: labelItem.font
            label.color: labelItem.color
            font: input.font
            text.width: input.width
            normalKeyIcon: control.normalKeyIcon
            pressedKeyIcon: control.pressedKeyIcon
            keyWidth: control.keyWidth
            keyHeight: control.keyHeight
            bgImage: control.keyboardBackGroundImage
            animationSpeed: control.keyboardAnimationSpeed
            min: control.min
            max: control.max
            keyTextColor: control.keyTextColor
            keyTextBold: control.keyTextBold
            keyTextFontSize: control.keyTextFontSize
            validator: control.validator
            maskedInput: control.maskedInput

            onKeyPress: {                
                if (key === KeyCodes.keyEnter)
                {
                    textItem.text = text.text;
                    hide();
                }
            }

        }
    }

}
