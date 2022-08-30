import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Date Field - Horizontal")

        SectionLayout {

            Label {
                text: qsTr("Month")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.month
                    minimumValue: 1
                    maximumValue: 12
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Day")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.day
                    minimumValue: 1
                    maximumValue: 31
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Min Year")
            }

            SecondColumnLayout {
                SpinBox {
                    id: minYear
                    backendValue: backendValues.minYear
                    minimumValue: 0
                    maximumValue: 10000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Max Year")
            }

            SecondColumnLayout {
                SpinBox {
                    id: maxYear
                    backendValue: backendValues.maxYear
                    minimumValue: 0
                    maximumValue: 10000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Year")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.year
                    minimumValue: 0
                    maximumValue: 10000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Date Mask")
            }

            SecondColumnLayout {

                LineEdit{
                    backendValue: backendValues.dateMask
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
        caption: qsTr("Date Picker Specifics")

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
        caption: qsTr("Date Text Color")
        backendValue: backendValues.dateFontColor
        supportGradient: true
    }

    ColorEditor {
        caption: qsTr("Button Text Color")
        backendValue: backendValues.buttonFontColor
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

    ColorEditor {
        caption: qsTr("Button Background Color")
        backendValue: backendValues.buttonBackgroundColor
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
        caption: qsTr("Date Text Font")
        fontFamily: backendValues.dateFont_family
        pixelSize: backendValues.dateFont_pixelSize
        boldStyle: backendValues.dateFont_bold
        italicStyle: backendValues.dateFont_italic
        underlineStyle: backendValues.dateFont_underline
        strikeoutStyle: backendValues.dateFont_strikeout
    }

    FontSection {
        caption: qsTr("Button Text Font")
        fontFamily: backendValues.buttonFont_family
        pixelSize: backendValues.buttonFont_pixelSize
        boldStyle: backendValues.buttonFont_bold
        italicStyle: backendValues.buttonFont_italic
        underlineStyle: backendValues.buttonFont_underline
        strikeoutStyle: backendValues.buttonFont_strikeout
    }

}
