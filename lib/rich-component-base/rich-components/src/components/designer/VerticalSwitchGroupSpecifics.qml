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
            caption: "Vertical Switch Group"
            layout: VerticalLayout {

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox{
                            caption: "Text On Color"
                            backendColor: backendValues.textOnColor
                            baseStateFlag: isBaseState
                        }
                    }
                }

                QWidget {
                    layout: HorizontalLayout {
                        ColorGroupBox{
                            caption: "Text Off Color"
                            backendColor: backendValues.textOffColor
                            baseStateFlag: isBaseState
                        }
                    }
                }

                IntEditor {
                    backendValue: backendValues.spacing

                    caption: qsTr("Button Spacing")
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


