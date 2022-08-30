import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Time Field - Vertical")

        SectionLayout {

            Label {
                text: qsTr("Hour")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.hours
                    minimumValue: 1
                    maximumValue: 24
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Minute")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.minutes
                    minimumValue: 0
                    maximumValue: 59
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Show Seconds"
            }

            SecondColumnLayout {

                CheckBox{
                    id: cbShowSeconds
                    backendValue: backendValues.showSeconds
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Second")
            }

            SecondColumnLayout {
                SpinBox {
                    enabled: cbShowSeconds.checked
                    backendValue: backendValues.seconds
                    minimumValue: 0
                    maximumValue: 59
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Show Period"
            }

            SecondColumnLayout {

                CheckBox{
                    id: cbShowPeriod
                    backendValue: backendValues.showPeriod
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Period"
            }

            SecondColumnLayout {

                FontComboBox {
                    enabled: cbShowPeriod.checked
                    backendValue: backendValues.period
                    model: ["AM", "PM"]
                    Layout.fillWidth: true
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
        caption: qsTr("Time Picker Specifics")

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
                    backendValue: backendValues.caption
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
        caption: qsTr("Time Text Color")
        backendValue: backendValues.timeFontColor
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
        caption: qsTr("Time Text Font")
        fontFamily: backendValues.timeFont_family
        pixelSize: backendValues.timeFont_pixelSize
        boldStyle: backendValues.timeFont_bold
        italicStyle: backendValues.timeFont_italic
        underlineStyle: backendValues.timeFont_underline
        strikeoutStyle: backendValues.timeFont_strikeout
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
