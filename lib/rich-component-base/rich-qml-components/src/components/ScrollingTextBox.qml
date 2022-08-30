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
    id: main
    width: 320
    height: 240
    property int maxChars: 2048
    property int textMargins: 4
    property string textEditBackGroundColor: "#000000"
    property int borderWidth: 2
    property string borderColor: "#9a9a9a"
    property string headerText: "Terminal"
    property string headerTextFontFamily : "DejaVu Sans"
    property string headerTextColor: "#ffffff"
    property int headerTextFontSize: 15
    property bool headerTextFontBold: true
    property string textEditFontFamily : "DejaVu Sans"
    property string textEditColor: "#52D017"
    property int textEditFontSize: 12
    property bool textEditFontBold: false
    property string initialText : ""
    property color gradientLightColor: "#9a9a9a"
    property color gradientDarkColor: "#4e4e4e"
    property int headerHeight: 30
    property string scrollBarBackGroundColor: "gray"
    property string scrollBarBorderColor: "#000000"
    property int scrollBarBorderWidth: 1
    property int scrollBarWidth: 12
    property string scrollBarColor: "#545454"
    property string scrollBarHighLight: "#5454ac"
    property string scrollBarUpDownArrowColor: "#000000"
    property string scrollBarUpDownArrowHighLight: "blue"
    property bool showScrollBarUpDownArrow: true

    onInitialTextChanged: concatText(initialText);

    Rectangle{
        id: header
        anchors.top: main.top
        width: main.width
        height: headerHeight
        border.width: borderWidth
        border.color: borderColor
        gradient: Gradient {
            GradientStop {position: 0.0; color: gradientLightColor}
            GradientStop {position: 0.5; color: gradientDarkColor}
            GradientStop {position: 1.0; color: gradientLightColor}
        }

        Text{
            id: headerTitle
            text: headerText
            font.bold: headerTextFontBold
            height: parent.height
            color: headerTextColor
            style: Text.Sunken
            font.pixelSize: headerTextFontSize
            font.family: headerTextFontFamily
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            anchors.leftMargin: textMargins + body.border.width
        }
    }

    Rectangle{
        id: body
        radius: 1
        anchors.top: header.bottom
        anchors.bottom: main.bottom
        anchors.left: main.left
        anchors.right: main.right
        border.width: borderWidth
        border.color: borderColor
        color: textEditBackGroundColor

        Flickable {
            id: flickArea
             anchors.fill: parent
             anchors.margins: main.textMargins
             contentWidth: textEdit.width;
             contentHeight: textEdit.height - textEditFontSize
             flickableDirection: Flickable.VerticalFlick
             clip: true
             boundsBehavior : Flickable.StopAtBounds

             TextEdit{
                  id: textEdit
                   wrapMode: TextEdit.Wrap
                   width: body.width;
                   readOnly:true
                   font.family: textEditFontFamily
                   font.pixelSize: textEditFontSize
                   font.bold: textEditFontBold
                   color: textEditColor
                   text: ""
             }

        }

        ScrollBar{
            flickable: flickArea
            handleSize: scrollBarWidth
            backGroundColor: scrollBarBackGroundColor
            scrollBarColor: scrollBarColor
            borderColor: scrollBarBorderColor
            borderWidth: scrollBarBorderWidth
            scrollBarHighLight: scrollBarHighLight
            arrowColor: scrollBarUpDownArrowColor
            arrowHighLight: scrollBarUpDownArrowHighLight
            showArrow: showScrollBarUpDownArrow
        }
    }

    function clear()
    {
        textEdit.text = "";
    }

    function concatText(text)
    {
        textEdit.text += text;
        if (textEdit.text.length > maxChars)
        {
            var count = textEdit.text.length - maxChars;
            textEdit.text = textEdit.text.substring(count, textEdit.text.length);
        }

        if (flickArea.contentHeight > body.height)
            flickArea.contentY = flickArea.contentHeight - flickArea.height;
    }

    function prependText(text)
    {
        textEdit.text = text + textEdit.text;
        if (textEdit.text.length > maxChars)
        {
            var count = textEdit.text.length - maxChars;
            textEdit.text = textEdit.text.substring(0, textEdit.text.length);
        }
    }

    Component.onCompleted: {

    }
}

