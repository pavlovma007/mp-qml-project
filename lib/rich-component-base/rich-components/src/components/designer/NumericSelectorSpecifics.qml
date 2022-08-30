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

            caption: qsTr("Numeric Selector Field")

            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Value")
                        }
                        LineEdit {
                            backendValue: backendValues.value
                            baseStateFlag: isBaseState;
                            translation: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Min")
                        }
                        LineEdit {
                            backendValue: backendValues.min
                            baseStateFlag: isBaseState;
                            translation: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Max")
                        }
                        LineEdit {
                            backendValue: backendValues.max
                            baseStateFlag: isBaseState;
                            translation: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Display Text")
                        }
                        LineEdit {
                            visible: !useLineEdit
                            backendValue: backendValues.displayText
                            baseStateFlag: isBaseState;
                            translation: true
                        }
                    }
                }

                IntEditor {
                    backendValue: backendValues.precision
                    caption: qsTr("Precision")
                    baseStateFlag: isBaseState;
                    step: 1;
                    minimumValue: 0;
                    maximumValue: 10;
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Increment")
                        }

                        DoubleSpinBox {
                            backendValue: backendValues.increment
                            singleStep: 1.00
                            minimum: 0.01
                            maximum: 1000
                            decimals: 2
                            spacing: 4
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Auto Repeat")
                            toolTip: qsTr("Auto Repeat")
                        }

                        CheckBox {
                            id: autoRepeatCheckBox
                            backendValue: backendValues.autoRepeat
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("Enable")
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Interval")
                            toolTip: qsTr("Auto Repeat Interval")
                        }

                        SpinBox {
                            enabled: autoRepeatCheckBox.checked
                            opacity: enabled ? 1.0 : 0.8
                            backendValue: backendValues.autoRepeatInterval
                            singleStep: 10
                            minimum: 0
                            maximum: 10000
                            baseStateFlag: isBaseState
                        }
                    }
                }

            }
        }

        GroupBox {
            caption: qsTr("Image Source Specifics")
            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Background Image Source")
                            toolTip: qsTr("Background Image Source")
                        }
                        UrlEdit {
                            backendValue: backendValues.source
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
                            text: qsTr("Right Button Down Image Source")
                            toolTip: qsTr("Right Button Down Image Source")
                        }
                        UrlEdit {
                            backendValue: backendValues.rightImageDown
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Right Button Up Image Source")
                            toolTip: qsTr("Right Button Up Image Source")
                        }
                        UrlEdit {
                            backendValue: backendValues.rightImageUp
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Left Button Down Image Source")
                            toolTip: qsTr("Left Button Down Image Source")
                        }
                        UrlEdit {
                            backendValue: backendValues.leftImageDown
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Left Button Up Image Source")
                            toolTip: qsTr("Left Button Up Image Source")
                        }
                        UrlEdit {
                            backendValue: backendValues.leftImageUp
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }

            }
        }

        FontGroupBox {
            finished: finishedNotify;

            caption: qsTr("Font")

            fontFamily: backendValues.textFontFamily
            pixelSize: backendValues.textFontPixelSize

            boldStyle: backendValues.textFontBold
            italicStyle: backendValues.textFontItalic
            underlineStyle: backendValues.textFontUnderline
            strikeoutStyle: backendValues.textFontStrikeout
        }


        ColorGroupBox {
            caption: qsTr("Input Color")
            finished: finishedNotify

            backendColor: backendValues.textColor
        }


        QScrollArea {
        }
    }
}
