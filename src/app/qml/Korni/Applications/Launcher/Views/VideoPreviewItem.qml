import QtQml 2.3
import QtQuick 2.6
import QtQuick.Controls 2.5
import '../Components' 1.0 as C

// TODO добавить полосочку на сколько процентов просмотрено видео тобой
Item {
    id: rootId
    width: 202
    height: contentId.height

    property string imagePreviewSource: "https://i.ytimg.com/vi/lpdVWXk-ZKY/hqdefault.jpg"
    property string name: "Укрепление рубля / \nЗакрытие ядерного ..."
    property string channelName: "aftershock.news"
    property string viewCount: "25 тыс. просмотров"
    property alias whenLoaded: whenLoadedId.text
    property alias duration: timecode.text

    signal clicked()

    readonly property int _height : 114

    // image not available
    C.HoveredImage {
        width: rootId.width
        height: _height
        fillMode: Image.PreserveAspectCrop
        source: './icons/video-default-icon-3.svg'
        opacity: 0.5
        //scale: 0.5
    }
    Column {
        id: contentId
        padding: 0
        topPadding: 0
        spacing: 8

        Item{
            width: rootId.width
            height: _height
            C.HoveredImage {
                anchors.fill: parent
                source: imagePreviewSource
            }
            // timecode
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
        Text {
            width: rootId.width
            wrapMode: Text.WordWrap

            font.family: "Helvetica"
            font.pointSize: 11
            color: 'black'
            text: name
        }
        Text {
            font.family: "Helvetica"
            font.pointSize: 8
            color: 'black'
            text: channelName + "/ \n" + viewCount
        }
        Text {
            id: whenLoadedId
            font.family: "Helvetica"
            font.pointSize: 8
            color: 'black'
            text: "14 часов назад"
        }

    }
    MouseArea {
        id: maId
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        //        onContainsMouseChanged: {rootId.color = (containsMouse) ? 'mistyrose' : 'white'}
        onClicked: rootId.clicked()
    }
}
