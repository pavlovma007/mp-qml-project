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
            caption: "Heat Map"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox {
                            caption: "Color"
                            finished: finishedNotify
                            backendColor: backendValues.color
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Max")
                            toolTip: qsTr("Max")
                        }

                        SpinBox {
                            backendValue: backendValues.max
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
                            text: qsTr("Min")
                            toolTip: qsTr("Min")
                        }

                        SpinBox {
                            backendValue: backendValues.min
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
                            text: qsTr("Radius")
                            toolTip: qsTr("Radius")
                        }

                        SpinBox {
                            backendValue: backendValues.radius
                            singleStep: 1
                            minimum: 1
                            maximum: 1000
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Calculate Intensity")
                            toolTip: qsTr("Calculate Intensity")
                        }

                        CheckBox {
                            id: calculateIntensityCheckBox
                            backendValue: backendValues.calculateIntensity
                            baseStateFlag: isBaseState
                            checkable: true
                            text: qsTr("Enable")
                        }

                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Intensity")
                        }

                        DoubleSpinBox {
                            enabled: !calculateIntensityCheckBox.checked
                            backendValue: backendValues.intensity
                            singleStep: 0.1
                            minimum: 0.1
                            maximum: 0.9
                            decimals: 1
                            spacing: 4
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QScrollArea {
                }

            }
        }
    }
}
