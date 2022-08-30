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
    property variant timeField
    property int hours
    property int minutes
    property int seconds
    property string period
    property bool showPeriod
    property bool showSeconds

    property color backgroundColor
    property color buttonBackgroundColor
    property color borderColor: "#ffffff"
    property int borderWidth: 2
    property int borderRadius: 4
    property int spacing: 10
    property string caption: "Set Time"
    property color captionFontColor
    property variant captionFont
    property color timeFontColor
    property variant timeFont
    property url imagePlusUp
    property url imagePlusDown
    property url imageMinusUp
    property url imageMinusDown
    property url imagePeriodUp
    property url imagePeriodDown
    property url timeBgImage
    property url buttonImageUp
    property url buttonImageDown
    property color buttonFontColor
    property variant buttonFont


    function handleCancel(){
        hide();
    }

    function handleSet(time)
    {
        timeField.hours = tp.hours;
        timeField.minutes = tp.minutes;
        timeField.seconds = tp.seconds;
        timeField.period = tp.period;
        hide();
    }

    function show()
    {
        rootObject = popupEditor.parent;
        timeField = popupEditor.parent;
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
       source: "images/keyboardbg.png"
       width: parent.width
       height: parent.height
   }

   Column {
       width: parent.width
       height: parent.height
           TimePicker {
               id: tp
               editor: popupEditor
               hours: popupEditor.hours
               minutes: popupEditor.minutes
               seconds: popupEditor.seconds
               period: popupEditor.period
               showSeconds: popupEditor.showSeconds
               showPeriod: popupEditor.showPeriod
               backgroundColor: popupEditor.backgroundColor
               buttonBackgroundColor: popupEditor.buttonBackgroundColor
               borderColor: popupEditor.borderColor
               borderWidth: popupEditor.borderWidth
               borderRadius: popupEditor.borderRadius
               spacing: popupEditor.spacing
               caption: popupEditor.caption
               captionFontColor: popupEditor.captionFontColor
               captionFont: popupEditor.captionFont
               timeFontColor: popupEditor.timeFontColor
               timeFont: popupEditor.timeFont
               imagePlusUp: popupEditor.imagePlusUp
               imagePlusDown: popupEditor.imagePlusDown
               imageMinusUp: popupEditor.imageMinusUp
               imageMinusDown: popupEditor.imageMinusDown
               imagePeriodUp: popupEditor.imagePeriodUp
               imagePeriodDown: popupEditor.imagePeriodDown
               timeBgImage: popupEditor.timeBgImage
               buttonImageUp: popupEditor.buttonImageUp
               buttonImageDown: popupEditor.buttonImageDown
               buttonFontColor: popupEditor.buttonFontColor
               buttonFont: popupEditor.buttonFont
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


