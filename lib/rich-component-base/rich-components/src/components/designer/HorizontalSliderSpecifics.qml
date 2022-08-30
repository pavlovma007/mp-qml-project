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
            caption: "Horizontal Slider"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: ""
                        }
                        CheckBox {
                            text: qsTr("Allow Handle Drag")
                            backendValue: backendValues.allowDrag
                            baseStateFlag: isBaseState
                            checkable: true
                        }
                    }
                }

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
                            text: qsTr("Handle Y")
                            toolTip: qsTr("Handle Y")
                        }

                        SpinBox {
                            backendValue: backendValues.handleY
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
                            text: qsTr("Handle X min")
                            toolTip: qsTr("Handle X Min")
                        }

                        SpinBox {
                            backendValue: backendValues.xMin
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
                            text: qsTr("Handle X max")
                            toolTip: qsTr("Handle X Max")
                        }

                        SpinBox {
                            backendValue: backendValues.xMax
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
                            text: qsTr("Min Value")
                            toolTip: qsTr("Min Value")
                        }

                        SpinBox {
                            backendValue: backendValues.minimum
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
                            backendValue: backendValues.maximum
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

            }
        }

        GroupBox {
            caption: qsTr("Image Sources")
            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Track Image")
                            toolTip: qsTr("Image Source for Slider Track")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageTrack
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Handle Image")
                            toolTip: qsTr("Image Source for Handle")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageHandle
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.svg"
                            showComboBox: true
                        }
                    }
                }
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Overlay Image")
                            toolTip: qsTr("Image Source for Overlay")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageOverlay
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
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


