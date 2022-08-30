import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Line Chart")

        SectionLayout {

            Label {
                text: "Bezier Curve"
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
                text: "Dataset Fill"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.datasetFill
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Dataset Stroke"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.datasetStroke
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }


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
                text: "Show Point Dot"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.pointDot
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Point Dot Radius")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.pointDotRadius
                    minimumValue: 1
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Point Dot Stroke Width")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.pointDotStrokeWidth
                    minimumValue: 1
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Show Legend"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.showLegend
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }

        }
    }

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Scale Information")

        SectionLayout {

            Label {
                text: "Scale Overlay"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.scaleOverlay
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }


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
