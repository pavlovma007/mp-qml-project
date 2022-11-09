import QtQuick 2.6

Image {
	id: rootId
	property bool hovered : false
	signal clicked
    fillMode: Image.PreserveAspectCrop

	MouseArea {
        id: maId
		
        anchors.fill : rootId
		hoverEnabled: true
		
        onEntered: rootId.hovered = true
        onExited: rootId.hovered = false
        onClicked: rootId.clicked()
        
	}
}
