import QtQml 2.3
import QtQuick 2.3
import QtQuick.Controls 2.6 // Button
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0 as Controls
import '../Components' 1.0 as C
import '../StateLight' 1.0 as S


Rectangle {
    id: rootId
    color: Controls.Theme.colors.raised
    height: contentId.implicitHeight

    property bool _isShowCommentEditor: false
    ColumnLayout {
        id: contentId
        width: rootId.width
        spacing: 32

        Item{ height: 16 }

        // categories
        Flow {
            id: catFlowId
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            Layout.fillWidth: true
            spacing: 5

            Repeater {
                model:  S.State.categories
                RowLayout {
                    C.Tag {
                       text: modelData.text
                       font.pixelSize: 24
                       color: 'gray'
//                       textColor: 'white'

                       onClicked: { print(modelData.text) }
                    }
                    Text {
                        text: '/'
                        font.pixelSize: 24
                        color: 'white'
                    }
                }
            }
        }

        RowLayout {
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            Layout.fillWidth: true
            Image {
                Layout.preferredHeight: 100
                fillMode: Image.PreserveAspectFit
                source: S.State.articleImage
            }
            // Title
            Text {
                Layout.fillWidth: true
                color: Controls.Theme.colors.text
                font.pixelSize: 24
                wrapMode: Text.WordWrap
                text: S.State.articleTitle
            }

        }

        // Article
        Text {
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            Layout.fillWidth: true

            textFormat: Text.RichText
            color: Controls.Theme.colors.text
            font.pixelSize: 24
            wrapMode: Text.WordWrap
            text: S.State.articleText
        }

        // Comments
        Button {
            text: 'Комментировать'
            Layout.alignment: Qt.AlignHCenter
            onClicked: _isShowCommentEditor = true;
        }
        Repeater { // optional
            model : _isShowCommentEditor ? 1 : 0
            CommentEditor {
                textEdit.color: Controls.Theme.colors.text
            }
        }
        Repeater {
            model: S.State.comments
            Column {
                id: commentItemId
                property var comment : modelData
                property bool isHasReplies: !!commentItemId.comment.isHasReplies
                Repeater {
                    model: commentItemId.isHasReplies ? 1 : 0
                    CommentWithReplies{
                        comment.likeCount: commentItemId.comment.likes
                        comment.dislikeCount: commentItemId.comment.dislikes
                        comment.likedByYour: commentItemId.comment.isILike
                        comment.dislikedByYour: commentItemId.comment.isIDislike

                        comment.whenText: commentItemId.comment.date
                        comment.who: 'Анонимус Татьяна' //  TODO
                        comment.text: commentItemId.comment.text

                        onExpandRepliesClicked: print('Need load comments of parent', commentItemId.comment.id)
                    }
                }
                Repeater {
                    model: commentItemId.isHasReplies ? 0 : 1
                    Comment{
                        likeCount: commentItemId.comment.likes
                        dislikeCount: commentItemId.comment.dislikes
                        likedByYour: commentItemId.comment.isILike
                        dislikedByYour: commentItemId.comment.isIDislike

                        whenText: commentItemId.comment.date
                        who: 'Анонимус Татьяна' //  TODO
                        text: commentItemId.comment.text
                    }
                }
            }
        }



    }
    Component.onCompleted: {

    }
}
