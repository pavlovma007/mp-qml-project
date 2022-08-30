import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0 as Controls

import QMLExif 1.0

import QSyncable 1.0

import QtMultimedia 5.12


Item {

	// video play 
	Video {
		id: video
		width : 800
		height : 600
		source: "/home/mp/Видео/работа. борьба с зависаниями-2022-08-24_16.34.12.mp4"

		MouseArea {
			anchors.fill: parent
			onClicked: {
				video.play()
			}
		}

		focus: true
		Keys.onSpacePressed: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
		Keys.onLeftPressed: video.seek(video.position - 5000)
		Keys.onRightPressed: video.seek(video.position + 5000)
	}




	// QSYNCABLE PLUGIN 
//    JsonListModel {
//        source: []
//        keyField: 'uuid'
//    }
    ListView {
        model: JsonListModel {
            source: [] // json
            keyField: 'uuid'
        }
        delegate: Text {
            text: ''
        }
    }


	// EXIF PLUGIN 
	QMLExif {
		id: exif
		source: "./example.JPG"
		ifd: QMLExif.IFD_EXIF
	}
	Text {
		width: parent.width
		height: parent.height
		anchors.left: parent.left
		anchors.verticalCenter: parent.verticalCenter
		//horizontalAlignment: Text.AlignRight
		//verticalAlignment: Text.AlignVCenter
		
		property string tag: QMLExif.ET_DateTimeOriginal 
		/*
        QMLExif.ET_WhiteBalance,
        QMLExif.ET_ColorSpace,
        QMLExif.ET_DateTimeDigitized,
        QMLExif.ET_DateTimeOriginal,
        QMLExif.ET_EXIFVersion,
        QMLExif.ET_FocalLength,
        QMLExif.ET_ExposureBiasValue,
        QMLExif.ET_ExposureMode,
        QMLExif.ET_ExposureProgram,
        QMLExif.ET_ExposureTime		
		*/
		
		color: "black"
		font.pixelSize: 10
		wrapMode: Text.WordWrap
		text:exif.getTagName(tag) + ": " + exif.getTagValue(tag)
	}
	
	
	
}
