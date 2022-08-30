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
    id: checkList
    property alias model: listRepeater.model
    property alias values: valueModel
    property url imageChecked: "images/checkbox_click.bmp"
    property url imageUnChecked: "images/checkbox.bmp"
    property int imageHeight: 32
    property int imageWidth: 32
    property alias font: fontText.font
    property alias textColor: fontText.color
    property int spacing: 4
    property alias itemSpacing: col.spacing
    width: col.width
    height: col.height

    signal valuesChanged

    Text {
        id: fontText
        font.family: "DejaVu Sans"
        font.pixelSize: 16
        font.bold: false
        color: "White"
    }

    Column{
        id: col
        spacing: 10
        signal checked(string value)

        Repeater{
            id: listRepeater
            delegate:
                CheckButton{
                  id: id
                  text: item_text
                  value: item_value
                  imageChecked: checkList.imageChecked
                  imageUnchecked: checkList.imageUnChecked
                  font.family: fontText.font.family
                  font.pixelSize: fontText.font.pixelSize
                  font.bold: fontText.font.bold
                  textColor: fontText.color
                  checked: item_checked
                  imageHeight: checkList.imageHeight
                  imageWidth: checkList.imageWidth
                  spacing: checkList.spacing

                  onClicked:{
                      if (id.checked)
                      {
                          checkList.values.append({value: value});
                      }
                      else{
                          for(var i=0; i < checkList.values.count; i++)
                          {
                              if (checkList.values.get(i).value == value)
                                  break;
                          }
                          checkList.values.remove(i);
                      }

                      valuesChanged();
                  }

                  Component.onCompleted: {
                      if (id.checked)
                      {
                          checkList.values.append({value: value});
                      }

                  }

            }
        }

    }

    ListModel{
        id: data
        ListElement{item_value: "1"; item_text: "check 1"; item_checked: true;}
        ListElement{item_value: "2"; item_text: "check 2"; item_checked: false;}
    }

    ListModel{
        id: valueModel
    }


    Component.onCompleted: {

    }
}
