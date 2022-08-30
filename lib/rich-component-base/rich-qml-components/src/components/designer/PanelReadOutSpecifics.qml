import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Panel Read")

        SectionLayout {

            Label {
                text: qsTr("Panel Image")
            }

            SecondColumnLayout {
                UrlChooser {
                     Layout.fillWidth: true
                     backendValue: backendValues.imagePanel
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Width")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.width
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Height")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.height
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Text"
            }

            SecondColumnLayout {
                LineEdit {
                    backendValue: backendValues.text
                }

                ExpandingSpacer {

                }
            }

        }

    }

    FontSection{

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
