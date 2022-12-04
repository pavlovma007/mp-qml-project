import QtQuick 2.6
import QtQuick.Controls 2.6 // Button
import QtQuick.Layouts 1.3


// comment
RowLayout {
    width: parent.width
    property string placeholder: "Введите комментарий"
    property bool isSmallUserIcon: false
    property alias userIconSource: userImageId.source
    property string commentText

    signal leaveCommentClicked
    signal cancelClicked

    property alias textEdit: commentEditId

    // user icon
    ColumnLayout {
        Rectangle {
            id: iconBlockId
            width: isSmallUserIcon ? 24 : 50
            height: width
            radius: width / 2
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

    Column {
        Layout.fillWidth: true
        spacing: 5
        TextEdit {
            id: commentEditId
            width: parent.width - 10
            leftPadding: 5
            rightPadding: 5
            /*Layout.preferredWidth: */
//            Layout.leftMargin: 5
//            Layout.rightMargin: 5
            bottomPadding: 0

            wrapMode: TextInput.WordWrap
            inputMethodHints: Qt.ImhMultiLine
            text: placeholder

            color: '#8B6472'
            onActiveFocusChanged: {
                if(activeFocus && text === placeholder)
                    text = ''
                if(!activeFocus && !text)
                    text = placeholder
                enableLineAnimationId.start()
            }
        }
        Rectangle {
            id: underLineId
            width: parent.width - 10
            height: 2
            radius: 1
            color: '#909090'
            Rectangle {
                anchors.centerIn: parent
                color: '#161616'
                height: 2

                NumberAnimation on width {
                    id: enableLineAnimationId
                    duration: 600
                    easing.type: Easing.InOutQuad
                    from: !commentEditId.activeFocus ? 0 : underLineId.width
                    to: !commentEditId.activeFocus ? underLineId.width  : 0
                }
            }
            Button {
                id: cancelButtonId
                enabled: commentEditId.text !== "" && commentEditId.text !== placeholder
                text: "ОСТАВИТЬ КОММЕНТАРИЙ"
                anchors.top: underLineId.bottom
                anchors.topMargin: 10
                anchors.right: underLineId.right
                anchors.rightMargin: 75
                onClicked: (commentText = commentEditId.text) && leaveCommentClicked()
            }
            Button {
                enabled: true
                text: "ОТМЕНА"
                anchors.top: cancelButtonId.top
                anchors.right: cancelButtonId.left
                anchors.rightMargin: 25
                onClicked:{
                    commentEditId.text = placeholder
                    cancelClicked()
                }
            }
        }
    }
}


