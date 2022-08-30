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
            caption: "Pie Chart"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Show Segment Stroke")
                            toolTip: qsTr("Show Segment Stroke")
                        }

                        CheckBox {
                            id: showSegmentStrokeCheckBox
                            backendValue: backendValues.segmentShowStroke
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("Enable")
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Segment Stroke Width")
                            toolTip: qsTr("Segment Stroke Width")
                        }

                        SpinBox {
                            backendValue: backendValues.segmentStrokeWidth
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
                            caption: "Segment Stroke Color"
                            finished: finishedNotify
                            backendColor: backendValues.segmentStrokeColor
                        }
                    }
                }

                GroupBox {
                    caption: qsTr("Legend Information")
                    layout: VerticalLayout {

                        QWidget {
                            layout: HorizontalLayout {
                                Label {
                                    text: qsTr("Show Legend")
                                    toolTip: qsTr("Show Legend")
                                }

                                CheckBox {
                                    id: scaleShowLabelsCheckBox
                                    backendValue: backendValues.showLegend
                                    baseStateFlag: isBaseState
                                    checkable: true
                                    text: qsTr("Enable")
                                }

                            }
                        }

                        QWidget {
                            layout: HorizontalLayout {
                                Label {
                                    text: qsTr("Legend Font Family")
                                    toolTip: qsTr("Legend Font Family")
                                }
                                FontComboBox{
                                    backendValue: backendValues.legendFontFamily
                                    baseStateFlag: isBaseState
                                }
                            }
                        }

                        QWidget {
                            layout: HorizontalLayout {
                                ColorGroupBox {
                                    caption: "Legend Font Color"
                                    finished: finishedNotify
                                    backendColor: backendValues.legendFontColor
                                }
                            }}

                        QWidget {
                            layout: HorizontalLayout {
                                Label {
                                    text: qsTr("Legend Font Size")
                                    toolTip: qsTr("Legend Font Size")
                                }

                                SpinBox {
                                    backendValue: backendValues.legendFontSize
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

