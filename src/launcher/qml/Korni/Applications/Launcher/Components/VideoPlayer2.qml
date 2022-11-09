import QtQml 2.3
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtMultimedia 5.12
import './' 1.0 as C

// video play
Rectangle {
	width: parent.width
	height: 500
	color: 'black'
    readonly property bool isPlaying: video.playbackState !== MediaPlayer.PlayingState
    readonly property alias position: video.position
    property alias source: video.source
    property alias state: video.playbackState

    signal next
	
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
        id: iconInCenterId
        anchors.centerIn: parent
        width: 30; height: width
        ParallelAnimation {
            id: anim1Id
            readonly property int dur: 400
            running: false
            NumberAnimation { target: iconInCenterId; property: "opacity"; from: 1.0; to: 0.0; duration: anim1Id.dur }
            NumberAnimation { target: iconInCenterId; property: "width"; from: 30; to: 70; duration: anim1Id.dur  }
        }
        source: video.playbackState === MediaPlayer.PlayingState ? 'icons/video-play-icon.svg' : 'icons/video-pause-icon.svg'
        onSourceChanged: {
            // make opacity and size animation
            anim1Id.start()
        }
        onClicked: video.playPause();
    }

	// navigation line
	C.ProressLine {
        id: plId
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 45
        anchors.horizontalCenter: parent.horizontalCenter

        height: 5
        internalHeight: 5
        radius: 2

		progressIn : video.hasVideo && video.position / video.duration
		// TODO extract metadata info to file https://doc.qt.io/qt-5/qml-qtmultimedia-mediaplayer.html#metaData-prop

		ToolTip {
			id: progressToolTipId
			text: qsTr("Save the active project")
		}

		onProgressOut: function(newProgresss){
            if(video.seekable){
				video.seek( video.duration * newProgresss)
            }else
				progressToolTipId.show("в видео не доступна перемотка", 2000)
		}

        // circle
        Rectangle {
            id: circleProgressId
            anchors.verticalCenter: parent.verticalCenter
            width: 20
            height: width
            radius: width / 2
            color: 'red'
            Drag.hotSpot.x: 10
            Drag.hotSpot.y: 10
            Binding on x {
                value: plId.progressIn * plId.width - radius
                when: ! dragHandlerMaId.drag.active
            }
            MouseArea {
                id: dragHandlerMaId
                anchors.fill: parent
                drag.target: circleProgressId
                drag.axis: Drag.XAxis
                drag.minimumX: -circleProgressId.radius
                drag.maximumX: plId.width - circleProgressId.radius
                onReleased: {
                    if(dragHandlerMaId.drag.active)
                        plId.progressOut(circleProgressId.x / plId.width)
                }
                onClicked: print(dragHandlerMaId.drag.active)
            }
        }
	}
    // play button
    C.HoveredImage {
        width: 18
        height: width
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        opacity: hovered ? 1.0 : 0.5
        source: video.playbackState !== MediaPlayer.PlayingState ? 'icons/video-play-icon.svg' : 'icons/video-pause-icon.svg'
        onClicked: {
            video.playPause()
        }
    }
    // next button
    C.HoveredImage {
        width: 18
        height: width
        anchors.left: parent.left
        anchors.leftMargin: 70
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        opacity: hovered ? 1.0 : 0.7
        source : 'icons/youtube-next-icon.svg'
        onClicked: {
            next()
            preventStealing = true
        }
    }
    // sound regulator view
    C.HoveredImage {
        width: 18
        height: width
        anchors.left: parent.left
        anchors.leftMargin: 120
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        opacity: hovered ? 1.0 : 0.7
        source : 'icons/youtube-sound-icon.png'
    }

    // TODO get info about video
//    // info icon
//    C.HoveredImage {
//        width: 18
//        height: width
//        anchors.right: parent.right
//        anchors.rightMargin: 25
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 15
//        opacity: hovered ? 1.0 : 0.7
//        source : 'icons/youtube-info-icon.svg'
//        ToolTip  {
//            id: infoToolTipId
//            visible : parent.hovered
//            text: "title:"+video.metaData.title+"\n"+
//                  "title:"+video.metaData.title+"\n"+
//                  "title:"+video.metaData.title+"\n"+
//                  "title:"+video.metaData.title+"\n";
//        }
//    }
}


