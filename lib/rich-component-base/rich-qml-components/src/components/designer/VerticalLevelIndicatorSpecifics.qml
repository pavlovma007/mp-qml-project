import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Horizontal Level Indicator")

        SectionLayout {

            Label {
                text: "Start Position"
            }

            SecondColumnLayout {

                ReachComboBox {
                    id: startPositionComboBox
                    backendValue: backendValues.startPosition
                    model: ["bottom", "top"]
                    Layout.fillWidth: true
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
                    minimumValue: 0
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Min Value")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.minValue
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Max Value")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.maxValue
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Value")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.value
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Value Scale")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.valueScale
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 2
                }

                ExpandingSpacer {

                }
            }


            Label {
                text: qsTr("Value Symbol")
            }

            SecondColumnLayout {
                LineEdit{
                    backendValue: backendValues.symbol
                }
                ExpandingSpacer {

                }
            }

        }
    }


    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Image Sources")
         SectionLayout {

             Label {
                 text: qsTr("Base Image")
             }

             SecondColumnLayout {
                 UrlChooser {
                      Layout.fillWidth: true
                      backendValue: backendValues.imageBase
                 }

                 ExpandingSpacer {

                 }
             }

             Label {
                 text: qsTr("Overlay Image")
             }

             SecondColumnLayout {
                 UrlChooser {
                      Layout.fillWidth: true
                      backendValue: backendValues.imageOverlay
                 }

                 ExpandingSpacer {

                 }
             }

         }
    }


    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Hint Options")

        SectionLayout {

            Label {
                text: "Show Hint"
            }

            SecondColumnLayout {
                CheckBox{
                    backendValue: backendValues.showHint
                }
                ExpandingSpacer {
                }

            }

        }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Hint Font Color")

            ColorEditor {
                caption: qsTr("Hint Font Color")
                backendValue: backendValues.hintFontColor
                supportGradient: false
            }

    }

    FontSection{
        caption: qsTr("Hint Font")
        fontFamily: backendValues.hintFontFamily
        pointSize: backendValues.hintFontPointSize
        pixelSize: backendValues.hintFontPixelSize
        boldStyle: backendValues.hintFontBold
        italicStyle: backendValues.hintFontItalic
        underlineStyle: backendValues.hintFontUnderline
        strikeoutStyle: backendValues.hintFontStrikeout
    }


}
