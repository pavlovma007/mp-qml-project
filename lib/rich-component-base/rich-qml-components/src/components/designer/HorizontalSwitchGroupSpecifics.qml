import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Horizontal Switch Group")

        SectionLayout {

            Label {
                text: qsTr("Initial Value")
            }

            SecondColumnLayout {
                LineEdit {
                    backendValue: backendValues.initialValue
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Button Spacing")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.spacing
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
            caption: qsTr("Text On Color")

            ColorEditor {
                caption: qsTr("Text On Color")
                backendValue: backendValues.textOnColor
                supportGradient: true
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Text Off Color")

            ColorEditor {
                caption: qsTr("Text Off Color")
                backendValue: backendValues.textOffColor
                supportGradient: true
            }
    }

    FontSection{}

}
