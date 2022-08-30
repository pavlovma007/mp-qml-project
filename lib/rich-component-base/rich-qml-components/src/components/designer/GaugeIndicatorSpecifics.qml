import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Gauge Indicator")

        SectionLayout {

            Label {
                text: qsTr("Min")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.min
                    minimumValue: -2000
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Max")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.max
                    minimumValue: -2000
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Initial Value")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.initialValue
                    minimumValue: -2000
                    maximumValue: 2000
                    decimals: 1
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Tick Size"
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.tickSize
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Tick Interval"
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.tickInterval
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Text Radius"
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.textRadius
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Needle Length"
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.needleLength
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

        }
    }

    FontSection{
        caption: qsTr("Text Font")
        fontFamily: backendValues.textFontFamily
        pixelSize: backendValues.textFontPixelSize
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Needle Color")

            ColorEditor {
                caption: qsTr("Needle Color")
                backendValue: backendValues.needleColor
                supportGradient: true
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Text Color")

            ColorEditor {
                caption: qsTr("Text Color")
                backendValue: backendValues.textFontColor
                supportGradient: true
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Background Color")

            ColorEditor {
                caption: qsTr("Background Color")
                backendValue: backendValues.backGroundColor
                supportGradient: true
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Outer Circle Color")

            ColorEditor {
                caption: qsTr("Outer Circle Color")
                backendValue: backendValues.outerCircleColor
                supportGradient: true
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
                text: qsTr("Center Image")
            }

            SecondColumnLayout {
                UrlChooser {
                     Layout.fillWidth: true
                     backendValue: backendValues.imageCenter
                }

                ExpandingSpacer {

                }
            }

        }

    }
}
