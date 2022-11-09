import QtQml 2.3
import QtQuick 2.6
import QtQuick.Controls 2.5
import QtMultimedia 5.12
import './' 1.0 as C

// video play
Rectangle {
	width: parent.width
	height: 500
	color: 'black'
	
	Video {
		id: video
		anchors.fill: parent
		width : 800
		height : 600
		source: "/home/mp/Видео/работа. борьба с зависаниями-2022-08-24_16.34.12.mp4"

		function playPause(){
			if(video.playbackState === MediaPlayer.PlayingState)
				video.pause()
			else
				video.play()
		}
		
		MouseArea {
			anchors.fill: parent
			onClicked: {
				video.playPause();
			}
		}

		focus: true
		Keys.onSpacePressed: video.playPause()
		Keys.onLeftPressed: video.seek(video.position - 5000)
		Keys.onRightPressed: video.seek(video.position + 5000)
	}

	// action icon in center
    C.HoveredImage {
		anchors.centerIn: parent
		source: video.playbackState !== MediaPlayer.PlayingState ? 'icons/video-play-icon.svg' : 'icons/video-pause-icon.svg'
		opacity: {
			if(video.playbackState === MediaPlayer.PlayingState && hovered)
				return 0.5
			if(video.playbackState === MediaPlayer.PlayingState && !hovered)
				return 0.0
			return 1.0
		}
		onClicked: video.playPause();
	}

	// navigation line
	C.ProressLine {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        progressIn : video.hasVideo && video.position / video.duration
		// TODO extract metadata info to file https://doc.qt.io/qt-5/qml-qtmultimedia-mediaplayer.html#metaData-prop

		ToolTip {
			id: progressToolTipId
			text: qsTr("Save the active project")
		}

		onProgressOut: function(newProgresss){
			if(video.seekable)
				video.seek( video.duration * newProgresss)
			else
				progressToolTipId.show("в видео не доступна перемотка", 2000)
		}
	}
}


