import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Bar Chart")

        SectionLayout {

            Label {
                text: "Show Bar Stroke"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.barShowStroke
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Bar Stroke Width")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.barStrokeWidth
                    minimumValue: 1
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Bar Value Spacing")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.barValueSpacing
                    minimumValue: 0
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Bar Dataset Spacing")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.barDatasetSpacing
                    minimumValue: 0
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
