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

Canvas {
    width: 256
    height: 300
    id: graph
    color: "transparent"
    property int centerX: width/2
    property int centerY: height/2
    //Number - the maximum number for intensity
    property int max: 20
    //Number - the minimum number for intensity
    property int min: 0
    //Number - Radius to draw the heat image
    property int radius: 20
    //Bool - Whether we calculate intensity
    property bool calculateIntensity: true
    //Number - this needs to be set if we do not calculate intensity (0 - 1 range)
    property real intensity: 0.2
    property alias model: data
    property variant ctx: graph.getContext("2d")
    property variant image1
    property variant image2
    property variant image3
    property variant image4
    property variant image5
    property variant image6
    property variant image7
    property variant image8
    property variant image9
    property variant image10
    property variant images: []

    Image {
        id: designerImage
        source: "../images/heatmap.png"
        anchors.fill: parent
    }

    ListModel{
        id: data
        ListElement
        {
            x: 10
            y: 20
            count: 18
        }
        ListElement
        {
            x: 25
            y : 50
            count : 14
        }
        ListElement
        {
            x: -50
            y : -10
            count : 10
        }
        ListElement
        {
            x: 12
            y: 22
            count : 16
        }
        ListElement
        {
            x: 1
            y: 2
            count : 4
        }
    }

    function draw()
    {
        image1 = ctx.createImage("src/images/0.1_small.png");
        image2 = ctx.createImage("src/images/0.2_small.png");
        image3 = ctx.createImage("src/images/0.3_small.png");
        image4 = ctx.createImage("src/images/0.4_small.png");
        image5 = ctx.createImage("src/images/0.5_small.png");
        image6 = ctx.createImage("src/images/0.6_small.png");
        image7 = ctx.createImage("src/images/0.7_small.png");
        image8 = ctx.createImage("src/images/0.8_small.png");
        image9 = ctx.createImage("src/images/0.9_small.png");
        image10 = ctx.createImage("src/images/1_small.png");

        images = [image1, image2, image3, image4, image5, image6, image7, image8, image9, image10];

        ctx.fillStyle = "transparent";
        ctx.fillRect(0,0, graph.width, graph.height);

        if(image1.width > 0)
        {
            designerImage.visible = false;
        }

        //First we draw the dark intensity
        for (var i=0; i < data.count; i++)
        {
            var x = centerX + data.get(i).x
            var y = centerY + data.get(i).y

            if (calculateIntensity)
                intensity = ((data.get(i).count - min)/(max - min)).toFixed(1);
            else
                intensity = intensity.toFixed(1);

            if (intensity > 0)
            {
                var index  = intensity * 10;
                ctx.drawImage(images[index], x - (radius), y - (radius), radius*2, radius*2);
            }
        }

        ctx.createHeatMap(0,0, graph.width, graph.height, 0, 0);
    }



    Component.onCompleted:{
        draw();
    }
}
