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

Rectangle
{
    property alias model: view.model
    property alias currentIndex: view.currentIndex
    property int initialIndex: 0
    property variant initialValue
    property variant value: view.model.get(currentIndex).value
    property int itemHeight: 29
    property alias backGroundImage: bgImage.source
    property color textColor: "black"
    property alias highlightImage: hlImage.source
    property alias font: fontText.font

    color: "White"
    height: 216
    width: 100
    border.color: "black"
    radius: 2
    border.width: 3
    clip: true

    ListModel{
        id: data
        ListElement{ text: "1"; value: 1}
        ListElement{ text: "2"; value: 2}
        ListElement{ text: "3"; value: 3}
        ListElement{ text: "4"; value: 4}
        ListElement{ text: "5"; value: 5}
        ListElement{ text: "6"; value: 6}
    }

    Text {
        id: fontText
        font.family: "DejaVu Sans"
        font.pixelSize: 18
        font.bold: false
    }

    Image {
        id: bgImage
        source: "../images/spinner-bg.png"
        width: parent.width
        height: parent.height
    }

    Image {
        id : hlImage
        source: "../images/spinner-select.png"
        visible: false
    }

    PathView {
        id: view
        anchors.fill: parent
        currentIndex: 0
        pathItemCount: view.height/itemHeight
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlight: Image {source: hlImage.source; width: view.width; height: itemHeight+4 }
        dragMargin: view.width/2

        path: Path {
            startX: view.width/2; startY: -itemHeight/2
            PathLine { x: view.width/2; y: view.pathItemCount*itemHeight + itemHeight }
        }

        delegate: spinnerDelegate
    }

    Component{
        id: spinnerDelegate
        Rectangle{
            color: "transparent"
            height: itemHeight

            Text {
                anchors.centerIn: parent;
                color: textColor;
                font.bold: fontText.font.bold;
                font.family: fontText.font.family;
                font.pixelSize: fontText.font.pixelSize;
                text: model.text;
                smooth:true
            }
        }
    }

    Keys.onDownPressed: view.incrementCurrentIndex()
    Keys.onUpPressed: view.decrementCurrentIndex()

    onInitialIndexChanged: {
        view.currentIndex = initialIndex;
    }

    onInitialValueChanged: setInitialValue();

    function setInitialValue()
    {
        for (var i=0; i<view.count; i++)
        {
            if (view.model.get(i).value === initialValue)
            {
                view.currentIndex = i;
                return;
            }
        }
    }

    Component.onCompleted:  {
        if (typeof initialValue !== "undefined")
            setInitialValue();
        else
            view.currentIndex = initialIndex;
    }
}
