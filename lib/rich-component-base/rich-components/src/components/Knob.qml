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
    id: view
    height: 180
    width: 180
    color: "transparent"
    property alias model: repeater.model
    property real degreeAngle : 360.0/repeater.model.count
    property real digitAngle : degreeAngle/57.2957795
    property real angleOffSet:  90.0 + degreeAngle/2 //We rotate the needle around the positive x axis in a downward position
    property real knobValue
    //Use value to set the knobValue directly without user intervention
    property real value
    property real index
    property int initialIndex: 0
    property alias imageBase: imgDialBase.source
    property alias imageNeedle: dialer.source
    property alias mouseAreaHeight: mouseArea.height
    property alias mouseAreaWidth: mouseArea.width
    property bool firstLoad: true
    property bool add: false;
    property bool remove: false;
    property alias imageBaseWidth: imgDialBase.width
    property alias imageBaseHeight: imgDialBase.height
    property alias imageNeedleWidth: dialer.width
    property alias imageNeedleHeight: dialer.height
    property color textColor: "White"
    property alias font: textFont.font
    property bool showHint: true
    property alias hintFontFamily: txtValue.font.family
    property alias hintFontPixelSize: txtValue.font.pixelSize
    property alias hintFontPointSize: txtValue.font.pointSize
    property alias hintFontBold: txtValue.font.bold
    property alias hintFontItalic: txtValue.font.italic
    property alias hintFontUnderline: txtValue.font.underline
    property alias hintFontStrikeout: txtValue.font.strikeout
    property int hintWidth: 40
    property int hintHeight: 40
    property color hintBackgroundColor: "#ffffff"
    property int hintRadius: 9
    property color hintBorderColor: "#000000"
    property int hintBorderWidth: 2
    property color hintFontColor: "#000000"

    /* List element for the control */
    ListModel{
        id: data
        ListElement{
            index: 0
            value: 0
        }
        ListElement{
            index: 1
            value: 1
        }
        ListElement{
            index: 2
            value: 2
        }
        ListElement{
            index: 3
            value: 3
        }
        ListElement{
            index: 4
            value: 4
        }
        ListElement{
            index: 5
            value: 5
        }
    }

    onValueChanged: {
        var valueScale = 0;
        var indexScale = 0;

        for (var i = 0; i < repeater.model.count-1; i++)
        {
            if (value >= repeater.model.get(i).value && value <= repeater.model.get(i+1).value)
            {
                valueScale = (value - repeater.model.get(i).value)/(repeater.model.get(i+1).value - repeater.model.get(i).value);
                indexScale = repeater.model.get(i).index + valueScale;
                //now that we know the index we can rotate the needle       
                knobValue = value;
                dialer.rotation = angleOffSet + indexScale * degreeAngle;
                break;
            }

        }

    }

    onInitialIndexChanged: {
        dialer.rotation = angleOffSet + initialIndex * degreeAngle;
    }

    onIndexChanged: {
        //calculate the value using extrapolation

        var valueScale = 0;
        var indexScale = 0;
        for (var i = 0; i < repeater.model.count-1; i++)
        {
            if (index >= repeater.model.get(i).index && index <= repeater.model.get(i+1).index)
            {
                valueScale = (repeater.model.get(i+1).value - repeater.model.get(i).value);
                indexScale = index - repeater.model.get(i).index;

                knobValue = valueScale * indexScale + repeater.model.get(i).value;
                break;
            }

        }

    }

    onAngleOffSetChanged: {
        if (angleOffSet > 90)
        {
            var count = repeater.model.count-1;
            if (remove)
                count += 1;

            for (var i = 0; i < count; i++)
            {
                try
                {
                    numbers.children[i].rotation = -angleOffSet;
                }
                catch (err)
                {
                    //console.debug(i);
                }
            }

            numbers.rotation = angleOffSet;
            dialer.rotation = angleOffSet;
            add = false;
            remove = false;
        }
    }


    Text{
        id: textFont
        font.pointSize:9
        font.bold: false
    }

    Image {
        id: imgDialBase
        source: "../images/dialbase.png"
        anchors.centerIn: parent

    }

    Image {
        id: dialer
        source: "../images/dialneedle.png"
        smooth: true
        anchors.centerIn: parent

    }


    MouseArea {
        id: mouseArea
        height: 77
        width: 77
        anchors.centerIn: parent

        onPositionChanged: {
             dialer.rotation = getEventAngle(mouse);
        }
        onReleased: {
             dialer.rotation = getEventAngle(mouse);
        }
        onPressed: {
            dialer.rotation = getEventAngle(mouse);
        }
    }

    Rectangle{
        id: recValue
        height: hintHeight
        radius: hintRadius
        border.width: hintBorderWidth
        border.color: hintBorderColor
        width: hintWidth
        visible: showHint && mouseArea.pressed
        anchors.horizontalCenter:  parent.horizontalCenter
        color: hintBackgroundColor

        Text {
            id: txtValue
            anchors.centerIn: parent
            text: view.knobValue.toFixed(1).toString();
            font.pixelSize: 14
            color: hintFontColor
        }

    }

    /**************************************************************/
    /* This section will draw the numbers around the outer circle.*/
    /**************************************************************/
    Rectangle {
        id: numbers
        anchors.fill: parent
        color: "transparent"

        Repeater {
            id: repeater
            model: data
            delegate:
                Rectangle {
                width: 30
                height: 30
                color: "transparent"
                x: view.width / 2 + (imgDialBase.width * 0.60) * Math.cos((-index) * digitAngle) - 15
                y: view.height / 2 - (imgDialBase.width * 0.60) * Math.sin((-index) * digitAngle) - 15

                Text {
                    color: textColor
                    font.pointSize: textFont.font.pointSize
                    anchors.centerIn: parent
                    font.bold: textFont.font.bold
                    text: value
                    style: Text.Sunken
                }
                Component.onCompleted: {
                    rotation = -angleOffSet;
                }
            }

          anchors.centerIn: parent
      }

    }


    function getEventAngle(event)
    {
        var angle = Math.atan2(event.y - 46, event.x - 46);

        recValue.x = event.x + recValue.width;
        recValue.y = event.y + recValue.height * 2;

        if(angle < 0)
            angle += 2 * Math.PI;

        //1 radian = 57.2957795 degrees
        var angleCalc = angle * 57.2957795 - angleOffSet;

        if (angleCalc < 0)
            angleCalc = angleCalc += 360.0;

        view.index = angleCalc / degreeAngle;
        return (angle * 57.2957795);
    }


    Component.onCompleted : {
        numbers.rotation = angleOffSet;
        dialer.rotation = angleOffSet + initialIndex * degreeAngle;
        firstLoad = false;

    }

}
