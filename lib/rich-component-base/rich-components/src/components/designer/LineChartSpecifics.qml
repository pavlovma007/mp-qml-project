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
            caption: "Line Chart"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Bezier Curve")
                            toolTip: qsTr("Bezier Curve")
                        }

                        CheckBox {
                            id: bezierCurveCheckBox
                            backendValue: backendValues.bezierCurve
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("Enable")
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Dataset Fill")
                            toolTip: qsTr("Dataset Fill")
                        }

                        CheckBox {
                            id: datasetFillCheckBox
                            backendValue: backendValues.datasetFill
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("Enable")
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Dataset Stroke")
                            toolTip: qsTr("Dataset Stroke")
                        }

                        CheckBox {
                            id: datasetStrokeCheckBox
                            backendValue: backendValues.datasetStroke
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("Enable")
                        }

                    }
                }

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
                        Label {
                            text: qsTr("Show Point Dot")
                            toolTip: qsTr("Show Point Dot")
                        }

                        CheckBox {
                            id: pointDotCheckBox
                            backendValue: backendValues.pointDot
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("Enable")
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Point Dot Radius")
                            toolTip: qsTr("Point Dot Radius")
                        }

                        SpinBox {
                            backendValue: backendValues.pointDotRadius
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
                            text: qsTr("Point Dot Stroke Width")
                            toolTip: qsTr("Point Dot Stroke Width")
                        }

                        SpinBox {
                            backendValue: backendValues.pointDotStrokeWidth
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
                            text: qsTr("Show Legend")
                            toolTip: qsTr("Show Legend")
                        }

                        CheckBox {
                            id: showLegendCheckBox
                            backendValue: backendValues.showLegend
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("Enable")
                        }

                    }
                }

                GroupBox {
                    caption: qsTr("Scale Information")
                    layout: VerticalLayout {

                        QWidget {
                            layout: HorizontalLayout {
                                Label {
                                    text: qsTr("Scale Overlay")
                                    toolTip: qsTr("Scale Overlay")
                                }

                                CheckBox {
                                    id: scaleOverlayCheckBox
                                    backendValue: backendValues.scaleOverlay
                                    baseStateFlag: isBaseState
                                    checkable: true
                                    text: qsTr("Enable")
                                }

                            }
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
