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
    id: popupEditor

    property int animationSpeed: 200
    property alias bgImage: bgImage.source
    property variant rootObject
    property variant listField
    property variant value

    property color backgroundColor
    property color borderColor: "#ffffff"
    property int borderWidth: 2
    property int borderRadius: 4
    property int spacing: 10
    property string caption: "Set List"
    property color captionFontColor
    property variant captionFont
    property string listBackgroundColor
    property string highlightColor
    property string listFontColor
    property variant listFont
    property variant initialValue
    property int initialIndex
    property variant model
    property int scrollBarWidth
    property int listItemHeight

    function handleCancel(){
        hide();
    }

    function handleSet(value)
    {
        listField.value = value;
        hide();
    }

    function show()
    {
        rootObject = popupEditor.parent;
        listField = popupEditor.parent;
        while (rootObject.parent && rootObject.parent.width)
        {
            rootObject = rootObject.parent;
        }

        popupEditor.parent = rootObject;
        popupEditor.width = rootObject.width;
        popupEditor.height = rootObject.height;
        popupEditor.x = 0;
        popupEditor.y = 0;
        showAnim.from = rootObject.height;
        showAnim.to = 0;
        showAnim.start();
    }

    function hide()
    {
        hideAnim.start();
    }

    width: content.width
    height: content.height

    MouseArea{
        anchors.fill: parent
    }

   Image {
       id: bgImage
       source: "../images/keyboardbg.png"
       width: parent.width
       height: parent.height
   }

   Column {
       width: parent.width
       height: parent.height
           ListPicker {
               id: lp
               editor: popupEditor
               backgroundColor: popupEditor.backgroundColor
               borderColor: popupEditor.borderColor
               borderWidth: popupEditor.borderWidth
               borderRadius: popupEditor.borderRadius
               spacing: popupEditor.spacing
               caption: popupEditor.caption
               captionFontColor: popupEditor.captionFontColor
               captionFont: popupEditor.captionFont
               listBackgroundColor: popupEditor.listBackgroundColor
               highlightColor: popupEditor.highlightColor
               listFontColor: popupEditor.listFontColor
               listFont: popupEditor.listFont
               value: popupEditor.value
               initialIndex: popupEditor.initialIndex
               model: popupEditor.model
               scrollBarWidth: popupEditor.scrollBarWidth
               listItemHeight: popupEditor.listItemHeight
           }
   }

   PropertyAnimation {
        id: showAnim

        target: popupEditor
        property: "y"
        duration: animationSpeed
    }

    SequentialAnimation {
        id: hideAnim

        PropertyAnimation {
            target: popupEditor
            property: "y"
            to: popupEditor.parent.height
            duration: animationSpeed
        }
        ScriptAction {
            script: popupEditor.destroy()
        }
    }


    Component.onCompleted: {
    }

}



