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
    objectName: "listField"

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
    property color borderColor: "#ffffff"
    property int borderWidth: 2
    property int borderRadius: 4
    property int spacing: 10
    property int listItemHeight: 32
    property string caption: "Set List"
    property color captionFontColor: "#ffffff"
    property alias captionFont: captionFont.font
    property string listBackgroundColor: "#efefef"
    property string highlightColor: "steelblue"
    property alias listFontColor: listFont.color
    property alias listFont: listFont.font
    property variant value
    property int initialIndex
    property int scrollBarWidth: 10
    property variant model

    color: "Transparent"

    width: Math.max(labelItem.width, textItem.width)
    height: labelItem.height + textItem.height + fieldSpacing
    clip: true

    Text{
        id: captionFont
        font.family: "DejaVu Sans"
        font.bold: false
        font.pixelSize: 24
        visible: false
    }

    Text{
        id: listFont
        font.family: "DejaVu Sans"
        font.bold: false
        font.pixelSize: 22
        visible: false
    }


    Column {
        id: content
        height: parent.height;
        spacing: control.fieldSpacing
        width: parent.width

        Text {
            id: labelItem
            text: "Label"
            width: parent.width
        }

        LineEdit{
            id: textItem
            width: parent.width
            text: control.getText();
        }
    }


    MouseArea {
        anchors.fill: parent
        z: 100

        onReleased: {
            //var rootObject = control.parent;
            var keypad = popupEditor.createObject(control);
            if (keypad) {
                keypad.value = control.value;
                keypad.show();
            }
        }
    }

    Component {
        id: popupEditor

        PopupListEditor {
            bgImage: control.keyboardBackGroundImage
            animationSpeed: control.keyboardAnimationSpeed
            backgroundColor: control.backgroundColor
            borderColor: control.borderColor
            borderWidth: control.borderWidth
            borderRadius: control.borderRadius
            spacing: control.spacing
            caption: control.caption
            captionFontColor: control.captionFontColor
            captionFont: control.captionFont
            listBackgroundColor: control.listBackgroundColor
            highlightColor: control.highlightColor
            listFontColor: control.listFontColor
            listFont: control.listFont
            initialIndex: control.initialIndex
            model: control.model
            scrollBarWidth: control.scrollBarWidth
            listItemHeight: control.listItemHeight
        }

    }

    function getValue()
    {
        return value;
    }

    function getText()
    {
        var text = "";

        for (var i=0; i < model.count; i++)
        {
            if (model.get(i).value == value)
            {
                text = model.get(i).text
            }
        }

        return text;
    }

    Component.onCompleted: {

    }
}

