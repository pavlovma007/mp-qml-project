import QtQml 2.3
import QtQuick 2.6
import QtQuick.Controls 2.5
import '../Components' 1.0 as C

// TODO добавить полосочку на сколько процентов просмотрено видео тобой
Item {
    id: rootId
    width: 210
    height: contentId.height

    property string imagePreviewSource: "https://i.ytimg.com/vi/lpdVWXk-ZKY/hqdefault.jpg"
    property string name: "Укрепление рубля / \nЗакрытие ядерного ..."
    property string channelName: "aftershock.news"
    property string viewCount: "25 тыс. просмотров"
    property alias whenLoaded: whenLoadedId.text

    signal clicked()

    Column {
        id: contentId
        padding: 0
        topPadding: 0
        spacing: 8

        C.HoveredImage {
            width: rootId.width
            height: 114
            source: imagePreviewSource
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
        //        onContainsMouseChanged: {rootId.color = (containsMouse) ? 'mistyrose' : 'white'}
        onClicked: rootId.clicked()
    }
}
