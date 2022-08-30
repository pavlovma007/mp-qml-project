import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Draw Area")

        SectionLayout {

            Label {
                text: "Border Width"
            }

            SecondColumnLayout {

                SpinBox {
                    backendValue: backendValues.borderWidth
                    minimumValue: 1
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Pen Width")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.penWidth
                    minimumValue: 1
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
            caption: qsTr("Background Color")

            ColorEditor {
                caption: qsTr("Background Color")
                backendValue: backendValues.color
                supportGradient: false
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Border Color")

            ColorEditor {
                caption: qsTr("Border Color")
                backendValue: backendValues.borderColor
                supportGradient: false
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Pen Color")

            ColorEditor {
                caption: qsTr("Pen Color")
                backendValue: backendValues.penColor
                supportGradient: false
            }
    }

}
