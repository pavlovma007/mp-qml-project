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
            caption: qsTr("LED Light")
            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Image On")
                            toolTip: qsTr("Image Source for On State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageOn
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
                            text: qsTr("Image Off")
                            toolTip: qsTr("Image Source for off State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageOff
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
                            toolTip: qsTr("Width")
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
                            toolTip: qsTr("Height")
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

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("On")
                            toolTip: qsTr("Changes the image")
                        }
                        CheckBox {
                            backendValue: backendValues.on
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("")
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Field Spacing")
                            toolTip: qsTr("Field Spacing")
                        }

                        SpinBox {
                            backendValue: backendValues.fieldSpacing
                            singleStep: 1
                            minimum: 0
                            maximum: 20
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Label")
                        }
                        LineEdit {
                            backendValue: backendValues.label
                            baseStateFlag: isBaseState;
                            translation: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Text Position")
                            toolTip: qsTr("Text Position")
                        }

                        ComboBox {
                            id: textPositionComboBox
                            backendValue: backendValues.textPosition
                            currentText: backendValues.textPosition.value
                            baseStateFlag: isBaseState
                            items: ["top", "bottom", "left", "right"]
                            onItemsChanged: {
                                currentText =  backendValues.textPosition.value;
                            }
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


            }
        }


        FontGroupBox {
            //finished: finishedNotify;
        }

        QScrollArea {
        }

    }
}
