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
            caption: "Vertical Level Indicator"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Start Position")
                            toolTip: qsTr("Start position of overlay image")
                        }

                        ComboBox {
                            id: startPositionComboBox
                            backendValue: backendValues.startPosition
                            currentText: backendValues.startPosition.value
                            baseStateFlag: isBaseState
                            items: ["top", "bottom"]
                            onItemsChanged: {
                                currentText =  backendValues.startPosition.value;
                            }
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Increment")
                            toolTip: qsTr("Increment")
                        }

                        SpinBox {
                            backendValue: backendValues.increment
                            singleStep: 1
                            minimum: 0
                            maximum: 100
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Min Value")
                            toolTip: qsTr("Min Value")
                        }

                        SpinBox {
                            backendValue: backendValues.minValue
                            singleStep: 1
                            minimum: -1000
                            maximum: 1000
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Max Value")
                            toolTip: qsTr("Max Value")
                        }

                        SpinBox {
                            backendValue: backendValues.maxValue
                            singleStep: 1
                            minimum: 0
                            maximum: 1000
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Value")
                            toolTip: qsTr("Start Value")
                        }

                        SpinBox {
                            backendValue: backendValues.value
                            singleStep: 1
                            minimum: -1000
                            maximum: 1000
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Value Scale")
                            toolTip: qsTr("Value Scale")
                        }

                        DoubleSpinBox {
                            backendValue: backendValues.valueScale
                            singleStep: 1
                            minimum: -1000
                            maximum: 1000
                            decimals: 2
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Value Symbol")
                            toolTip: qsTr("Value Symbol")
                        }

                        LineEdit{
                            visible: !useLineEdit
                            backendValue: backendValues.symbol
                            baseStateFlag: isBaseState;
                            translation: true
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
                            text: qsTr("Base Image")
                            toolTip: qsTr("Image Source for Base Image")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageBase
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Overlay Image")
                            toolTip: qsTr("Image Source for Overlay Image")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageOverlay
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.svg"
                            showComboBox: true
                        }
                    }
                }
            }
        }

        GroupBox {
            caption: qsTr("Hint Options")
            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: ""
                        }
                        CheckBox {
                            text: qsTr("Show Hint")
                            backendValue: backendValues.showHint
                            baseStateFlag: isBaseState
                            checkable: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Hint Height")
                            toolTip: qsTr("Hint Height")
                        }

                        SpinBox {
                            backendValue: backendValues.hintHeight
                            singleStep: 1
                            minimum: 0
                            maximum: 1000
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Hint Width")
                            toolTip: qsTr("Hint Width")
                        }
                        SpinBox {
                            backendValue: backendValues.hintWidth
                            singleStep: 1
                            minimum: 0
                            maximum: 1000
                            baseStateFlag: isBaseState
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Border Radius")
                            toolTip: qsTr("Border Radius")
                        }
                        SpinBox {
                            backendValue: backendValues.hintRadius
                            singleStep: 1
                            minimum: 0
                            maximum: 100
                            baseStateFlag: isBaseState
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Border Width")
                            toolTip: qsTr("Border Width")
                        }
                        SpinBox {
                            backendValue: backendValues.hintBorderWidth
                            singleStep: 1
                            minimum: 0
                            maximum: 100
                            baseStateFlag: isBaseState
                        }

                    }
                }

                FontGroupBox {
                    finished: finishedNotify;
                    caption: qsTr("Hint Font")
                    fontFamily: backendValues.hintFontFamily
                    pointSize: backendValues.hintFontPointSize
                    pixelSize: backendValues.hintFontPixelSize
                    boldStyle: backendValues.hintFontBold
                    italicStyle: backendValues.hintFontItalic
                    underlineStyle: backendValues.hintFontUnderline
                    strikeoutStyle: backendValues.hintFontStrikeout
                }

                QWidget {
                    layout: HorizontalLayout {

                        ColorGroupBox {
                            caption: qsTr("Color")
                            finished: finishedNotify
                            backendColor: backendValues.hintFontColor
                        }
                    }
                }
            }
        }

        QScrollArea {
        }

    }
}
