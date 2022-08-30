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
            caption: "VU Meter"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Value")
                            toolTip: qsTr("Initial Value")
                        }

                        SpinBox {
                            backendValue: backendValues.value
                            singleStep: 1
                            minimum: -20
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
                            text: qsTr("Background Image")
                            toolTip: qsTr("Image Source for Background")
                        }
                        UrlEdit {
                            backendValue: backendValues.backgroundImage
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Background width")
                            toolTip: qsTr("Background width")
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
                            text: qsTr("Background height")
                            toolTip: qsTr("Background height")
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
                            text: qsTr("Needle Image")
                            toolTip: qsTr("Image Source for the Needle")
                        }
                        UrlEdit {
                            backendValue: backendValues.needleImage
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp"
                            showComboBox: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Needle width")
                            toolTip: qsTr("Needle width")
                        }

                        SpinBox {
                            backendValue: backendValues.needleImageWidth
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
                            text: qsTr("Needle height")
                            toolTip: qsTr("Needle height")
                        }

                        SpinBox {
                            backendValue: backendValues.needleImageHeight
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
                            text: qsTr("Needle X")
                            toolTip: qsTr("Needle X")
                        }

                        SpinBox {
                            backendValue: backendValues.needleX
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
                            text: qsTr("Needle Y")
                            toolTip: qsTr("Needle Y")
                        }

                        SpinBox {
                            backendValue: backendValues.needleX
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
                            text: qsTr("Needle Rotation X")
                            toolTip: qsTr("Needle Rotation X")
                        }

                        SpinBox {
                            backendValue: backendValues.needleRotationX
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
                            text: qsTr("Needle Rotation Y")
                            toolTip: qsTr("Needle Rotation Y")
                        }

                        SpinBox {
                            backendValue: backendValues.needleRotationY
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
                            text: qsTr("Overlay Image")
                            toolTip: qsTr("Image Source for the Overlay")
                        }
                        UrlEdit {
                            backendValue: backendValues.overlayImage
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp"
                            showComboBox: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Overlay width")
                            toolTip: qsTr("Overlay width")
                        }

                        SpinBox {
                            backendValue: backendValues.overlayImageWidth
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
                            text: qsTr("Overlay height")
                            toolTip: qsTr("Overlay height")
                        }

                        SpinBox {
                            backendValue: backendValues.overlayImageHeight
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
                            text: qsTr("Overlay X")
                            toolTip: qsTr("Overlay X")
                        }

                        SpinBox {
                            backendValue: backendValues.overlayX
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
                            text: qsTr("Overlay Y")
                            toolTip: qsTr("Overlay Y")
                        }

                        SpinBox {
                            backendValue: backendValues.overlayY
                            singleStep: 1
                            minimum: 0
                            maximum: 10000
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

