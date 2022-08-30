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
    property variant dateField
    property int month
    property int day
    property int year
    property color backgroundColor
    property color buttonBackgroundColor
    property color borderColor: "#ffffff"
    property int borderWidth: 2
    property int borderRadius: 4
    property int spacing: 10
    property string caption: "Set Time"
    property color captionFontColor
    property variant captionFont
    property color dateFontColor
    property variant dateFont
    property url imagePlusUp
    property url imagePlusDown
    property url imageMinusUp
    property url imageMinusDown
    property url imagePeriodUp
    property url imagePeriodDown
    property url dateBgImage
    property url buttonImageUp
    property url buttonImageDown
    property color buttonFontColor
    property variant buttonFont
    property int maxYear
    property int minYear

    function handleCancel(){
        hide();
    }

    function handleSet()
    {
        dateField.year = dp.year;
        dateField.month = dp.month;
        dateField.day = dp.day;
        dateField.visibleMonth = dp.visibleMonth;

        var mask = dateField.dateMask;
        var mm = "";
        if (dp.month > 9)
            mm = dp.month.toString();
        else
            mm = "0" + dp.month.toString();

        mask = mask.replace("mon", dp.visibleMonth);
        mask = mask.replace("mm", mm);
        mask = mask.replace("yyyy", dp.year.toString());
        mask = mask.replace("yy", dp.year.toString().substring(2,4));
        mask = mask.replace("dd", dp.visibleDay);
        dateField.date = mask;
        hide();
    }

    function show()
    {
        rootObject = popupEditor.parent;
        dateField = popupEditor.parent;
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
           DatePicker {
               id: dp
               editor: popupEditor
               year: popupEditor.year
               month: popupEditor.month
               day: popupEditor.day
               backgroundColor: popupEditor.backgroundColor
               buttonBackgroundColor: popupEditor.buttonBackgroundColor
               borderColor: popupEditor.borderColor
               borderWidth: popupEditor.borderWidth
               borderRadius: popupEditor.borderRadius
               spacing: popupEditor.spacing
               caption: popupEditor.caption
               captionFontColor: popupEditor.captionFontColor
               captionFont: popupEditor.captionFont
               dateFontColor: popupEditor.dateFontColor
               dateFont: popupEditor.dateFont
               imagePlusUp: popupEditor.imagePlusUp
               imagePlusDown: popupEditor.imagePlusDown
               imageMinusUp: popupEditor.imageMinusUp
               imageMinusDown: popupEditor.imageMinusDown
               buttonImageUp: popupEditor.buttonImageUp
               buttonImageDown: popupEditor.buttonImageDown
               buttonFontColor: popupEditor.buttonFontColor
               buttonFont: popupEditor.buttonFont
               minYear: popupEditor.minYear
               maxYear: popupEditor.maxYear
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


