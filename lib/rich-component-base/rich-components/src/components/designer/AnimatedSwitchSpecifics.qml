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
            caption: "Animated Switch"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: "Text On"
                            toolTip: qsTr("Text On")
                        }
                        LineEdit {
                            backendValue: backendValues.textOn
                            baseStateFlag: isBaseState
                            translation: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: "Text Off"
                            toolTip: qsTr("Text Off")
                        }
                        LineEdit {
                            backendValue: backendValues.textOff
                            baseStateFlag: isBaseState
                            translation: true
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

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Text On X")
                            toolTip: qsTr("Text On X Position")
                        }

                        SpinBox {
                            backendValue: backendValues.textOnX
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
                            text: qsTr("Text Off X")
                            toolTip: qsTr("Text Off X Position")
                        }

                        SpinBox {
                            backendValue: backendValues.textOffX
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
                            text: ""
                        }
                        CheckBox {
                            text: qsTr("On")
                            backendValue: backendValues.on
                            baseStateFlag: isBaseState
                            checkable: true
                        }
                    }
                }
            }
        }

        GroupBox {
            caption: qsTr("Image Information")
            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Off")
                            toolTip: qsTr("Image Source for Off State")
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
                            text: qsTr("On")
                            toolTip: qsTr("Image Source for On State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageOn
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *."
                            showComboBox: true
                        }
                    }
                }
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Slider")
                            toolTip: qsTr("Image Source for Slider")
                        }
                        UrlEdit {
                            backendValue: backendValues.sliderImage
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.svg"
                            showComboBox: true
                        }
                    }
                }
                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Slider On X")
                            toolTip: qsTr("Slider On X Position")
                        }

                        SpinBox {
                            backendValue: backendValues.sliderImageOnX
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
                            text: qsTr("Slider Off X")
                            toolTip: qsTr("Slider Off X Position")
                        }

                        SpinBox {
                            backendValue: backendValues.sliderImageOffX
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
                            text: qsTr("Slider Y")
                            toolTip: qsTr("Slider Y Position")
                        }

                        SpinBox {
                            backendValue: backendValues.sliderImageY
                            singleStep: 1
                            minimum: 0
                            maximum: 1000
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

