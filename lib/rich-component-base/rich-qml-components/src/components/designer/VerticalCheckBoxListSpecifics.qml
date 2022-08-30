import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("CheckBoxList - Horizontal")

        SectionLayout {

            Label {
                text: "Initial Values\n(Ex. 1,2,3)"
            }

            SecondColumnLayout {

                LineEdit {
                    backendValue: backendValues.initialValues
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Field Spacing"
            }

            SecondColumnLayout {

                SpinBox {
                    backendValue: backendValues.spacing
                    minimumValue: 1
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Item Spacing")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.itemSpacing
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
            caption: qsTr("Image Sources")
         SectionLayout {

             Label {
                 text: qsTr("Checked")
             }

             SecondColumnLayout {
                 UrlChooser {
                      Layout.fillWidth: true
                      backendValue: backendValues.imageChecked
                 }

                 ExpandingSpacer {

                 }
             }

             Label {
                 text: qsTr("UnChecked")
             }

             SecondColumnLayout {
                 UrlChooser {
                      Layout.fillWidth: true
                      backendValue: backendValues.imageUnChecked
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
                     backendValue: backendValues.imageWidth
                     minimumValue: 0
                     maximumValue: 1000
                     decimals: 0
                 }

                 Label {
                     text: "H"
                     width: 12
                 }

                 SpinBox {
                     backendValue: backendValues.imageHeight
                     minimumValue: 0
                     maximumValue: 1000
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
                supportGradient: false
            }

    }

    FontSection{}


}
