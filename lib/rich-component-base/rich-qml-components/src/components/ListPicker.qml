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
    id: root
    width: 272
    height: 236
    color: "#424242"
    radius: borderRadius
    border.width: borderWidth
    border.color: borderColor
    property alias backgroundColor: root.color
    property color borderColor: "#ffffff"
    property int borderWidth: 2
    property int borderRadius: 4
    property int spacing: 10
    property string caption: "Set List"
    property alias captionFontColor: txtMessage.color
    property alias captionFont: txtMessage.font
    property string listBackgroundColor: "#efefef"
    property string highlightColor: "steelblue"
    property alias listFontColor: txtList.color
    property alias listFont: txtList.font
    property variant editor
    property int initialIndex
    property alias model: list.model
    property alias currentIndex: list.currentIndex
    property variant value
    property int listItemHeight: 32

    onValueChanged: {
        for (var i=0; i<list.count; i++)
        {
            if (list.model.get(i).value == value)
            {
                list.currentIndex = i;
                return;
            }
        }
    }

    property bool completed: false
    property int scrollBarWidth: 10

    signal handleSet(string value)
    signal handleCancel

    onHandleSet: {
        if (editor)
        {
            editor.handleSet(value);
        }
    }

    onHandleCancel: {
        if (editor)
            editor.handleCancel();
    }

    ListModel {
        id: listModel

        ListElement {
            text: "1"
            value: 1
        }
        ListElement {
            text: "2"
            value: 2
        }
        ListElement {
            text: "3"
            value: 3
        }
        ListElement {
            text: "4"
            value: 4
        }
        ListElement {
            text: "5"
            value: 5
        }
        ListElement {
            text: "6"
            value: 6
        }
        ListElement {
            text: "7"
            value: 7
        }
        ListElement {
            text: "8"
            value: 8
        }
        ListElement {
            text: "9"
            value: 9
        }
        ListElement {
            text: "10"
            value: 10
        }
    }


    Text{
        id: txtList
        font.family: "DejaVu Sans"
        font.pixelSize: 22
        color: "#000000"
    }

    Row {
        id: rowText
        width: parent.width
        height: txtMessage.height + (root.spacing * 2)

        Item {
            width: parent.width
            height: parent.height
            Text {
                id: txtMessage
                text: root.caption
                anchors.centerIn: parent
                font.family: captionFont.family
                font.bold: captionFont.bold
                font.pixelSize: captionFont.pixelSize
                color: captionFontColor
            }
        }
    }


    Row {
        id: rowList
        spacing: 0
        anchors.top : rowText.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.border.width
        anchors.left: parent.left
        anchors.leftMargin: root.border.width
        anchors.right: parent.right
        anchors.rightMargin: root.border.width

        Rectangle{
            width: rowList.width
            height: rowList.height
            color: listBackgroundColor
            clip: true

            ListView {
                focus: true
                id: list
                boundsBehavior: Flickable.StopAtBounds
                anchors.fill: parent
                model: listModel
                delegate: listDelegate
                highlight: Rectangle { color: highlightColor }
                highlightFollowsCurrentItem: true
                highlightMoveDuration: 9999
            }

            ListViewScrollBar {
                scrollArea: list;
                height: list.height;
                width: scrollBarWidth
                anchors.right: list.right
           }
        }
    }

    Component{
        id: listDelegate
        Item {
            id: delegate
            width: list.width; height: listItemHeight

            Text {
                text: model.text
                color: txtList.color
                font: txtList.font
                anchors {
                    left: parent.left; leftMargin: spacing
                    verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                width: delegate.width; height: 1; color: "#cccccc"
                anchors.bottom: delegate.bottom
                visible: delegate.ListView.isCurrentItem ? false : true
            }

            Rectangle {
                width: delegate.width; height: 1; color: "white"
                visible: delegate.ListView.isCurrentItem ? false : true
            }

            MouseArea {
                anchors.fill: delegate
                onClicked: {
                    list.currentIndex = index
                    root.value = list.model.get(index).value;
                    timer.start();
                }
            }
        }

    }

    Timer {
        id: timer
        interval: 100;
        running: false;
        repeat: false
        onTriggered: handleSet(root.value);
    }

    onInitialIndexChanged: {
        list.currentIndex = initialIndex;
        root.value = list.model.get(initialIndex).value;
    }

    function setValue()
    {
        for (var i=0; i<list.count; i++)
        {
            if (list.model.get(i).value == root.value)
            {
                list.currentIndex = i;
                return;
            }
        }
    }


}
