import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Doughnut Chart")

        SectionLayout {

            Label {
                text: "Show Segment Stroke"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.segmentShowStroke
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Segment Stroke Width")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.segmentStrokeWidth
                    minimumValue: 1
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Percentage Inner Cutout")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.percentageInnerCutout
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
            caption: qsTr("Segment Stroke Color")

            ColorEditor {
                caption: qsTr("Segment Stroke Color")
                backendValue: backendValues.segmentStrokeColor
                supportGradient: false
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Inner Cutout Color")

            ColorEditor {
                caption: qsTr("Inner Cutout Color")
                backendValue: backendValues.innerCutoutColor
                supportGradient: false
            }
    }

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Legend Information")

        SectionLayout {

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

            Label {
                text: qsTr("Legend Font Family")
            }

            SecondColumnLayout {

                FontComboBox{
                    backendValue: backendValues.legendFontFamily
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Legend Font Size")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.legendFontSize
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
            caption: qsTr("Legend Font Color")

            ColorEditor {
                caption: qsTr("Legend Font Color")
                backendValue: backendValues.legendFontColor
                supportGradient: false
            }
    }

}
