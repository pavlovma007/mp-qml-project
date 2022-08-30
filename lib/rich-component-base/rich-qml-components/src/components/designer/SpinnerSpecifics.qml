import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Spinner")

        SectionLayout {

            Label {
                text: qsTr("Item Height")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.itemHeight
                    minimumValue: 0
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Initial Value")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.initialValue
                    minimumValue: -1000000
                    maximumValue: 1000000
                    decimals: 2
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
                text: qsTr("Background")
            }

            SecondColumnLayout {
                UrlChooser {
                     Layout.fillWidth: true
                     backendValue: backendValues.backGroundImage
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Highlight")
            }

            SecondColumnLayout {
                UrlChooser {
                     Layout.fillWidth: true
                     backendValue: backendValues.highlightImage
                }

                ExpandingSpacer {

                }
            }
        }

    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Color")

            ColorEditor {
                caption: qsTr("Color")
                backendValue: backendValues.color
                supportGradient: true
            }
    }

    Section{
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Border")

        SectionLayout {
            Label {
                text: qsTr("Border Radius")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.radius
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Border Width")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.border_width
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
            caption: qsTr("Border Color")

            ColorEditor {
                caption: qsTr("Border Color")
                backendValue: backendValues.border_color
                supportGradient: true
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

    FontSection{
        fontFamily: backendValues.font_family
        pointSize: backendValues.font_pointSize
        pixelSize: backendValues.font_pixelSize
        boldStyle: backendValues.font_bold
        italicStyle: backendValues.font_italic
        underlineStyle: backendValues.font_underline
        strikeoutStyle: backendValues.font_strikeout
    }

}
