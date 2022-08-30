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
            caption: "Knob"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Add Items")
                            toolTip: qsTr("Add Items")
                        }

                        CheckBox {
                            backendValue: backendValues.add
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("Enable")
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Remove Items")
                            toolTip: qsTr("Remove Items")
                        }

                        CheckBox {
                            backendValue: backendValues.remove
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("Enable")
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Show Hint")
                            toolTip: qsTr("Show Hint")
                        }

                        CheckBox {
                            backendValue: backendValues.showHint
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("Enable")
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Initial Index")
                            toolTip: qsTr("Initial Index")
                        }

                        SpinBox {
                            backendValue: backendValues.initialIndex
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
                            text: qsTr("Mouse Area Width")
                            toolTip: qsTr("Mouse Area Width")
                        }

                        SpinBox {
                            backendValue: backendValues.mouseAreaWidth
                            singleStep: 1
                            minimum: 0
                            maximum: 200
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Mouse Area Height")
                            toolTip: qsTr("Mouse Area Height")
                        }

                        SpinBox {
                            backendValue: backendValues.mouseAreaHeight
                            singleStep: 1
                            minimum: 0
                            maximum: 200
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
                            text: qsTr("Dial")
                            toolTip: qsTr("Image Source for Dial")
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
                            text: qsTr("Dial Width")
                            toolTip: qsTr("Dial Width")
                        }

                        SpinBox {
                            backendValue: backendValues.imageBaseWidth
                            singleStep: 1
                            minimum: 0
                            maximum: 200
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Dial Height")
                            toolTip: qsTr("Dial Height")
                        }

                        SpinBox {
                            backendValue: backendValues.imageBaseHeight
                            singleStep: 1
                            minimum: 0
                            maximum: 200
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Needle")
                            toolTip: qsTr("Image Source for Needle")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageNeedle
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.svg"
                            showComboBox: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Needle Width")
                            toolTip: qsTr("Needle Width")
                        }

                        SpinBox {
                            backendValue: backendValues.imageNeedleWidth
                            singleStep: 1
                            minimum: 0
                            maximum: 200
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Needle Height")
                            toolTip: qsTr("Needle Height")
                        }

                        SpinBox {
                            backendValue: backendValues.imageNeedleHeight
                            singleStep: 1
                            minimum: 0
                            maximum: 200
                            baseStateFlag: isBaseState
                        }
                    }
                }

            }
        }


        FontGroupBox {
            //finished: finishedNotify;
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

        GroupBox {
            caption: qsTr("Hint Options")
            layout: VerticalLayout {
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

