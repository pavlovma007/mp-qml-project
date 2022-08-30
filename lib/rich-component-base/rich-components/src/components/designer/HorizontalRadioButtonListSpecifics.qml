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
            caption: "RadioButtonList - Horizontal"
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

                IntEditor {
                    backendValue: backendValues.spacing

                    caption: qsTr("Field Spacing")
                    baseStateFlag: isBaseState;

                    step: 1;
                    minimumValue: 0;
                    maximumValue: 100;
                }

                IntEditor {
                    backendValue: backendValues.itemSpacing

                    caption: qsTr("Item Spacing")
                    baseStateFlag: isBaseState;

                    step: 1;
                    minimumValue: 0;
                    maximumValue: 1000;
                }

            }
        }

        GroupBox {
            caption: qsTr("Image Sources")
            layout: VerticalLayout {
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("Checked")
                            toolTip: qsTr("Image Source for Checked State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageChecked
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.jpeg *.svg"
                            showComboBox: true
                        }
                    }
                }
                QWidget {
                    layout: HorizontalLayout {
                        Label {
                            text: qsTr("UnChecked")
                            toolTip: qsTr("Image Source for UnChecked State")
                        }
                        UrlEdit {
                            backendValue: backendValues.imageUnChecked
                            baseStateFlag: isBaseState
                            filter: "*.png *.gif *.jpg *.bmp *.svg"
                            showComboBox: true
                        }
                    }
                }

                IntEditor {
                    backendValue: backendValues.imageHeight

                    caption: qsTr("Image Height")
                    baseStateFlag: isBaseState;

                    step: 1;
                    minimumValue: 0;
                    maximumValue: 1000;
                }

                IntEditor {
                    backendValue: backendValues.imageWidth

                    caption: qsTr("Image Width")
                    baseStateFlag: isBaseState;

                    step: 1;
                    minimumValue: 0;
                    maximumValue: 1000;
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

