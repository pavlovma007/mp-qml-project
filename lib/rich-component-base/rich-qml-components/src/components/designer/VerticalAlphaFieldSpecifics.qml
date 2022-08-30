import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right


    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Alphabetic Field")

        SectionLayout {

            Label {
                text: qsTr("Text")
            }

            SecondColumnLayout {

                LineEdit{
                    backendValue: backendValues.inputText
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Label Text")
            }

            SecondColumnLayout {

                LineEdit{
                    backendValue: backendValues.labelText
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Field Spacing")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.fieldSpacing
                    minimumValue: 0
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: ""
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.passwordMode
                }

                Label {
                    text: "Password Mode"
                    width: 200
                }

                ExpandingSpacer {

                }
            }


        }

    }

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Keyboard Specifics")

        SectionLayout {
            Label {
                text: qsTr("Normal Key Source")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.normalKeyIcon
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Pressed Key Source")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.pressedKeyIcon
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Keyboard Background")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.keyboardBackGroundImage
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Key Width")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.keyWidth
                    minimumValue: 0
                    maximumValue: 10000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Key Height")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.keyHeight
                    minimumValue: 0
                    maximumValue: 10000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Key Text Size")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.keyTextFontSize
                    minimumValue: 1
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Key Text Bold")
            }

            SecondColumnLayout {
                CheckBox{
                    backendValue: backendValues.keyTextBold
                }

                ExpandingSpacer {

                }
            }


        }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Key Text Color")

            ColorEditor {
                caption: qsTr("Key Text Color")
                backendValue: backendValues.keyTextColor
                supportGradient: false
            }
    }

    FontSection{
        caption: "Input Font"
        fontFamily: backendValues.inputFontFamily
        pixelSize: backendValues.inputFontPixelSize
        boldStyle: backendValues.inputFontBold
        italicStyle: backendValues.inputFontItalic
        underlineStyle: backendValues.inputFontUnderline
        strikeoutStyle: backendValues.inputFontStrikeout
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Input Color")

            ColorEditor {
                caption: qsTr("Input Color")
                backendValue: backendValues.inputColor
                supportGradient: false
            }
    }


    FontSection{
        caption: "Label Font"
        fontFamily: backendValues.labelFontFamily
        pixelSize: backendValues.labelFontPixelSize
        boldStyle: backendValues.labelFontBold
        italicStyle: backendValues.labelFontItalic
        underlineStyle: backendValues.labelFontUnderline
        strikeoutStyle: backendValues.labelFontStrikeout
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Label Text Color")

            ColorEditor {
                caption: qsTr("Label Text Color")
                backendValue: backendValues.labelColor
                supportGradient: false
            }
    }

}

