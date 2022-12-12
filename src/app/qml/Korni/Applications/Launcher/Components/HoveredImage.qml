import QtQuick 2.6

Image {
	id: rootId
	property bool hovered : false
    property alias cursorShape: maId.cursorShape
	signal clicked
    fillMode: Image.PreserveAspectCrop

	MouseArea {
        id: maId
		
        anchors.fill : rootId
		hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
		
        onEntered: rootId.hovered = true
        onExited: rootId.hovered = false
        onClicked: rootId.clicked()
        
	}
}
