import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Vertical Slider")

        SectionLayout {

            Label {
                text: ""
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.allowDrag
                }

                Label {
                    text: "Allow Handle Drag"
                    width: 200
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: ""
            }

            SecondColumnLayout {

                CheckBox{
                    id: showHint
                    backendValue: backendValues.showHint
                }

                Label {
                    text: "Show Hint"
                    width: 200
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Handle X")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.handleX
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Handle Y min")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.yMin
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Handle Y max"
            }

            SecondColumnLayout {
                SpinBox {
                    enabled: cbAutoRepeat.checked
                    backendValue: backendValues.yMax
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Min Value"
            }

            SecondColumnLayout {
                SpinBox {
                    enabled: cbAutoRepeat.checked
                    backendValue: backendValues.minimum
                    minimumValue: -100000
                    maximumValue: 100000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Max Value"
            }

            SecondColumnLayout {
                SpinBox {
                    enabled: cbAutoRepeat.checked
                    backendValue: backendValues.maximum
                    minimumValue: 0
                    maximumValue: 100000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Value"
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.value
                    minimumValue: -100000
                    maximumValue: 100000
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
                text: qsTr("Track Image")
            }

            SecondColumnLayout {
                UrlChooser {
                     Layout.fillWidth: true
                     backendValue: backendValues.imageTrack
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Handle Image")
            }

            SecondColumnLayout {
                UrlChooser {
                     Layout.fillWidth: true
                     backendValue: backendValues.imageHandle
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

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Hint Background Color")

            ColorEditor {
                caption: qsTr("Hint Font Color")
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
