import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Scrolling TextBox")

        SectionLayout {

            Label {
                text: qsTr("Text")
            }

            SecondColumnLayout {
                LineEdit {
                    backendValue: backendValues.initialText
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Max Chars")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.maxChars
                    minimumValue: 0
                    maximumValue: 100000
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
                    backendValue: backendValues.borderWidth
                    minimumValue: 0
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
                backendValue: backendValues.textEditBackGroundColor
                supportGradient: true
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
        caption: qsTr("Header Specifics")

        SectionLayout {

            Label {
                text: qsTr("Header Height")
            }

            SecondColumnLayout {

                SpinBox {
                    backendValue: backendValues.headerHeight
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Header Text")
            }

            SecondColumnLayout {
                LineEdit {
                    backendValue: backendValues.headerText
                }

                ExpandingSpacer {

                }
            }


        }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Header Text Color")

            ColorEditor {
                caption: qsTr("Header Text Color")
                backendValue: backendValues.headerTextColor
                supportGradient: falsescrollBarUpDownArrowHighLight
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Header Dark Color")

            ColorEditor {
                caption: qsTr("Header Dark Color")
                backendValue: backendValues.gradientDarkColor
                supportGradient: false
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Header Light Color")

            ColorEditor {
                caption: qsTr("Header Light Color")
                backendValue: backendValues.gradientLightColor
                supportGradient: false
            }
    }

    FontSection{
        caption: qsTr("Header Font")
        fontFamily: backendValues.headerTextFontFamily
        pixelSize: backendValues.headerTextFontSize
        boldStyle: backendValues.headerTextFontBold
    }

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Text Specifics")

        SectionLayout {

            Label {
                text: qsTr("Margins")
            }

            SecondColumnLayout {

                SpinBox {
                    backendValue: backendValues.textMargins
                    minimumValue: 0
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
            caption: qsTr("Text Color")

            ColorEditor {
                caption: qsTr("Text Color")
                backendValue: backendValues.textEditColor
                supportGradient: false
            }
    }

    FontSection{
        caption: qsTr("Text Font")
        fontFamily: backendValues.textEditFontFamily
        pixelSize: backendValues.textEditFontSize
        boldStyle: backendValues.textEditFontBold
    }

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Scrollbar Specifics")

        SectionLayout {

            Label {
                text: qsTr("Scrollbar Width")
            }

            SecondColumnLayout {

                SpinBox {
                    backendValue: backendValues.scrollBarWidth
                    minimumValue: 0
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Scrollbar Border Width")
            }

            SecondColumnLayout {

                SpinBox {
                    backendValue: backendValues.scrollBarBorderWidth
                    minimumValue: 0
                    maximumValue: 100
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: "Show Scrollbar Up/Down Arrow"
            }

            SecondColumnLayout {

                CheckBox{
                    id: cbshowUpDownArrow
                    backendValue: backendValues.showScrollBarUpDownArrow
                }

                Label {
                    text: "Enable"
                }

                ExpandingSpacer {

                }
            }

        }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Scrollbar Background Color")

            ColorEditor {
                caption: qsTr("Scrollbar Background Color")
                backendValue: backendValues.scrollBarBackGroundColor
                supportGradient: true
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Scrollbar Color")

            ColorEditor {
                caption: qsTr("Scrollbar Color")
                backendValue: backendValues.scrollBarColor
                supportGradient: true
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Scrollbar Highlight Color")

            ColorEditor {
                caption: qsTr("Scrollbar Highlight Color")
                backendValue: backendValues.scrollBarHighLight
                supportGradient: true
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Scrollbar Border Color")

            ColorEditor {
                caption: qsTr("Scrollbar Border Color")
                backendValue: backendValues.scrollBarBackGroundColor
                supportGradient: true
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Scrollbar Up/Down Arrow Color")

            ColorEditor {
                enabled: cbshowUpDownArrow.checked
                caption: qsTr("Scrollbar Up/Down Arrow Color")
                backendValue: backendValues.scrollBarUpDownArrowColor
                supportGradient: true
            }
    }

    Section {
            anchors.left: parent.left
            anchors.right: parent.right
            caption: qsTr("Scrollbar Up/Down Arrow Highlight Color")

            ColorEditor {
                enabled: cbshowUpDownArrow.checked
                caption: qsTr("Scrollbar Up/Down Arrow Highlight Color")
                backendValue: backendValues.scrollBarUpDownArrowHighLight
                supportGradient: true
            }
    }

}
