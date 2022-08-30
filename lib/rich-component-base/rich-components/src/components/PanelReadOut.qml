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

Item{
    id: control
    property alias imagePanel: imgPanel.source
    property alias text: txtReadOut.text
    property alias textColor: txtReadOut.color
    property alias font: txtReadOut.font

    BorderImage {
        id: imgPanel
        anchors.fill: parent
        source: "../images/bezel.bmp"

        Text{
            id: txtReadOut
            text: "100000"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: "DejaVu Sans"
            font.pixelSize: 12
            color: "#50dd0e"
        }

    }
}
