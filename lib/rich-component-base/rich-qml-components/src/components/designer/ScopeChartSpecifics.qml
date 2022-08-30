import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Scatter Chart")

        SectionLayout {

            Label {
                text: qsTr("Dataset Stroke Width")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.datasetStrokeWidth
                    minimumValue: 1
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Smooth Curve"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.bezierCurve
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Max Value")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.maxYValue
                    minimumValue: -1000
                    maximumValue: 1000
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
                    backendValue: backendValues.minYValue
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Max Time")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.maxTime
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Min Time")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.minTime
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("X Pixels")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.xPixels
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Background Image")
            }

            SecondColumnLayout {
                UrlChooser {
                     Layout.fillWidth: true
                     backendValue: backendValues.bgImage
                }

                ExpandingSpacer {

                }
            }

        }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Background Color")

            ColorEditor {
                caption: qsTr("Background Color")
                backendValue: backendValues.bgColor
                supportGradient: false
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Line 1 Pen Color")

            ColorEditor {
                caption: qsTr("Line 1 Pen Color")
                backendValue: backendValues.line1PenColor
                supportGradient: false
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Line 2 Pen Color")

            ColorEditor {
                caption: qsTr("Line 2 Pen Color")
                backendValue: backendValues.line2PenColor
                supportGradient: false
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Line 3 Pen Color")

            ColorEditor {
                caption: qsTr("Line 3 Pen Color")
                backendValue: backendValues.line3PenColor
                supportGradient: false
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Line 4 Pen Color")

            ColorEditor {
                caption: qsTr("Line 4 Pen Color")
                backendValue: backendValues.line4PenColor
                supportGradient: false
            }
    }

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Scale Information")

        SectionLayout {

            Label {
                text: qsTr("Scale Line Width")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.scaleLineWidth
                    minimumValue: 1
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Show Scale Labels"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.scaleShowLabels
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Show Grid Lines"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.scaleShowGridLines
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }


            Label {
                text: qsTr("Grid Line Width")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.scaleGridLineWidth
                    minimumValue: 1
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Font Family")
            }

            SecondColumnLayout {

                FontComboBox{
                    backendValue: backendValues.scaleFontFamily
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Font Size")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.scaleFontSize
                    minimumValue: 0
                    maximumValue: 50
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
            caption: qsTr("Scale Line Color")

            ColorEditor {
                caption: qsTr("Scale Line Color")
                backendValue: backendValues.scaleLineColor
                supportGradient: false
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Grid Line Color")

            ColorEditor {
                caption: qsTr("Grid Line Color")
                backendValue: backendValues.scaleGridLineColor
                supportGradient: false
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Scale Font Color")

            ColorEditor {
                caption: qsTr("Scale Font Color")
                backendValue: backendValues.scaleFontColor
                supportGradient: false
            }
    }

}
