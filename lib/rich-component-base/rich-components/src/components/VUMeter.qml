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

Dial{
    id: vumeter
    value: model.get(0).value //-20.0
    min: model.get(0).value //-20.0
    max:  model.get(model.count-1).value //3.0
    // Width and height dictated by the background image
    width: 377; height: 242

    // Set the images
    backgroundImage: "../images/vu_background.png"
    needleImage: "../images/vu_needle.png"
    needleImageWidth: 8
    needleImageHeight: 139

    overlayImage: "../images/vu_overlay.png"
    overlayImageWidth: 39
    overlayImageHeight: 26

    // Set the needle position
    needleX: 181
    needleY: 57
    // Set the overlay image position
    overlayX: 168
    overlayY: 191
    // Set the position of the needle image where the rotation moves around
    needleRotationX: 4
    needleRotationY: 139
    // Set the initial angle of the needle rotation
    angle: model.get(0).angle//-55
    property alias model: model

    ListModel{
        id: model

        ListElement{ value: -20.0; angle: -55; x: 181; y: 57}
        ListElement{ value: -10.0; angle: -41; x: 182; y: 58}
        ListElement{ value:  -7.0; angle: -30; x: 185; y: 61}
        ListElement{ value:  -6.0; angle: -25; x: 185; y: 63}
        ListElement{ value:  -5.0; angle: -20; x: 185; y: 64}
        ListElement{ value:  -4.0; angle: -14; x: 186; y: 64}
        ListElement{ value:  -3.0; angle:  -6; x: 185; y: 64}
        ListElement{ value:  -2.0; angle:   1; x: 186; y: 64}
        ListElement{ value:  -1.0; angle:  10; x: 185; y: 64}
        ListElement{ value:  -0.5; angle:  15; x: 185; y: 65}
        ListElement{ value:   0.0; angle:  20; x: 184; y: 65}
        ListElement{ value:   0.5; angle:  26; x: 183; y: 65}
        ListElement{ value:   1.0; angle:  31; x: 183; y: 65}
        ListElement{ value:   2.0; angle:  42; x: 187; y: 62}
        ListElement{ value:   3.0; angle:  55; x: 187; y: 62}
    }

    onValueChanged: {

        if (value > max)
        {
            value = max;
            angle = 55;
            needleX = 187;
            needleY = 62;
        }
        else if (value < min)
        {
             value = min;
             angle = -55;
             needleX = 181;
             needleY = 57;
        }
        else
        {
            var valueScale = 0.0;
            for (var i=0; i < model.count-1; i++)
            {
                if (value == model.get(i).value)
                {
                    angle = model.get(i).angle;
                    needleX = model.get(i).x;
                    needleY = model.get(i).y
                    break;
                }
                else if (value == model.get(i+1).value)
                {
                    angle = model.get(i+1).angle;
                    needleX = model.get(i+1).x;
                    needleY = model.get(i+1).y
                    break;
                }
                else if (value > model.get(i).value && value < model.get(i+1).value)
                {
                    valueScale = (value - model.get(i).value) /(model.get(i+1).value - model.get(i).value);                    
                    angle = valueScale * (model.get(i+1).angle - model.get(i).angle) + model.get(i).angle;                    
                    break;
                }

            }
        }

    }

}
