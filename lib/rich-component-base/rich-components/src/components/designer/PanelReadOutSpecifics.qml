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
            caption: qsTr("Panel ReadOut")
            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Panel Image")
                            toolTip: qsTr("Image Source for Panel")
                        }
                        UrlEdit {
                            backendValue: backendValues.imagePanel
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
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
                            minimum: 0
                            maximum: 10000
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
                            minimum: 0
                            maximum: 10000
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Text")
                        }
                        LineEdit {
                            backendValue: backendValues.text
                            baseStateFlag: isBaseState;
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


            }
        }


        FontGroupBox {
            //finished: finishedNotify;
        }

        QScrollArea {
        }

    }
}
