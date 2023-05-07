import QtQml 2.3
import QtQuick 2.6
import QtQuick.Controls 2.10 // Label
//import QtQuick.Controls 2.6 // Switch // ScrollBar Button RoundButton
import QtQuick.Window 2.1
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0 as Controls

//import QMLExif 1.0

import QSyncable 1.0 // TODO remove

import './Components' 1.0 as C
import './Views' 1.0 as V
import './StateTube' 1.0 as S


// TODO "palette QML Basic Type"
Window {
    id: rootId
    title: 'Korni - Технология личного информационного суверенитета'
    onVisibilityChanged: {
        S.State.isWindowMaximized = (visibility == Window.Maximized)
    }

    x: 61 ; y: 100;
    width: 800;
    height: 800;

    // video
    V.TubeVideoView {}

    // playlist
    V.TubePlaylistView {}

//    onActiveFocusItemChanged: {
//        print("activeFocusItem", activeFocusItem /*, activeFocusItem.objectName*/)
//        for(var c in activeFocusItem.children)
//            print(activeFocusItem.children[c])
//    }


    Repeater { // optional playlists
        model: S.State.viewName === 'playlists'
        Flickable {
            Column {
                spacing: 10
                Repeater {
                    model : S.State.playlists
                    Button {
                        text: '' + model.uploader
                        flat: true
                        hoverEnabled: true
                        highlighted: hovered || pressed

                        font.pixelSize: 22
                        //font.italic: true
                        onClicked: {
                            S.State.goToPlaylist(model.id)
                        }
                    }
//                    V.PlaylistPreviewItem {
//                        name: model.uploader
//                    }
                }
            }
        }
    }




//    C.VideoPlayer {}

	// QSYNCABLE PLUGIN
//    JsonListModel {
//        source: []
//        keyField: 'uuid'
//    }
//    ListView {
//        model: JsonListModel {
//            source: [] // json
//            keyField: 'uuid'
//        }
//        delegate: Text {
//            text: ''
//        }
//    }


	// EXIF PLUGIN 
//	QMLExif {
//		id: exif
//		source: "./example.JPG"
//		ifd: QMLExif.IFD_EXIF
//	}
//	Text {
//		width: parent.width
//		height: parent.height
//		anchors.left: parent.left
//		anchors.verticalCenter: parent.verticalCenter
//		//horizontalAlignment: Text.AlignRight
//		//verticalAlignment: Text.AlignVCenter
		
//		property string tag: QMLExif.ET_DateTimeOriginal
//		/*
//        QMLExif.ET_WhiteBalance,
//        QMLExif.ET_ColorSpace,
//        QMLExif.ET_DateTimeDigitized,
//        QMLExif.ET_DateTimeOriginal,
//        QMLExif.ET_EXIFVersion,
//        QMLExif.ET_FocalLength,
//        QMLExif.ET_ExposureBiasValue,
//        QMLExif.ET_ExposureMode,
//        QMLExif.ET_ExposureProgram,
//        QMLExif.ET_ExposureTime
//		*/
		
//		color: "black"
//		font.pixelSize: 10
//		wrapMode: Text.WordWrap
//		text:exif.getTagName(tag) + ": " + exif.getTagValue(tag)
//	}
	
	
	
}
