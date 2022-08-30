import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right


    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Numeric Selector Field")

        SectionLayout {

            Label {
                text: qsTr("Value")
            }

            SecondColumnLayout {

                LineEdit{
                    backendValue: backendValues.value
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Min")
            }

            SecondColumnLayout {

                LineEdit{
                    backendValue: backendValues.min
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Max")
            }

            SecondColumnLayout {

                LineEdit{
                    backendValue: backendValues.max
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Display Text")
            }

            SecondColumnLayout {

                LineEdit{
                    backendValue: backendValues.displayText
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Precison")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.precision
                    minimumValue: 0
                    maximumValue: 10
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Increment")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.increment
                    minimumValue: 0.01
                    maximumValue: 10000
                    decimals: 2
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Auto Repeat"
            }

            SecondColumnLayout {

                CheckBox{
                    id: cbAutoRepeat
                    backendValue: backendValues.autoRepeat
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Auto Repeat Interval"
            }

            SecondColumnLayout {
                SpinBox {
                    enabled: cbAutoRepeat.checked
                    backendValue: backendValues.autoRepeatInterval
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

        }

    }

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Image Source Specifics")

        SectionLayout {
            Label {
                text: qsTr("Background Image Source")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.source
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Right Button Down")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.rightImageDown
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Right Button Up")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.rightImageUp
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Left Button Down")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.leftImageDown
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Left Button Up")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.leftImageUp
                }

                ExpandingSpacer {

                }
            }

        }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Text Color")

            ColorEditor {
                caption: qsTr("Text Color")
                backendValue: backendValues.textColor
                supportGradient: false
            }
    }

    FontSection{
        caption: "Font"
        fontFamily: backendValues.textFontFamily
        pixelSize: backendValues.textFontPixelSize
        boldStyle: backendValues.textFontBold
        italicStyle: backendValues.textFontItalic
        underlineStyle: backendValues.textFontUnderline
        strikeoutStyle: backendValues.textFontStrikeout
    }

}

