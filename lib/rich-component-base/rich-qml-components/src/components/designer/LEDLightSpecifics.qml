import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("LED Light")

        SectionLayout {

            Label {
                text: qsTr("Image On")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.imageOn
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Image Off")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.imageOff
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "On"
            }

            SecondColumnLayout {

                CheckBox{
                    backendValue: backendValues.on
                }
                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Field Spacing")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.fieldSpacing
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Label")
            }

            SecondColumnLayout {
                LineEdit {
                    backendValue: backendValues.label
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Label Position")
            }

            SecondColumnLayout {
                ReachComboBox {
                     backendValue: backendValues.textPosition
                     editable: false
                     model: ["top", "bottom", "left", "right"]
                 }

                ExpandingSpacer {

                }
            }


            FontSection{

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

}
