import QtQuick 2.6
import QtQuick.Controls 2.6 as QQ

QQ.ToolTip {
    id: rootId
    text: qsTr("Только Мои")
    visible: parent.hovered
    property alias backColor: backId.color
    property alias textColor: contentId.color

	background: Rectangle {
        id: backId
		color: 'black'
		radius: 5
	}
	contentItem: Text {
        id: contentId
		text: rootId.text
		color: 'white'
	}
}
