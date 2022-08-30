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
import QtQuick 1.0

Dial{
    id: speedometer
    value: 0
    min: 0
    max:120
    // Width and height dictated by the background image
    width: 210; height: 210

    // Set the images
    backgroundImage: "../images/meterbackground.png"
    needleImage: "../images/needle.png"
    needleImageWidth: 8
    needleImageHeight: 63

    overlayImage: "../images/overlay.png"
    overlayImageWidth: 148
    overlayImageHeight: 105

    // Set the needle position
    needleX: 98
    needleY: 33
    // Set the overlay image position
    overlayX: 21
    overlayY: 18
    // Set the position of the needle image where the rotation moves around
    needleRotationX: 5
    needleRotationY: 65

    minAngle: -130
    maxAngle: 133
    // Set the initial angle of the needle rotation
    angle: minAngle
    property real scaleFactor: (maxAngle - minAngle)/(max-min)

    onValueChanged: {
        //Math that will change the angle
        angle = Math.min(Math.max(minAngle, value * scaleFactor + minAngle), maxAngle);
    }

    onScaleFactorChanged: {
        angle = Math.min(Math.max(minAngle, value * scaleFactor + minAngle), maxAngle);
    }


    Component.onCompleted: {
        angle = Math.min(Math.max(minAngle, value * scaleFactor + minAngle), maxAngle);
    }
}
