import QtQml 2.3
import QtQuick 2.6
import QtQuick.Controls 2.5
import '../Components' 1.0 as C

Item {
    id: rootId
    width: 210
    height: contentId.height
    property string imagePreviewSource: "https://i.ytimg.com/vi/lpdVWXk-ZKY/hqdefault.jpg"
    property string name: "Философия"
    property string channelName: "MikhailPavlov"
    property string whenLoaded: "обновлено 5 дней назад"

    Column {
        id: contentId
        padding: 0
        topPadding: 0
        spacing: 8

        C.HoveredImage {
            width: rootId.width
            height: 114
            source: imagePreviewSource
            Rectangle {
                anchors.right: parent.right
                height: parent.height
                opacity: 0.8
                color: 'black'
                width: 0.40 * parent.width
                Text {
                    anchors.bottom: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 18
                    color: 'white'
                    text: '14'
                }
                C.HoveredImage {
                    anchors.top: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 25 ; height: 24
                    source: './icons/youtube-playlist-icon.svg'
                    // TODO click - go to playlist
                }
            }
        }
        Text {
            font.family: "Helvetica"
            font.pointSize: 11
            color: 'black'

            text: name
        }
        Text {

            font.family: "Helvetica"
            font.pointSize: 8
            color: 'gray'
            text: channelName + "\n" + whenLoaded
        }
//        Text {
//            enabled: false
//            font.family: "Helvetica"
//            font.pointSize: 8
//            color: 'gray'
//            text: "доступно по ссылке"
//        }
        Text {
            id: whenLoadedId
            font.family: "Helvetica"
            font.pointSize: 9
            font.bold: true
            color: 'darkgray'
            text: "ПОСМОТРЕТЬ ВЕСЬ ПЛЕЙЛИСТ"
            // TODO click action
        }
    }

    MouseArea {
//            anchors.fill: parent
        x:0;y:0; width: parent.width; height: parent.he
        hoverEnabled: true
//        onContainsMouseChanged: {rootId.color = (containsMouse) ? 'mistyrose' : 'white'}
    }
}
