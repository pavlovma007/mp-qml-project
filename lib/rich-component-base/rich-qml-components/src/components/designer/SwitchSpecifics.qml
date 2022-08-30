import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Image Sources")

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

        }
    }

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Text On")

        SectionLayout {

            Label {
                text: qsTr("Text On")
            }

            SecondColumnLayout {

                LineEdit{
                    backendValue: backendValues.textOn
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Font Family")
            }

            SecondColumnLayout {

                FontComboBox{
                    backendValue: backendValues.textOnFontFamily
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Font Size")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.textOnFontSize
                    minimumValue: 0
                    maximumValue: 50
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Bold")
            }

            SecondColumnLayout {
                CheckBox {
                    backendValue: backendValues.textOnBold
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
                supportGradient: false
            }
    }

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Text Off")

        SectionLayout {

            Label {
                text: qsTr("Text Off")
            }

            SecondColumnLayout {

                LineEdit{
                    backendValue: backendValues.textOff
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Font Family")
            }

            SecondColumnLayout {

                FontComboBox{
                    backendValue: backendValues.textOffFontFamily
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Font Size")
            }

            SecondColumnLayout {
                SpinBox {
                    id: spinTextOffFontSize
                    backendValue: backendValues.textOffFontSize
                    minimumValue: 0
                    maximumValue: 50
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Bold")
            }

            SecondColumnLayout {
                CheckBox {
                    backendValue: backendValues.textOffBold
                }

                ExpandingSpacer {

                }
            }

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

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Switch State")

        SectionLayout {

            Label {
                text: ""
            }

            SecondColumnLayout {
                CheckBox{
                    backendValue: backendValues.on
                }

                Label {
                    text: "On"
                }

                ExpandingSpacer {

                }
            }
        }
    }

}
