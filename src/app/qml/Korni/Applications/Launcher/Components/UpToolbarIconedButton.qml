import QtQml 2.3
import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0 as Controls          // ToolTip Theme
import '../StateTube' 1.0 as S

Rectangle {
    property alias tipText: tipIt.text
    property alias iconSource: playlistsIconId.source
    property real sizeFactor: 1.0
    signal go

	width: 2 * Controls.Theme.margins + Controls.Theme.baseSize
	height: 2 * Controls.Theme.margins + Controls.Theme.baseSize
	Layout.leftMargin: Controls.Theme.margins
	color: '#04112A'

	property bool isEnabled: true

	MouseArea {
		anchors.fill: parent
		cursorShape: Qt.PointingHandCursor
		hoverEnabled: true
		Controls.ToolTip {
            id: tipIt
            //text:
			visible: parent.containsMouse || playlistsIconId.hovered
		}
		onClicked: parent.isEnabled && parent.go()
	}
	HoveredImage {
		id: playlistsIconId
		anchors.centerIn: parent
        //source:
        width: Controls.Theme.iconSize * sizeFactor
		height: width
		// source
		opacity: parent.isEnabled ? 1.0 : 0.5
		onClicked: parent.isEnabled && parent.go()
	}
}
