import QtQuick 2.6
import QtQuick.Controls 2.6 // ScrollBar Button
import QtQuick.Window 2.1
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0 as Controls

// TODO
import QMLExif 1.0

import QSyncable 1.0

import './Components' 1.0 as C
import './Views' 1.0 as V
import './StateLight' 1.0 as S


// TODO "palette QML Basic Type"
Window {
    id: rootId
    title: 'Korni - Технология личного информационного суверенитета'

    x: 61 ; y: 80;
//    onXChanged: print(x,y)
    width: 600;
    height: 800;
    //height: 55

//    color: 'red'
//    opacity: 0.6


    Repeater { // optional
        model : S.State.viewName === 'doc' ? 1 : 0
        Flickable {
            id: flickId
            anchors.fill: parent
            contentWidth: pageId.width
            contentHeight: pageId.height
            ScrollBar.vertical: ScrollBar { // todo size + customization
                width: 10
                height: flickId.height
                //            anchors.right: flickId.right
                orientation: Qt.Vertical
                //            visible: true
                // position:
                // pageSize:
            }
            V.LightPage {
                id: pageId
                width: rootId.width
            }
        }

    }




//    Flickable {
//        id: flickId
//        anchors.fill: parent
//        contentWidth: contentId.width
//        contentHeight: contentId.height
//        ScrollBar.vertical: ScrollBar { // todo size + customization
//            width: 10
//            height: flickId.height
//            //            anchors.right: flickId.right
//            orientation: Qt.Vertical
//            //            visible: true
//            // position:
//            // pageSize:
//        }

//        Column {
//            id: contentId
//            //anchors.fill: parent
//            width: rootId.width
//            anchors.margins: 5
//            spacing: 0


//            // Up toolbar
//            Rectangle {
//                color: '#2E2F30'
//                height: 50;  width: rootId.width;
//                Rectangle {
//                    width: 40
//                    height: 40
//                    color: '#04112A'
//                    anchors.top: parent.top
//                    anchors.topMargin: 5
//                    anchors.left : parent.left
//                    anchors.leftMargin: 5
//                }
//                C.HoveredImage {
//                    width: 40
//                    height: 40
////                    color: '#04112A'
//                    anchors.top: parent.top
//                    anchors.topMargin: 5
//                    anchors.right : parent.right
//                    anchors.rightMargin: 5

//                    source: 'Views/icons/user.svg'
//                    function showTT(){
//                        ttId.show('', 5000)
//                    }
//                    onHoveredChanged: { if(hovered ) showTT(); }
//                    onClicked: { if(ttId.visible) ttId.hide(); else showTT(); }
//                    ToolTip {
//                        id: ttId
//                        timeout: 3000
//                        contentItem: Column {
//                            Text {
//                                text: 'Управление аккаунтом\nПользователь: abc'
//                                color: 'white'
//                            }
//                            Button {
//                                text: 'запустить приложение'
//                            }
//                        }
//                        background: Rectangle {
//                            color: '#606060' //'#2E2F30'
//                        }
//                    }
//                }
//            }

//            C.SearchLine {
//                width: parent.width * 0.8
//                x: parent.width * 0.1
//            }
//            C.TagLine { width: parent.width }
////            Switch {
////                text: qsTr("Мои")
////                checked: true
////                C.ToolTip { text: qsTr("Только Мои") }
////            }
//            V.VideoView { }
//            Item {height: 20; width: 1} // spacer
//            V.CommentEditor {
//                onLeaveCommentClicked: print(commentText);
//            }
//            Repeater {
//                model: 2
//                V.CommentWithReplies {
//                    topPadding: 20
//                }
//            }
//            V.PlaylistPreviewItem { }
//            V.VideoPreviewItem { }
//        }
//    }


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
