import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Knob")

        SectionLayout {

            Label {
                text: "Add Items"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.add
                }

                Label {
                    text: "Enable"
                    width: 200
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Remove Items"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.remove
                }

                Label {
                    text: "Enable"
                    width: 200
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Show Hint"
            }

            SecondColumnLayout {

                CheckBox{
                    id: cbAutoRepeat
                    backendValue: backendValues.showHint
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Initial Index"
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.initialIndex
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Mouse Area Height"
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.mouseAreaHeight
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Mouse Area Width"
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.mouseAreaWidth
                    minimumValue: 0
                    maximumValue: 1000
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
        caption: qsTr("Image Sources")

        SectionLayout {

            Label {
                text: qsTr("Dial")
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
                text: qsTr("Dial Size")
            }

            SecondColumnLayout {
                Label {
                    text: "W"
                    width: 12
                }

                SpinBox {
                    backendValue: backendValues.imageBaseWidth
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                Label {
                    text: "H"
                    width: 12
                }

                SpinBox {
                    backendValue: backendValues.imageBaseHeight
                    minimumValue: -2000
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Needle")
            }

            SecondColumnLayout {
                UrlChooser {
                     Layout.fillWidth: true
                     backendValue: backendValues.imageNeedle
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Needle Size")
            }

            SecondColumnLayout {
                Label {
                    text: "W"
                    width: 12
                }

                SpinBox {
                    backendValue: backendValues.imageNeedleWidth
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                Label {
                    text: "H"
                    width: 12
                }

                SpinBox {
                    backendValue: backendValues.imageNeedleHeight
                    minimumValue: -2000
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
            caption: qsTr("Text Color")

            ColorEditor {
                caption: qsTr("Text Color")
                backendValue: backendValues.textColor
                supportGradient: true
            }
    }


    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Hint Options")

        SectionLayout {
            Label {
                text: "Hint Height"
            }

            SecondColumnLayout {
                SpinBox {
                    enabled: cbAutoRepeat.checked
                    backendValue: backendValues.hintHeight
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Hint Width"
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.hintWidth
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Border Radius"
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.hintRadius
                    minimumValue: 0
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Border Width"
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.hintBorderWidth
                    minimumValue: 0
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

        }
    }

    FontSection{
        caption: "Font"
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Hint Background Color")

            ColorEditor {
                caption: qsTr("Hint Background Color")
                backendValue: backendValues.hintBackgroundColor
                supportGradient: false
            }
    }

    FontSection{
        caption: "Hint Font"
        fontFamily: backendValues.hintFontFamily
        pointSize: backendValues.hintFontPointSize
        pixelSize: backendValues.hintFontPixelSize
        boldStyle: backendValues.hintFontBold
        italicStyle: backendValues.hintFontItalic
        underlineStyle: backendValues.hintFontUnderline
        strikeoutStyle: backendValues.hintFontStrikeout
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

}
