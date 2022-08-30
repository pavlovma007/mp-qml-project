import QtQuick 1.0
import Bauhaus 1.0
import HelperWidgets 1.0

QWidget {
    id: textSpecifics;

    layout: QVBoxLayout {
        topMargin: 0
        bottomMargin: 0
        leftMargin: 0
        rightMargin: 0
        spacing: 0

        GroupBox {
            id: standardTextGroupBox

            caption: qsTr("Alphabetic Field")

            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Text")
                        }
                        LineEdit {
                            backendValue: backendValues.inputText
                            baseStateFlag: isBaseState;
                            translation: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Label Text")
                        }
                        LineEdit {
                            visible: !useLineEdit
                            backendValue: backendValues.labelText
                            baseStateFlag: isBaseState;
                            translation: true
                        }
                    }
                }

                IntEditor {
                    backendValue: backendValues.fieldSpacing

                    caption: qsTr("Field Spacing")
                    baseStateFlag: isBaseState;

                    step: 1;
                    minimumValue: 0;
                    maximumValue: 100;
                }

            }
        }

        GroupBox {
            caption: qsTr("Keyboard Specifics")
            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Normal Key Source")
                            toolTip: qsTr("Normal Key Source")
                        }
                        UrlEdit {
                            backendValue: backendValues.normalKeyIcon
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                            onBackendValueChanged:{
                                backendValues.width = 200;
                            }
                        }
                    }
                }
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Pressed Key Source")
                            toolTip: qsTr("Pressed Key Source")
                        }
                        UrlEdit {
                            backendValue: backendValues.pressedKeyIcon
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Keyboard Background")
                            toolTip: qsTr("Keyboard Background")
                        }
                        UrlEdit {
                            backendValue: backendValues.keyboardBackGroundImage
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Key Width")
                            toolTip: qsTr("Key Width")
                        }

                        SpinBox {
                            backendValue: backendValues.keyWidth
                            singleStep: 1
                            minimum: 0
                            maximum: 10000
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Key Height")
                            toolTip: qsTr("Key Height")
                        }

                        SpinBox {
                            backendValue: backendValues.keyHeight
                            singleStep: 1
                            minimum: 0
                            maximum: 10000
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        ColorGroupBox {
                            caption: qsTr("Key Text Color")
                            finished: finishedNotify
                            backendColor: backendValues.keyTextColor
                        }
                    }
                }
            }
        }

        FontGroupBox {
            finished: finishedNotify;

            caption: qsTr("Input Font")

            fontFamily: backendValues.inputFontFamily
            pointSize: backendValues.inputFontPointSize
            pixelSize: backendValues.inputFontPixelSize

            boldStyle: backendValues.inputFontBold
            italicStyle: backendValues.inputFontItalic
            underlineStyle: backendValues.inputFontUnderline
            strikeoutStyle: backendValues.inputFontStrikeout
        }


        FontGroupBox {
            finished: finishedNotify;

            caption: qsTr("Label Font")

            fontFamily: backendValues.labelFontFamily
            pointSize: backendValues.labelFontPointSize
            pixelSize: backendValues.labelFontPixelSize

            boldStyle: backendValues.labelFontBold
            italicStyle: backendValues.labelFontItalic
            underlineStyle: backendValues.labelFontUnderline
            strikeoutStyle: backendValues.labelFontStrikeout
        }

        GroupBox {
            caption: qsTr("Color")

            layout: VerticalLayout {

                ColorGroupBox {
                    caption: qsTr("Input Color")
                    finished: finishedNotify

                    backendColor: backendValues.inputColor
                }

                ColorGroupBox {
                    caption: qsTr("Label Color")
                    finished: finishedNotify

                    backendColor: backendValues.labelColor
                }

            }
        }

        QScrollArea {
        }
    }
}
