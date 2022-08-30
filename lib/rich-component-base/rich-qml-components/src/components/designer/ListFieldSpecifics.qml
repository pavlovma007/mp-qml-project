import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("List Field - Horizontal")

        SectionLayout {

            Label {
                text: qsTr("Value")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.value
                    decimals: 2
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Label Text")
            }

            SecondColumnLayout {

                LineEdit{
                    backendValue: backendValues.labelText
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

        }

    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Input Color")

            ColorEditor {
                caption: qsTr("Input Color")
                backendValue: backendValues.inputColor
                supportGradient: true
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Label Color")

            ColorEditor {
                caption: qsTr("Label Color")
                backendValue: backendValues.labelColor
                supportGradient: true
            }
    }

    FontSection{
        caption: qsTr("Input Font")
        fontFamily: backendValues.inputFontFamily
        pointSize: backendValues.inputFontPointSize
        pixelSize: backendValues.inputFontPixelSize
        boldStyle: backendValues.inputFontBold
        italicStyle: backendValues.inputFontItalic
        underlineStyle: backendValues.inputFontUnderline
        strikeoutStyle: backendValues.inputFontStrikeout
    }

    FontSection{
        caption: qsTr("Label Font")
        fontFamily: backendValues.labelFontFamily
        pointSize: backendValues.labelFontPointSize
        pixelSize: backendValues.labelFontPixelSize
        boldStyle: backendValues.labelFontBold
        italicStyle: backendValues.labelFontItalic
        underlineStyle: backendValues.labelFontUnderline
        strikeoutStyle: backendValues.labelFontStrikeout
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("List Picker Specifics")

            SectionLayout {

                Label {
                    text: qsTr("Border Width")
                }

                SecondColumnLayout {

                    SpinBox {
                        backendValue: backendValues.borderWidth
                        minimumValue: 0
                        maximumValue: 1000
                        decimals: 0
                    }

                    ExpandingSpacer {

                    }
                }

                Label {
                    text: qsTr("Border Radius")
                }

                SecondColumnLayout {

                    SpinBox {
                        backendValue: backendValues.borderRadius
                        minimumValue: 0
                        maximumValue: 1000
                        decimals: 0
                    }

                    ExpandingSpacer {

                    }
                }

                Label {
                    text: qsTr("Spacing")
                }

                SecondColumnLayout {

                    SpinBox {
                        backendValue: backendValues.spacing
                        minimumValue: 0
                        maximumValue: 1000
                        decimals: 0
                    }

                    ExpandingSpacer {

                    }
                }

                Label {
                    text: qsTr("List Item Height")
                }

                SecondColumnLayout {

                    SpinBox {
                        backendValue: backendValues.listItemHeight
                        minimumValue: 1
                        maximumValue: 1000
                        decimals: 0
                    }

                    ExpandingSpacer {

                    }
                }

                Label {
                    text: qsTr("Background Image")
                }

                SecondColumnLayout {
                    UrlChooser {
                         Layout.fillWidth: true
                         backendValue: backendValues.keyboardBackGroundImage
                    }

                    ExpandingSpacer {

                    }
                }

                Label {
                    text: qsTr("Caption Text")
                }

                SecondColumnLayout {

                    LineEdit{
                        backendValue: backendValues.captionText
                    }

                    ExpandingSpacer {

                    }
                }

            }

        }

    ColorEditor {
        caption: qsTr("Caption Text Color")
        backendValue: backendValues.captionFontColor
        supportGradient: true
    }

    ColorEditor {
        caption: qsTr("List Text Color")
        backendValue: backendValues.listFontColor
        supportGradient: true
    }

    ColorEditor {
        caption: qsTr("Background Color")
        backendValue: backendValues.backgroundColor
        supportGradient: true
    }

    ColorEditor {
        caption: qsTr("Border Color")
        backendValue: backendValues.borderColor
        supportGradient: true
    }

    FontSection{
        caption: qsTr("Caption Text Font")
        fontFamily: backendValues.captionFont_family
        pixelSize: backendValues.captionFont_pixelSize
        boldStyle: backendValues.captionFont_bold
        italicStyle: backendValues.captionFont_italic
        underlineStyle: backendValues.captionFont_underline
        strikeoutStyle: backendValues.captionFont_strikeout
    }

    FontSection {
        caption: qsTr("List Text Font")
        fontFamily: backendValues.listFont_family
        pixelSize: backendValues.listFont_pixelSize
        boldStyle: backendValues.listFont_bold
        italicStyle: backendValues.listFont_italic
        underlineStyle: backendValues.listFont_underline
        strikeoutStyle: backendValues.listFont_strikeout
    }


}
