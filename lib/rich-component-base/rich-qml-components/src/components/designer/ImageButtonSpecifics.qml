import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Image Button")

        SectionLayout {

            Label {
                text: qsTr("Text")
            }

            SecondColumnLayout {

                LineEdit{
                    backendValue: backendValues.text
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Text X Center Offset")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.textXCenterOffSet
                    minimumValue: -2000
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Text Y Center Offset")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.textYCenterOffSet
                    minimumValue: -2000
                    maximumValue: 2000
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
                    backendValue: backendValues.disabled
                }

                Label {
                    text: "Disable Button"
                    width: 200
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
        caption: qsTr("Image Sources")

        SectionLayout {

            Label {
                text: qsTr("Pressed")
            }

            SecondColumnLayout {
                UrlChooser {
                     Layout.fillWidth: true
                     backendValue: backendValues.imageDown
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Up")
            }

            SecondColumnLayout {
                UrlChooser {
                     Layout.fillWidth: true
                     backendValue: backendValues.imageUp
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Source size")
            }

            SecondColumnLayout {
                Label {
                    text: "W"
                    width: 12
                }

                SpinBox {
                    backendValue: backendValues.width
                    minimumValue: -2000
                    maximumValue: 2000
                    decimals: 0
                }

                Label {
                    text: "H"
                    width: 12
                }

                SpinBox {
                    backendValue: backendValues.height
                    minimumValue: -2000
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            FontSection{}
        }

    }
}
