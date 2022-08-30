import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("AnimatedSwitch")

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
                text: qsTr("Text On X")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.textOnX
                    minimumValue: -2000
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Text Off X")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.textOffX
                    minimumValue: -2000
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

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

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Image Information")

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
                text: qsTr("Slider Image")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.sliderImage
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Slider On X")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.sliderImageOnX
                    minimumValue: -2000
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Slider Off X")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.sliderImageOffX
                    minimumValue: -2000
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Slider Y")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.sliderImageY
                    minimumValue: -2000
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

        }
    }


    FontSection{
        caption: "Font"
    }


}
