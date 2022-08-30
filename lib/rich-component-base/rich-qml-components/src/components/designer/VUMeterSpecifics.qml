import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("VU Meter")

        SectionLayout {

            Label {
                text: qsTr("Initial Value")
            }

            SecondColumnLayout {
                LineEdit {
                    backendValue: backendValues.initialValue
                }

                ExpandingSpacer {

                }
            }
        }

    }


    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Image Sources")

        SectionLayout {

            Label {
                text: qsTr("Background Image")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.backgroundImage
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Background size")
            }

            SecondColumnLayout {
                Label {
                    text: "W"
                    width: 12
                }

                SpinBox {
                    backendValue: backendValues.width
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                Label {
                    text: "H"
                    width: 12
                }

                SpinBox {
                    backendValue: backendValues.height
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Needle Image")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.needleImage
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Needle size")
            }

            SecondColumnLayout {
                Label {
                    text: "W"
                    width: 12
                }

                SpinBox {
                    backendValue: backendValues.needleImageWidth
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                Label {
                    text: "H"
                    width: 12
                }

                SpinBox {
                    backendValue: backendValues.needleImageHeight
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Needle X")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.needleX
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Needle Y")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.needleY
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Needle Rotation X")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.needleRotationX
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Needle Rotation Y")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.needleRotationY
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Overlay Image")
            }

            SecondColumnLayout {
                UrlChooser {
                    Layout.fillWidth: true
                    backendValue: backendValues.overlayImage
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Overlay size")
            }

            SecondColumnLayout {
                Label {
                    text: "W"
                    width: 12
                }

                SpinBox {
                    backendValue: backendValues.overlayImageWidth
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                Label {
                    text: "H"
                    width: 12
                }

                SpinBox {
                    backendValue: backendValues.overlayImageHeight
                    minimumValue: 0
                    maximumValue: 2000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Overlay X")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.overlayX
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

            Label {
                text: qsTr("Overlay Y")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.overlayY
                    minimumValue: -1000
                    maximumValue: 1000
                    decimals: 0
                }

                ExpandingSpacer {

                }
            }

        }
    }

    Component.onCompleted: {
        spinValue.value =  backendValues.value;
    }
}
