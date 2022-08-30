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
            caption: "Spinner"
            layout: VerticalLayout {

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
                            text: qsTr("Width")
                            toolTip: qsTr("Width")
                        }

                        SpinBox {
                            backendValue: backendValues.width
                            singleStep: 1
                            minimum: 10
                            maximum: 1000
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Height")
                            toolTip: qsTr("Height")
                        }

                        SpinBox {
                            backendValue: backendValues.height
                            singleStep: 1
                            minimum: 10
                            maximum: 1000
                            baseStateFlag: isBaseState
                        }
                    }
                }


                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Item Height")
                            toolTip: qsTr("Height of each item")
                        }

                        SpinBox {
                            backendValue: backendValues.itemHeight
                            singleStep: 1
                            minimum: 20
                            maximum: 40
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {

                        Label {
                            text: qsTr("Initial Index")
                            toolTip: qsTr("Initial index to be selected")
                        }

                        SpinBox {
                            backendValue: backendValues.initialIndex
                            singleStep: 1
                            minimum: 0
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
                            text: qsTr("Background")
                            toolTip: qsTr("Image Source for Background")
                        }
                        UrlEdit {
                            backendValue: backendValues.backGroundImage
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Highlight")
                            toolTip: qsTr("Image Source for Highlight")
                        }
                        UrlEdit {
                            backendValue: backendValues.highlightImage
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.svg"
                            showComboBox: true
                        }
                    }
                }
            }
        }

        FontGroupBox {
            fontFamily: backendValues.font_family
            pointSize: backendValues.font_pointSize
            pixelSize: backendValues.font_pixelSize

            boldStyle: backendValues.font_bold
            italicStyle: backendValues.font_italic
            underlineStyle: backendValues.font_underline
            strikeoutStyle: backendValues.font_strikeout
        }

        QScrollArea {
        }

    }
}

