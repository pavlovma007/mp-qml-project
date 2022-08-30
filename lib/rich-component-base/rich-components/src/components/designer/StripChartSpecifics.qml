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
            caption: "Wave Form Chart"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Dataset Stroke Width")
                            toolTip: qsTr("Dataset Stroke Width")
                        }

                        SpinBox {
                            backendValue: backendValues.datasetStrokeWidth
                            singleStep: 1
                            minimum: 1
                            maximum: 100
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox {
                            caption: "Line 1 Pen Color"
                            finished: finishedNotify
                            backendColor: backendValues.line1PenColor
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox {
                            caption: "Line 2 Pen Color"
                            finished: finishedNotify
                            backendColor: backendValues.line2PenColor
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox {
                            caption: "Line 3 Pen Color"
                            finished: finishedNotify
                            backendColor: backendValues.line3PenColor
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox {
                            caption: "Line 4 Pen Color"
                            finished: finishedNotify
                            backendColor: backendValues.line4PenColor
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
                            backendValue: backendValues.maxYValue
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
                            text: qsTr("Min Value")
                            toolTip: qsTr("Min Value")
                        }

                        SpinBox {
                            backendValue: backendValues.minYValue
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
                            text: qsTr("Max Time")
                            toolTip: qsTr("Max Time")
                        }

                        SpinBox {
                            backendValue: backendValues.maxTime
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
                            text: qsTr("Min Time")
                            toolTip: qsTr("Min Time")
                        }

                        SpinBox {
                            backendValue: backendValues.minTime
                            singleStep: 1
                            minimum: -1000
                            maximum: 1000
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox {
                            caption: "Background Color"
                            finished: finishedNotify
                            backendColor: backendValues.bgColor
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Background Image")
                            toolTip: qsTr("Image Source for Background")
                        }
                        UrlEdit {
                            backendValue: backendValues.bgImage
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }

                GroupBox {
                    caption: qsTr("Scale Information")
                    layout: VerticalLayout {

                        QWidget {
                            layout: HorizontalLayout {
                                ColorGroupBox {
                                    caption: "Scale Background Color"
                                    finished: finishedNotify
                                    backendColor: backendValues.scaleBgColor
                                }                           }
                        }

                        QWidget {
                            layout: HorizontalLayout {
                                Label {
                                    text: "Line Color"
                                    toolTip: qsTr("Line Color")
                                }
                                LineEdit {
                                    backendValue: backendValues.scaleLineColor
                                    baseStateFlag: isBaseState
                                    translation: true
                                }
                            }
                        }

                        QWidget {
                            layout: HorizontalLayout {
                                Label {
                                    text: qsTr("Line Width")
                                    toolTip: qsTr("Line Width")
                                }

                                SpinBox {
                                    backendValue: backendValues.scaleLineWidth
                                    singleStep: 1
                                    minimum: 1
                                    maximum: 100
                                    baseStateFlag: isBaseState
                                }
                            }
                        }

                        QWidget {
                            layout: HorizontalLayout {
                                Label {
                                    text: qsTr("Show Labels")
                                    toolTip: qsTr("Show Labels")
                                }

                                CheckBox {
                                    id: scaleShowLabelsCheckBox
                                    backendValue: backendValues.scaleShowLabels
                                    baseStateFlag: isBaseState
                                    checkable: true
                                    text: qsTr("Enable")
                                }

                            }
                        }

                        QWidget {
                            layout: HorizontalLayout {
                                Label {
                                    text: qsTr("Show Grid Lines")
                                    toolTip: qsTr("Scale Show Grid Lines")
                                }

                                CheckBox {
                                    id: showGridLinesCheckBox
                                    backendValue: backendValues.scaleShowGridLines
                                    baseStateFlag: isBaseState
                                    checkable: true
                                    text: qsTr("Enable")
                                }

                            }
                        }

                        QWidget {
                            layout: HorizontalLayout {
                                Label {
                                    text: "Grid Line Color"
                                    toolTip: qsTr("Scale Grid Line Color")
                                }
                                LineEdit {
                                    backendValue: backendValues.scaleGridLineColor
                                    baseStateFlag: isBaseState
                                    translation: true
                                }
                            }
                        }

                        QWidget {
                            layout: HorizontalLayout {
                                Label {
                                    text: qsTr("Grid Line Width")
                                    toolTip: qsTr("Scale Grid Line Width")
                                }

                                SpinBox {
                                    backendValue: backendValues.scaleGridLineWidth
                                    singleStep: 1
                                    minimum: 1
                                    maximum: 100
                                    baseStateFlag: isBaseState
                                }
                            }
                        }

                        QWidget {
                            layout: HorizontalLayout {
                                Label {
                                    text: qsTr("Scale Font Family")
                                    toolTip: qsTr("Scale Font Family")
                                }
                                FontComboBox{
                                    backendValue: backendValues.scaleFontFamily
                                    baseStateFlag: isBaseState
                                }
                            }
                        }

                        QWidget {
                            layout: HorizontalLayout {
                                ColorGroupBox {
                                    caption: "Scale Font Color"
                                    finished: finishedNotify
                                    backendColor: backendValues.scaleFontColor
                                }
                            }}

                        QWidget {
                            layout: HorizontalLayout {
                                Label {
                                    text: qsTr("Scale Font Size")
                                    toolTip: qsTr("Scale Font Size")
                                }

                                SpinBox {
                                    backendValue: backendValues.scaleFontSize
                                    singleStep: 1
                                    minimum: 1
                                    maximum: 100
                                    baseStateFlag: isBaseState
                                }
                            }
                        }
                    }
                }


                QScrollArea {
                }

            }
        }
    }
}
