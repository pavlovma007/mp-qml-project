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
            caption: "Draw Area"
            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox {
                            caption: "Background Color"
                            finished: finishedNotify
                            backendColor: backendValues.color
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
                            backendValue: backendValues.borderWidth
                            singleStep: 1
                            minimum: 0
                            maximum: 100
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox {
                            caption: "Border Color"
                            finished: finishedNotify
                            backendColor: backendValues.borderColor
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Pen Width")
                            toolTip: qsTr("Pen Width")
                        }

                        SpinBox {
                            backendValue: backendValues.penWidth
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
                            caption: "Pen Color"
                            finished: finishedNotify
                            backendColor: backendValues.penColor
                        }
                    }}

                QScrollArea {
                }

            }
        }
    }
}
