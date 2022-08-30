import HelperWidgets 1.0
import QtQuick 1.0
import Bauhaus 1.0


QWidget {
    layout: QVBoxLayout {
        topMargin: 0
        bottomMargin: 0
        leftMargin: 0
        rightMargin: 0
        spacing: 0

        GroupBox {
            caption: "Image Button"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: "Text"
                            toolTip: qsTr("Text")
                        }
                        LineEdit {
                            backendValue: backendValues.text
                            baseStateFlag: isBaseState
                            translation: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox{
                            caption: "Text Color"
                            backendColor: backendValues.textColor
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        IntEditor {
                            backendValue: backendValues.textXCenterOffSet
                            caption: qsTr("Text X Center Offset")
                            baseStateFlag: isBaseState;
                            step: 1;
                            minimumValue: -100;
                            maximumValue: 100;
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        IntEditor {
                            backendValue: backendValues.textYCenterOffSet
                            caption: qsTr("Text Y Center Offset")
                            baseStateFlag: isBaseState;
                            step: 1;
                            minimumValue: -100;
                            maximumValue: 100;
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: ""
                        }
                        CheckBox {
                            text: qsTr("Disable Button")
                            backendValue: backendValues.disabled
                            baseStateFlag: isBaseState
                            checkable: true
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
            caption: qsTr("Image Sources")
            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Pressed")
                            toolTip: qsTr("Image Source for Pressed State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageDown
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
                            text: qsTr("Up")
                            toolTip: qsTr("Image Source for Up State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageUp
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Width")
                            toolTip: qsTr("Button Width")
                        }

                        SpinBox {
                            backendValue: backendValues.width
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
                            text: qsTr("Height")
                            toolTip: qsTr("Button Height")
                        }

                        SpinBox {
                            backendValue: backendValues.height
                            singleStep: 1
                            minimum: 0
                            maximum: 10000
                            baseStateFlag: isBaseState
                        }
                    }
                }


            }
        }
        
        FontGroupBox {
            //finished: finishedNotify;
        }

        QScrollArea {
        }

    }
}
