import QtQml 2.3
import QtQuick 2.6
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0 // OpacityMask
import '../Components' 1.0 as C

// TODO добавить полосочку на сколько процентов просмотрено видео тобой
Rectangle {
    id: rootId
    width: 800
    height: contentId.height

    property string imagePreviewSource: "https://i.ytimg.com/vi/lpdVWXk-ZKY/hqdefault.jpg"
    property string name: "Укрепление рубля / Закрытие ядерного ..."
    property string channelName: "aftershock.news"
    property string viewCount: "25 тыс. просмотров"
//    property alias whenLoaded: whenLoadedId.text
    property alias duration: timecode.text
    property alias menuButton: menuButton
    property alias videoNumber : number.text

    signal clicked()

    MouseArea {
        id: maId
        x: 0; y: 0; width: parent.width; height: parent.height
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onContainsMouseChanged: {rootId.color = (containsMouse) ? '#F2F2F2' : 'white'}
        onClicked: rootId.clicked()
    }

    RowLayout {
        id: contentId
        width: rootId.width
        spacing: 8

        Text {
            id: number
            leftPadding: parent.spacing
            text: '1'
        }

        // image
        Item {
            width: 120; height: 70
            C.HoveredImage {
                id: img
                width: 120; height: 70
                source: imagePreviewSource
            }
            Rectangle {
                id: mask
                visible: false

                color: "red"
                radius: 12
                width: 120; height: 70
            }
            Item {
                anchors.fill: parent

            }
            OpacityMask {
                anchors.fill: img
                source: img
                maskSource: mask
            }
            Rectangle {
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                readonly property int sp: 2
                width: timecode.width + 2 * sp
                height: timecode.height + 2 * sp
                color: 'black'
                radius: 5
                Text {
                    id: timecode
                    leftPadding: parent.sp
                    topPadding: parent.sp
                    text: '25:31'
                    font.pixelSize: 13
                    color: 'white'
                }
            }
        }

        // main text: name and channel
        ColumnLayout {
            Layout.fillWidth: true

            Text {
                width: rootId.width
                wrapMode: Text.WordWrap

                font.family: "Roboto, Arial, sans-serif, "
                font.pointSize: 13
                color: 'black' // Qt.darkGray
                text: name
            }
            Text {
                wrapMode: Text.WordWrap
                font.family: "Roboto"
                font.pointSize: 12
                color: 'darkGray'
                text: channelName // + "/ \n" + viewCount
            }
        }

//        Text {
//            id: whenLoadedId
//            font.family: "Helvetica"
//            font.pointSize: 8
//            color: 'black'
//            text: "14 часов назад"
//        }

          // TODO make round blink when pressed
        C.Buttin3PointRound {
            id: menuButton
        }
    }

}
