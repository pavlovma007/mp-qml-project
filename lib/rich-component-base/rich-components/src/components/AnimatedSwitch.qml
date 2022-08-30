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

Item {
    id: animatedSwitch
    //width: background.width
    width: 130
    height: 56
    //height: background.height
    property alias imageOff : background.source
    property alias sliderImage: slider.source
    property int sliderImageOffX: 78
    property int sliderImageOnX: 1
    property int sliderImageY: 2
    property int textOffX: 78
    property int textOnX: 18
    property alias imageOn: onImage.source
    property bool on: false
    property alias imageOffWidth : background.width
    property alias imageOffHeight : background.height
    property alias imageOnWidth : onImage.width
    property alias imageOnHeight : onImage.height
    property string textOn: "On"
    property string textOff: "Off"
    property alias textColor: txt.color;
    property alias font: txt.font


    onOnChanged: {
        if (on)
            animatedSwitch.state = "on";
        else
            animatedSwitch.state = "off";
    }


    function toggle() {
        if (animatedSwitch.state == "on")
        {
            animatedSwitch.state = "off";
            on = false;
        }
        else
        {
            animatedSwitch.state = "on";
            on = true;
        }
    }

    function releaseSwitch() {
        if (slider.x == sliderImageOnX) {
            if (animatedSwitch.state == "off") return;
        }
        if (slider.x == sliderImageOffX) {
            if (animatedSwitch.state == "on") return;;
        }
        toggle();
    }

    Image {
             id: background
             source: "../images/background.svg"
             anchors.fill: parent
             MouseArea { anchors.fill: parent; onClicked: toggle() }
    }

    Image {
             id: onImage
             source: ""
             opacity: 0
             MouseArea { anchors.fill: parent; onClicked: toggle() }
             Behavior on opacity { PropertyAnimation { duration: 500 } }
    }

    Text{
        id: txt
        x:textOffX
        text: on ? textOn : textOff
        color: "#ffffff"
        font.pixelSize: 20
        font.family: "Georgia"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        height: parent.height
        Behavior on x { SmoothedAnimation { velocity: 100 } }

    }

    Image {
        id: slider
        x: sliderImageOnX; y: sliderImageY
        source: "../images/knob.svg"
        Behavior on x { SmoothedAnimation { velocity: 300 } }

        MouseArea {
             anchors.fill: parent
             drag.target: slider; drag.axis: Drag.XAxis; drag.minimumX: sliderImageOnX; drag.maximumX: sliderImageOffX
             onClicked: toggle()
             onReleased: releaseSwitch()
        }
    }

    states: [
             State {
                 name: "on"
                 PropertyChanges { target: slider; x: sliderImageOffX }
                 PropertyChanges { target: txt; x: textOnX; text: textOn;}
                 PropertyChanges { target: onImage; opacity: 1.0 }
             },
             State {
                 name: "off"
                 PropertyChanges { target: slider; x: sliderImageOnX }
                 PropertyChanges { target: txt; x: textOffX; text: textOff}
                 PropertyChanges { target: onImage; opacity: 0; }
             }
         ]


    Component.onCompleted: {
       if (on)
           animatedSwitch.state = "on";
       else
           animatedSwitch.state = "off";
    }
}
