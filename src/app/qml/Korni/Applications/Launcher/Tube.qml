import QtQml 2.3
import QtQuick 2.6
import QtQuick.Controls 2.6 // ScrollBar Button
import QtQuick.Window 2.1
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0 as Controls

import QMLExif 1.0

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

    // keys
//    Keys.onPressed: {
//        if(S.State.viewName === 'video') {
//            print('pressed', event.key, Qt.Key_Space)
//            if(event.key === Qt.Key_PageUp){
//                sbPlaylistId.decrease(); sbPlaylistId.decrease()
//                event.accepted = true
//            }
//            else if(event.key === Qt.Key_PageDown){
//                sbPlaylistId.increase() ; sbPlaylistId.increase()
//                event.accepted = true
//            }
//            else if(event.key === Qt.Key_Right){
//                videoId.seek(video.position + 5000)
//                event.accepted = true
//            }
//            else if(event.key === Qt.Key_Left){
//                videoId.seek(video.position - 5000)
//                event.accepted = true
//            }
//            else if(event.key === Qt.Key_Space){
//                print('space')
//                videoId.player.playPause()
//                event.accepted = true
//            }
//            else
//                event.accepted = false
//        }

//        if(S.State.viewName === 'playlist'){
//            print('event.key', event.key)
//            if(event.key===Qt.Key_PageUp){
//                sbPlaylistId.decrease(); sbPlaylistId.decrease()
//                event.accepted = true
//            }
//            else if(event.key===Qt.Key_PageDown){
//                sbPlaylistId.increase() ; sbPlaylistId.increase()
//                event.accepted = true
//            }
//            else
//                event.accepted = false
//        }
//    }


    // video
    FocusScope {
        width: childrenRect.width; height: childrenRect.height
        x:childrenRect.x; y: childrenRect.y

//        onActiveFocusChanged: { focusChanged(focus) }

        Flickable {
            id: flickVideoId
            objectName: 'flickVideoId'
            visible: S.State.viewName === 'video'
            anchors.fill: parent

            contentWidth: contentId.width
            contentHeight: contentId.height
            ScrollBar.vertical: ScrollBar { // todo size + customization
                id: sbVideoId
                width: 10
                height: flickVideoId.height
                //            anchors.right: flickVideoId.right
                orientation: Qt.Vertical
                visible: true
                // position:
                // pageSize:
            }
            function down(){
                if(sbVideoId.position + sbVideoId.stepSize < 0.99)
                    sbVideoId.increase()
            }
            function up(){
                if(sbVideoId.position - sbVideoId.stepSize > 0.01)
                    sbVideoId.decrease()
            }
            focus: true
            Keys.onUpPressed: up()
            Keys.onDownPressed: down()
            MouseArea {
                anchors.fill: parent
                onWheel: {
                    if(wheel.angleDelta.y > 0){
                      flickVideoId.up()
                    }else{
                      flickVideoId.down()
                    }
                }
            }


            Column {
                id: contentId
                //anchors.fill: parent
                width: rootId.width
                anchors.margins: 5
                spacing: 5


                // Up toolbar
                Item {
                    height: 50;  width: rootId.width;
                    Rectangle {
                        color: '#2E2F30'
                        x:0; y:0; height: 50;  width: rootId.width;
                    }
                    RowLayout {
                        x:0; y:0; height: 50;  width: rootId.width;
                        spacing: 5

                        // TODO BACK button
                        Rectangle {
                            width: 40
                            height: 40
                            color: '#04112A'
                            MouseArea {
                                anchors.fill: parent
                                onClicked: { S.State.goToPlaylist(S.State.playlistId) }
                            }
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                        C.HoveredImage {
                            width: 40
                            height: 40

                            source: 'Views/icons/user.svg'
                            function showTT(){
                                ttId.show('', 5000)
                            }
                            onHoveredChanged: { if(hovered ) showTT(); }
                            onClicked: { if(ttId.visible) ttId.hide(); else showTT(); }
                            ToolTip {
                                id: ttId
                                timeout: 3000
                                contentItem: Column {
                                    Text {
                                        text: 'Управление аккаунтом\nПользователь: abc'
                                        color: 'white'
                                    }
                                    Button {
                                        text: 'запустить приложение'
                                    }
                                }
                                background: Rectangle {
                                    color: '#606060' //'#2E2F30'
                                }
                            }
                        }
                    }

                }
                C.SearchLine {
                    width: parent.width * 0.8
                    x: parent.width * 0.1
                    onSearch: function(text){
                        print('search not implemented:', text)
                    }
                }
    //            Switch {
    //                text: qsTr("Мои")
    //                checked: true
    //                C.ToolTip { text: qsTr("Только Мои") }
    //            }
                V.VideoView {
                    id: videoId
                    height: S.State.isWindowMaximized ?
                                Screen.height * 0.8
                              : 510

                    player.source: !!S.State.video ? S.State.video.videoFile : ''
                    Connections {
                        target: player
                        onSourceChanged: print('need play! ')//player.play()
                    }
                    onStateOutChanged: S.State.playState = state
                }
                // tags
                Row {
                    Repeater {
                        model: {
                            var result = []
                            if(!S.State.video)
                                return result
                            for(var i in S.State.video.tags){
                                result.push({text: S.State.video.tags[i], selected: false})
                            }
                            return result
                        }
                        Text {
                            text: ' #' + modelData.text
                            color: 'blue'
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: print('not implemented')
                            }
                        }
                    }
                }

                Item {height: 20; width: 1} // spacer
                //                V.CommentEditor {
                //                    onLeaveCommentClicked: print(commentText);
                //                }
                Column {
                    spacing: 9

                    TextEdit {
                        selectByMouse: true
                        text: !!S.State.video && S.State.video.name
                        font.pixelSize: 20
                    }
                    RowLayout {
                        spacing: 16

                        Text {
                            text: !!S.State.video && S.State.video.viewCount + ' просмотров'
                            font.pixelSize: 15
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                ToolTip {
                                    visible: parent.containsMouse
                                    text: 'на момент сохранния видео в базе'
                                }
                            }
                        }
                        // like
                        Item {
                            width: 32; height: 32;
                            C.HoveredImage {
                                width: 32
                                height: 32
                                fillMode: Image.Stretch
                                source: !!S.State.video && !!S.State.video.likedByYour ? './Components/icons/like-filled.png' : './Components/icons/like.png'
                                onClicked: likeClicked() // TODO
                            }
                        }
    //                        Text {
    //                            text: '' + likeCount
    //                            font.pixelSize: 12
    //                            color: '#606060'
    //                        }
                        // dislike
                        Item {
                            Layout.leftMargin: 20
                            width: 48; height: 48;
                            C.HoveredImage {
                                width: 32
                                height: 32
                                fillMode: Image.Stretch
                                source: !!S.State.video && !!S.State.video.dislikedByYour ? './Components/icons/dislike-filled.png' : './Components/icons/dislike.png'
                                onClicked: dislikeClicked() // TODO
                            }
                        }
    //                        Text {
    //                            text: '' + dislikeCount
    //                            font.pixelSize: 12
    //                            color: '#606060'
    //                        }
                    }
                }

                // comments of video
                Repeater {
                    model: S.State.comments
                    Column {
                        V.CommentWithReplies {
                            visible: model.repliesCount > 0

                            topPadding: 20
                            //replies: []
                            isRepliesExpanded: false
                            comment.text: model.text
                            comment.likeCount: model.likes
                            comment.likedByYour: model.isILike // todo
                            comment.dislikedByYour: false // todo
    //                            comment.userIconSource: model.author_thumbnail // todo
                            repliesCount: model.repliesCount
                            onExpandRepliesClicked: print('TODO expand comment')
                        }
                        V.Comment {
                            visible: model.repliesCount === 0

                            text: model.text
                            likeCount: model.likes
                            likedByYour: model.isILike // todo
                            dislikedByYour: false // todo
                            //userIconSource: model.author_thumbnail // todo
                        }
                    }

                }
            }
        }
    }

    // playlist
    FocusScope {
        width: childrenRect.width; height: childrenRect.height
        x:childrenRect.x; y: childrenRect.y
        anchors.fill: parent

        Flickable {
            id: playlistFlickId
            visible: S.State.viewName === 'playlist'
            contentWidth: playlistContentId.width
            contentHeight: playlistContentId.height

            boundsBehavior: Flickable.StopAtBounds

            ScrollBar.vertical: ScrollBar { // todo size + customization
                id : sbPlaylistId
                focus: true
                width: 10
                height: playlistFlickId.height
                orientation: Qt.Vertical
                visible: true
            }
            function down(){
                if(sbPlaylistId.position + sbPlaylistId.stepSize < 0.99)
                    sbPlaylistId.increase()
            }
            function up(){
                if(sbPlaylistId.position - sbPlaylistId.stepSize > 0.01)
                    sbPlaylistId.decrease()
            }
            focus: true
            Keys.onUpPressed: up()
            Keys.onDownPressed: down()
            MouseArea {
                anchors.fill: parent
                onWheel: {
                    if(wheel.angleDelta.y > 0){
                      playlistFlickId.up()
                    }else{
                      playlistFlickId.down()
                    }
                }
            }

            ColumnLayout {
                id: playlistContentId

                RowLayout {
                    Layout.leftMargin: 9
                    Layout.rightMargin: 9
                    TextEdit {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                        text:  'Плейлист:' + '       ' + S.State.playlist.id
                        font.pixelSize: 16
                        color: 'gray'

                        selectByMouse: true
                    }

                    Text { text: 'Плиткой' }
                    Switch {
                        onCheckedChanged: S.State.isListMode = checked
                    }
                    Text { text: 'Списком' }
                }
                C.SearchLine {
                    Layout.fillWidth: true
                    Layout.leftMargin: 9
                    Layout.rightMargin: 9

                    onSearch: function(text){
                        print('search not implemented:', text)
                    }
                }
                TextEdit {
                    leftPadding: 10
                    selectByMouse: true
                    text:  S.State.playlist.name
                    font.pixelSize: 32
                }

                // tags
                Row {
                    Repeater {
                        model: {
                            var result=[]
                            for(var i in S.State.playlist.tags){
                                result.push({text: S.State.playlist.tags[i], selected: false})
                            }
                        }
                        Text {
                            text: ' #' + modelData.text
                            color: 'blue'
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: print('not implemented')
                            }
                        }
                    }
                }

                Flow {
                    width: rootId.width
                    rightPadding: 9
                    leftPadding: 9

                    spacing: 16
                    Repeater {
                        model: S.State.playlistVideos
                        V.VideoPreviewItem {
                            Binding on imagePreviewSource {
                                value: model.imagePreviewSource
                                when : !!model.imagePreviewSource
                            }
                            name: model.name //"Укрепление рубля / \nЗакрытие ядерного ..."
                            channelName: model.playlist // "aftershock.news"
                            viewCount: model.viewCount // "25 тыс. просмотров"
                            function epochToText(ep){
                                var date = new Date(ep * 1000)
                                var s = '' + date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate()
                                return s;
                            }
                            function whenLoadedToText(s){
                                var r = s.match(/(\d\d\d\d)(\d\d)(\d\d)/)
                                return '' + r[1] + '-' + r[2] + '-' + r[3]
                            }
                            whenLoaded : !!model.whenLoaded && model.whenLoaded !== 'null' && model.whenLoaded !== 'NULL'
                                         ? whenLoadedToText(model.whenLoaded) :
                                           !!model.epoch && model.epoch !== 'null' && model.epoch != 'NULL'
                                           ? 'запись в бд создана '+epochToText(model.epoch)
                                           : '' // model.release_timestamp


                            onClicked: S.State.goToVideo(S.State.playlistId, model.id)
                        }
                    }
                }
            }
        }
    }


    onActiveFocusItemChanged: {
        print("activeFocusItem", activeFocusItem /*, activeFocusItem.objectName*/)
        for(var c in activeFocusItem.children)
            print(activeFocusItem.children[c])
    }


//    Repeater { // optional playlists
//        model: S.State.viewName === 'playlists'
//        Flickable {
//            Flow {
//                Repeater {
//                    V.PlaylistPreviewItem { }
//                }
//            }
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
