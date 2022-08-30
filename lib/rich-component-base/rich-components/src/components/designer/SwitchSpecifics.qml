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
            caption: qsTr("Image Sources")
            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Image On")
                            toolTip: qsTr("Image Source for On State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageOn
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg"
                            showComboBox: true
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Image Off")
                            toolTip: qsTr("Image Source for Off State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageOff
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp"
                            showComboBox: true
                        }
                    }
                }
            }
        }


        GroupBox {
            caption: "Text On"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: "Text On"
                            toolTip: qsTr("Text")
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
                        ColorGroupBox{
                            caption: "Color"
                            backendColor: backendValues.textOnColor
                            baseStateFlag: isBaseState
                       }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: "Font Family"
                            toolTip: qsTr("Text On Font Family")
                        }
                        FontComboBox{
                            backendValue: backendValues.textOnFontFamily
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Font Size")
                            toolTip: qsTr("Text On Font Size")
                        }

                        SpinBox {
                            backendValue: backendValues.textOnFontSize
                            singleStep: 1
                            minimum: 0
                            maximum: 20
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: ""
                            toolTip: qsTr("")
                        }
                        CheckBox {
                            text: qsTr("Bold")
                            toolTip: qsTr("Bold")
                            backendValue: backendValues.textOnBold
                            baseStateFlag: isBaseState
                            checkable: true
                        }
                    }
                }

            }
        }


        GroupBox{
            caption: "Text Off"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: "Text Off"
                            toolTip: qsTr("Text")
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
                            caption: "Color"
                            backendColor: backendValues.textOffColor
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: "Font Family"
                            toolTip: qsTr("Text Off Font Family")
                        }
                        FontComboBox{
                            backendValue: backendValues.textOffFontFamily
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Font Size")
                            toolTip: qsTr("Text Off Font Size")
                        }

                        SpinBox {
                            backendValue: backendValues.textOffFontSize
                            singleStep: 1
                            minimum: 0
                            maximum: 20
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: ""
                            toolTip: qsTr("")
                        }
                        CheckBox {
                            text: qsTr("Bold")
                            toolTip: qsTr("Bold")
                            backendValue: backendValues.textOffBold
                            baseStateFlag: isBaseState
                            checkable: true
                        }
                    }
                }


            }
        }

        GroupBox {
            caption: "Switch State"
            layout: VerticalLayout {

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
        
        QScrollArea {
        }

    }
}

