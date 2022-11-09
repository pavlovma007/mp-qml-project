import QtQuick 2.6
import '.' as V

Column {
    property ListModel replies
    property bool isRepliesExpanded: false
    property alias comment: commentId

    signal expandRepliesClicked

    spacing: 5

    // comment
    V.Comment {
        id: commentId
    }
    // replies to this comment

    Item {
        width: repliesToCommentLinkId.width
        height: repliesToCommentLinkId.height
        Row {
            id: repliesToCommentLinkId
            Item {width: 70; height: 1; } // spacer
            Text {
                id: arrowId
                text: '^'
                font.pixelSize: 20
                font.bold: true
                color: 'blue'
                transform: Rotation {
                    angle: isRepliesExpanded ? 0 : 180
                    origin.x : arrowId.width / 2
                    origin.y : arrowId.height / 2 / 1.2
                }
            }
            Text {
                text: '  4 ОТВЕТА'
                font.pixelSize: 15
                font.family: 'SansSerif' // Roboto, Arial, SansSerif
                color: 'blue'
            }
       }
       MouseArea {
           anchors.fill: parent
           onClicked: expandRepliesClicked()
       }
    }
    Repeater{
        model : isRepliesExpanded && replies
            V.Comment {
                isSmallUserIcon: true
                x: 75
            }
    }
}
