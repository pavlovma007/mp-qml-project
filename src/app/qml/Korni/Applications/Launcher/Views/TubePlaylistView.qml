import QtQml 2.3
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.6 // ScrollBar Button

import '../Components' 1.0 as C
import '../StateTube' 1.0 as S

// playlist
Column {
    id: componentId
    width: rootId.width // rootId - is window
    spacing: 5

    C.UpToolbar {
        id: upToolbarId
    }
    // ID of playlist and switcher
    RowLayout {
        id: filterId
        Layout.fillWidth: true
        Layout.leftMargin: 9
        Layout.rightMargin: 9

        TextEdit {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            text:  'Плейлист:' + '       ' + (!!S.State.playlist ? S.State.playlist.id : '')
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
        id: searchLineId

        onSearch: function(text){
            print('search not implemented:', text)
        }
    }

    ScrollView {
        width: rootId.width
        height: rootId.height
                - componentId.spacing * (componentId.children.length - 1)
                - upToolbarId.height - filterId.height - searchLineId.height
        clip: true

        ColumnLayout {
            id: playlistContentId
            width: rootId.width

            // NAME of playlist
            TextEdit {
                Layout.fillWidth: true
                Layout.leftMargin: 9
                Layout.rightMargin: 9

                wrapMode: Text.WordWrap
                selectByMouse: true
                readOnly: true
                text: (!!S.State.playlist ? S.State.playlist.name : '')
                font.pixelSize: 32
            }

            // tags
            Flow {
                id: playlistTagFlowId
                //Layout.fillWidth: true
                width: rootId.width - 9 * 2
                Layout.leftMargin: 9
                Layout.rightMargin: 9

                spacing: 5
                property int modelLenLimit: 1000 // max tag len in theory

                Repeater {
                    model: {
                        var result=[]
                        if(!S.State.playlist)
                            return result
                        for(var i in S.State.playlist.tags){
                            if(i > parent.modelLenLimit)
                                break
                            result.push({text: S.State.playlist.tags[i], selected: false})
                        }
                        return result
                    }
                    Text {
                        text: ' #' + modelData.text
                        color: 'blue'
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: print('not implemented. tag=', modelData.text)
                        }
                    }
                }
                RoundButton {
                    width: 24 ; height: 24
                    baselineOffset: -7
                    topPadding: 3
                    text: '+'
                    font.pixelSize: 10
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onPressed:  mouse.accepted = false
                    }
                    onClicked: print('TODO show tags popup')
                }
                onHeightChanged: {
                    if(height > 100)
                        modelLenLimit /= 2
                }

            }

            // videos
            Flow {
                Layout.fillWidth: true

                width: rootId.width
                rightPadding: 9
                leftPadding: 9

                spacing: 16
                Repeater {
                    model: !S.State.isListMode && S.State.playlistVideos
                    VideoPreviewItem {
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
                                       !!model.epoch && model.epoch !== 'null' && model.epoch !== 'NULL'
                                       ? 'запись в бд создана '+epochToText(model.epoch)
                                       : '' // model.release_timestamp
                        duration: durationToText(parseInt(model.duration))

                        onClicked: S.State.goToVideo(S.State.playlistId, model.id)
                    }
                }
            }
            Column {
                id: videoPreviewItemByLineColumnId
                Layout.fillWidth: true

                rightPadding: 9
                leftPadding: 9

                spacing: 16

                Repeater {
                    model: S.State.isListMode && S.State.playlistVideos
                    VideoPreviewItemByLine {
                        width: rootId.width - 9 * 2
                        Binding on imagePreviewSource {
                            value: model.imagePreviewSource
                            when : !!model.imagePreviewSource
                        }
                        name: model.name //"Укрепление рубля / \nЗакрытие ядерного ..."
                        channelName: model.playlist // "aftershock.news"
                        viewCount: model.viewCount // "25 тыс. просмотров"
                        duration: durationToText(parseInt(model.duration))
                        videoNumber: index + 1
//                            function epochToText(ep){
//                                var date = new Date(ep * 1000)
//                                var s = '' + date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate()
//                                return s;
//                            }
//                            function whenLoadedToText(s){
//                                var r = s.match(/(\d\d\d\d)(\d\d)(\d\d)/)
//                                return '' + r[1] + '-' + r[2] + '-' + r[3]
//                            }
//                            whenLoaded : !!model.whenLoaded && model.whenLoaded !== 'null' && model.whenLoaded !== 'NULL'
//                                         ? whenLoadedToText(model.whenLoaded) :
//                                           !!model.epoch && model.epoch !== 'null' && model.epoch != 'NULL'
//                                           ? 'запись в бд создана '+epochToText(model.epoch)
//                                           : '' // model.release_timestamp


                        onClicked: S.State.goToVideo(S.State.playlistId, model.id)
                    }
                }
            }
        }

    }


    function durationToText(durSec){
        //print('durSec', durSec, typeof durSec)
        var h = Math.trunc(durSec / 3600)
        h = isNaN(h) ? '-' : h
        var m = Math.trunc((durSec - h * 3600) / 60)
        m = isNaN(m) ? '-' : m
        var s = Math.trunc((durSec - h * 3600 - m * 60) / 60)
        s = isNaN(s) ? '-' : s
        if(h>0)
            return ''+h+':'+m+':'+s
       else
            return ''+m+':'+s
    }
}
