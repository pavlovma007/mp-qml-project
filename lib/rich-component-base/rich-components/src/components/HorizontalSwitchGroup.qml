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
    id: switchGroup
    property string value;
    property alias model: listRepeater.model
    property alias font: fontText.font
    property string textOnColor: "#000000"
    property string textOffColor: "#000000"
    property alias spacing: row.spacing
    width: row.width
    height: row.height

    Text {
        id: fontText
        font.family: "DejaVu Sans"
        font.pixelSize: 16
        font.bold: false
        color: "Black"
    }

    Row{
        id: row
        spacing: 4
        signal checked(string value)
        onChecked :  {
            for (var i = 0; i < row.children.length; i++)
            {
                if (row.children[i].on != null)
                {
                    if (value === row.children[i].value)
                    {
                        switchGroup.value = value;
                    }
                else
                    {
                        row.children[i].on = false;
                    }
                }
            }
        }

        Repeater{
            id: listRepeater
            delegate:
                Switch{
                  id: id
                  textOn: text_on
                  textOff: text_off
                  imageOn: image_on
                  imageOff: image_off
                  textOnColor: switchGroup.textOnColor
                  textOffColor: switchGroup.textOffColor
                  textOnFontFamily: fontText.font.family
                  textOffFontFamily: fontText.font.family
                  textOffBold: fontText.font.bold
                  textOnBold: fontText.font.bold
                  textOnFontSize: fontText.font.pixelSize
                  textOffFontSize: fontText.font.pixelSize
                  value: val
                  width: item_width
                  height: item_height
                  on: false
                  onButtonClick:
                      if (id.on)
                          row.checked(value);
                      else
                          switchGroup.value = "";
            }
        }

    }


}


