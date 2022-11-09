import QtQuick 2.6
import QtQuick.Controls 2.6 // Button
import QtQuick.Layouts 1.3
import '../Components' 1.0 as C

// comment
RowLayout {
//    width: parent.width
    property string who: 'Анонимус'
    property alias userIconSource: userImageId.source
    property bool isSmallUserIcon: false
    property string whenText: '1 день назад'
    property int likeCount: 237
    property int dislikeCount: 732
    property bool likedByYour: false
    property bool dislikedByYour: true
    property alias text: textContentId.text

    signal replyClicked
    signal likeClicked
    signal dislikeClicked

    property bool _visibleEditor: false

    // user icon
    ColumnLayout{
        Rectangle {
            id: iconBlockId
            width: isSmallUserIcon ? 24 : 50
            height: width
            radius: 25
            color: '#EEEEEE'
            clip: true
            Image {
                id: userImageId
                anchors.fill: parent
                anchors.margins: 5
                source: '../Components/icons/like-filled.png'
            }
        }
        Item { Layout.fillHeight: true; }
    }
    ColumnLayout {
//        implicitWidth: parent.width
        Layout.minimumHeight: iconBlockId.height
        Layout.leftMargin: 10
        Text {
            text: who + '<font color="#646464">  ' + whenText + '</font>'
            font.pixelSize: 12
            color: '#030303'
        }
        Text {
            id: textContentId
            text: 'У Есенина есть стихи посвящённые Америке, там такие строки - \nВот она - мировая биржа \nВот они - подлецы всех стран'
            font.pixelSize: 14
            color: '#030303'
        }
        RowLayout {
            // like comment
            Item {
                width: 16; height: 16;
                C.HoveredImage {
                    width: 16
                    height: 16
                    fillMode: Image.Stretch
                    source: likedByYour ? '../Components/icons/like-filled.png' : '../Components/icons/like.png'
                    onClicked: likeClicked()
                }
            }
            Text {
                text: '' + likeCount
                font.pixelSize: 12
                color: '#606060'
            }
            // dislike comment
            Item {
                Layout.leftMargin: 20
                width: 16; height: 16;
                C.HoveredImage {
                    width: 16
                    height: 16
                    fillMode: Image.Stretch
                    source: dislikedByYour ? '../Components/icons/dislike-filled.png' : '../Components/icons/dislike.png'
                    onClicked: dislikeClicked()
                }
            }
            Text {
                text: '' + dislikeCount
                font.pixelSize: 12
                color: '#606060'
            }
            Button {
                Layout.leftMargin: 10
                flat: true
                highlighted: hovered
                contentItem: Text {
                    text: 'ОТВЕТИТЬ'
                    font.pixelSize: 14
                    color: '#606060'  // parent.highlighted ? '#606060' : '#303030'
                }
                background: Rectangle {
                    color: parent.highlighted ? '#DEDEDE' : 'white'
                    radius: 3
                }

                onClicked: {
                    _visibleEditor = true
                    replyClicked()
                }
            }

        }
        Repeater { // optional CommentEditor
            model: _visibleEditor ? 1 : 0
            CommentEditor {
                width: 100
                isSmallUserIcon: true
                onCancelClicked: _visibleEditor = false
            }
        }
//        Item { Layout.fillHeight: true; }
    }
}



