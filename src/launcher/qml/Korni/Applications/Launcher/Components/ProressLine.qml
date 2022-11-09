import QtQml 2.3
import QtQuick 2.6

// navigation line
Rectangle {
	id: progressLineId
	color: 'pink'
	height: 10
    property alias internalHeight: progressInternalId.height
	radius: 3
	width: parent.width
    property alias ma: maId

	property real progressIn : 0.0
	signal progressOut(real newProgress)

	Rectangle {
		id: progressInternalId
		height: parent.height - 4
		width: parent.width * progressLineId.progressIn
		anchors.verticalCenter: parent.verticalCenter
		radius: 2
        color: 'red' // '#A20025'
	}
    MouseArea {
        id: maId
		anchors.fill: parent
		acceptedButtons: Qt.LeftButton
        onClicked: {
            progressLineId.progressOut(mouseX / progressLineId.width)
            preventStealing = true
        }
	}
}
