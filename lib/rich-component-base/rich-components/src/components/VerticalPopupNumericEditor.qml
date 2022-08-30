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
import "../js/keycodes.js" as KeyCodes

Item {
    id: popupEditor

    property int animationSpeed: 200
    property string keyBACKSPACE: "\b"
    property string keyENTER: "\n"
    property alias bgImage: bgImage.source
    property alias label: labelItem
    property alias text: textItem
    property alias font: textItem.font
    property variant rootObject
    property url normalKeyIcon: "../images/key_off.png"
    property url pressedKeyIcon: "../images/key_on.png"
    property int keyWidth: 38
    property int keyHeight: 40
    property real min
    property real max
    property bool checkMaxMin: true
    property color keyTextColor : "#ffffff"
    property bool keyTextBold: false
    property int keyTextFontSize: 14
    property string mask: ""
    property string templateMask: ""
    property alias maskedInput: textItem.maskedInput
    property string validator
    property int totalNumbersAllowed: 0
    property int requiredNumbers: 0
    property string neg: ""
    property int labelWidth: 0
    property int labelHeight: 0
    property string maskChar: "_"

    signal keyPress(string key)

    function show()
    {
        rootObject = popupEditor.parent;
        while (rootObject.parent)
            rootObject = rootObject.parent;

        //hide all child components
        //for(var i=0; i < rootObject.children.length; i++)
        //    rootObject.children[i].visible = false;

        popupEditor.parent = rootObject;
        popupEditor.width = rootObject.width;
        popupEditor.height = rootObject.height;
        popupEditor.x = 0;
        popupEditor.y = 0;
        showAnim.from = rootObject.height;
        showAnim.to = 0;
        showAnim.start();
    }

    function hide()
    {
        hideAnim.start();
        //show all child components
        //for(var i=0; i < rootObject.children.length; i++)
        //    rootObject.children[i].visible = true;
    }

    function removeKey(keyCode)
    {
        //find the child and remove the negative sign button
        for(var k=0; k < keyPad.children.length; k++)
        {
            if (keyPad.children[k].keyCode && keyPad.children[k].keyCode === keyCode)
                keyPad.children[k].visible = false;
        }
    }

    function removeChars(text)
    {
        var tmp = "";

        for (var i = 0; i < text.length; i++)
        {
            if (parseInt(text.charAt(i)) >= 0 || (text.charAt(i) === "-" && neg.indexOf(i.toString()) < 0))
                tmp += text.charAt(i);
        }

        return tmp;
    }

    function buildTestNumber(text)
    {
        var counter = text.length-1;
        var temp = new Array(templateMask.length);

        for (var j = templateMask.length -1; j >= 0; j--)
        {
            if (templateMask.charAt(j) === "_" && counter >= 0)
            {
                temp[j] = text.charAt(counter);
                counter -= 1;
            }
            else
            {
                temp[j] = templateMask.charAt(j);
            }

        }

        text = "";
        for (var k=0; k < temp.length; k++)
        {
            if (temp[k] != "_")
                text += temp[k];
        }

        return text;
    }


    function handleKeyPress(key)
    {
        var error = false;
        txtMessage.text = "";

        if (maskedInput.length > 0 || mask.length > 0)
        {
            handleMaskedInput(key);
            return;
        }

        if (key === KeyCodes.keyBackspace) {
            if (text.text.length)
            {
                text.text = text.text.substring(0, text.text.length-1);
            }
        }
        else if (key === "-")
        {
            if (text.text.length === 0)
                text.text += key;
            else
                error = true;
        }
        else if (key !== KeyCodes.keyEnter)
        {
            text.text += key;
        }
        else if (key === KeyCodes.keyEnter)
        {
            if (text.text === "-")
            {
                txtMessage.text = "Please enter a valid number.";
                error = true;
            }
            else if (parseFloat(text.text) > max)
            {
                txtMessage.text = labelItem.text + " can not be greater than " + max.toString();
                error = true;
            }
            else if (parseFloat(text.text) < min)
            {
                txtMessage.text = labelItem.text + " can not be less than " + min.toString();
                error = true;
            }
        }

        if (!error)
            keyPress(key);
    }

    function handleMaskedInput(key)
    {
        var error = false;

        if (maskedInput.length > 0)
        {
            //we will handle the mask from here on out
            mask = maskedInput.substring(0, maskedInput.indexOf(";"));
            var dt = text.displayText;
            maskedInput = "";

            if (dt.match( /\d/))
            {
                text.text = dt;
                //remove all non numbers from text except - signs entered by user
                text.text = removeChars(text.text);
            }
        }
        else
        {
            //remove all non numbers from text except - signs entered by user
            text.text = removeChars(text.text);
        }

        if (key === KeyCodes.keyBackspace) {
            if (text.text.length)
            {
                text.text = text.text.substring(0, text.text.length-1);
            }
        }
        else if (key === "-")
        {
            if (text.text.indexOf("-") < 0)
                text.text = key + text.text;
            else
                error = true;
        }
        else if (key !== KeyCodes.keyEnter)
        {
            if (text.text.length < totalNumbersAllowed)
            {
                //See if we need to test if it is a number
                if (!checkMaxMin)
                    text.text += key;
                else
                {
                    var test = text.text + key;
                    if (isFinite(test))
                        text.text += key;
                    else
                        error = true;
                }
            }
            else
            {
                error = true;
            }
        }
        else if (key === KeyCodes.keyEnter)
        {
            if (text.text === "-")
            {
                txtMessage.text = "Please enter a valid number.";
                error = true;
            }
            else if (text.text.replace("-", "").length < requiredNumbers && text.text.length >= 0)
            {
                txtMessage.text = labelItem.text + " must be in this format:\n" + mask;
                error = true;
            }
            else if (checkMaxMin && parseFloat(buildTestNumber(text.text)) > max)
            {
                txtMessage.text = labelItem.text + " can not be greater than " + max.toString();
                error = true;
            }
            else if (checkMaxMin && parseFloat(buildTestNumber(text.text)) < min)
            {
                txtMessage.text = labelItem.text + " can not be less than " + min.toString();
                error = true;
            }
        }

        //Build our mask for view purposes
        var counter = text.text.length-1;
        var temp = new Array(templateMask.length);

        for (var j = templateMask.length -1; j >= 0; j--)
        {
            if (templateMask.charAt(j) === maskChar && counter >= 0)
            {
                temp[j] = text.text.charAt(counter);
                counter -= 1;
            }
            else
            {
                temp[j] = templateMask.charAt(j);
            }

        }

        text.text = "";
        for (var k=0; k < temp.length; k++)
            text.text += temp[k];

        if (!error)
            keyPress(key);
    }

    width: content.width
    height: content.height

    MouseArea{
        anchors.fill: parent
    }

   Image {
       id: bgImage
       source: "../images/keyboardbg.png"
       width: parent.width
       height: parent.height
   }

   Column {
       width: parent.width
       Item {
           id: content
           width: parent.width
           height: Math.max(labelItem.font.pixelSize, textItem.font.pixelSize) + 20

           Text {
               id: labelItem
               anchors.left: parent.left
               anchors.leftMargin: 10
               anchors.verticalCenter: parent.verticalCenter
               text: popupEditor.label.text
               font: popupEditor.label.font
               color: popupEditor.label.color
           }

           LineEdit {
               id: textItem
               text: popupEditor.text.text
               font: popupEditor.text.font
               color: popupEditor.text.color
               focus: true
               border.color: "orange"
               cursorVisible: true;
               anchors.left : content.left
               anchors.leftMargin : 10
               anchors.top: labelItem.bottom
               anchors.topMargin: 4
               width: parent.width  - 16
           }


           Text{
               id: txtMessage
               text: ""
               wrapMode: Text.WordWrap
               anchors.top: keyPad.bottom
               anchors.topMargin: 10
               width: parent.width
               font: popupEditor.label.font
               color: "red"
           }

           NumericKeyPad {
               id: keyPad
               anchors.left: textItem.left
               anchors.leftMargin: 0
               anchors.top: textItem.bottom
               anchors.topMargin: 2
               normalKeyIcon: popupEditor.normalKeyIcon
               pressedlKeyIcon: popupEditor.pressedKeyIcon
               keySpacing: 4
               keyWidth: popupEditor.keyWidth
               keyHeight: popupEditor.keyHeight
               keyTextColor: popupEditor.keyTextColor
               keyTextBold: popupEditor.keyTextBold
               keyTextFontSize: popupEditor.keyTextFontSize

               keyDefs: [
                   {keyCap: '1', keyCode: '1'},
                   {keyCap: '2', keyCode: '2'},
                   {keyCap: '3', keyCode: '3'},
                   {keyCap: '4', keyCode: '4'},
                   {keyCap: '5', keyCode: '5'},
                   {keyCap: '6', keyCode: '6'},
                   {keyCap: '7', keyCode: '7'},
                   {keyCap: '8', keyCode: '8'},
                   {keyCap: '9', keyCode: '9'},
                   {keyCap: '0', keyCode: '0'},
                   {keyCap: '-', keyCode: '-'},
                   {keyCap: 'Back', keyCode: KeyCodes.keyBackspace},
                   {keyCap: 'Done', keyCode: KeyCodes.keyEnter}
               ]
           }

        }

   }

   PropertyAnimation {
        id: showAnim

        target: popupEditor
        property: "y"
        duration: animationSpeed
    }

    SequentialAnimation {
        id: hideAnim

        PropertyAnimation {
            target: popupEditor
            property: "y"
            to: popupEditor.parent.height
            duration: animationSpeed
        }
        ScriptAction {
            script: popupEditor.destroy()
        }
    }


    Component.onCompleted: {
        if (maskedInput.length > 0)
        {
            for (var i=0; i < maskedInput.length; i++)
            {
                if (maskedInput.charAt(i) === "#" || maskedInput.charAt(i) === "9")
                {
                    totalNumbersAllowed += 1;
                    if (maskedInput.charAt(i) === "9")
                        requiredNumbers += 1;

                    templateMask += "_";
                }
                else
                {
                    if (maskedInput.charAt(i) == "-")
                        neg += i.toString() + " ";
                    templateMask += maskedInput.charAt(i);
                }
            }

            if (neg.length > 0)
                removeKey("-");
            else if (maskedInput.charAt(0) == "9")
                removeKey("-");

            templateMask = templateMask.substring(0, templateMask.indexOf(";"));
        }


        //Check if we need to check the max and the min
        if (min.toString().length > 0 && max.toString() > 0)
        {
            checkMaxMin = true;
            if (min >=0)
                removeKey("-");
        }
        else
            checkMaxMin = false;
    }


}

