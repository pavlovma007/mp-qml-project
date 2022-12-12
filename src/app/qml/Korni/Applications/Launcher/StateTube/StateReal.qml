import QtQml 2.3
import QtQuick 2.3
import Korni3Plugin 1.0
import QSyncable 1.0
import './' 1.0 as S

Item {
    property bool isWindowMaximized: false
    property string viewName: 'playlist' // video | playlist | playlists
    property bool isListMode: false
    // =================for video ==============================
    property var video
    property string videoFile: '/home/mp/Видео/Библиотека-2022-11-07_18.53.11.mp4'
    property int playState: 0
    onPlayStateChanged: print('playState=', playState)

    property alias comments: commentsId
    JsonListModel {
        id: commentsId
        keyField: 'id'
        fields: ['id','text','likes','dislikes','parent','date','isILike','isIDislike',
                'repliesCount','author_thumbnail']
    }
    // ==============for playlist ===========================
    property string playlistId: 'promtech'
    property var playlist
    property alias playlistVideos: playlistVideosId
    JsonListModel {
        id: playlistVideosId
        keyField: 'id'
        fields: ['id','zT','imagePreviewSource','name','channelName','viewCount','whenLoaded','duration',
            'playlist', 'release_timestamp', 'epoch'] // videoFileId
    }
    // ============playlists================================
    property alias playlists: playlistsId
    JsonListModel {
        id: playlistsId
        keyField: 'id'
        fields: ["id","zT","name","type","zU","uploader","url",'tags']
    }
    // =====================================================

    function goToVideo(playlistId, videoId){
        video=JSON.parse(Korni3Api.runCommand('', './yt-backend/yt-video.py "'+videoId+'"'))

        var commentsTmp = JSON.parse(Korni3Api.runCommand('', './yt-backend/yt-video-comments.py "'+videoId+'"  '+'"root"'))
        var commentsTmp2=[]
        for(var i=0;i<commentsTmp.length; ++i){
            var c=commentsTmp[i]
            commentsTmp2.push({
                                  id: c.id,
                                  text: c.text,
                                  likes: c.like_count,
                                  //dislikes: 10,
                                  date: c.timestamp, // '1 дань назад',
                                  isILike: false, // TODO
                                  isIDislike: false, // TODO
                                  repliesCount: c.repliesCount,
                                  //isHasReplies: c.isHasReplies > 0,
                                  //author_thumbnail: c.author_thumbnail // todo file
                                  // todo comment author
                              })
        }
        commentsId.source = commentsTmp2

        viewName = 'video'
        playState = 1
        // auto play TODO
    }
    function goToPlaylist(plId){
        playlistId = plId
        var tmpPlaylist = JSON.parse(Korni3Api.runCommand('', './yt-backend/yt-playlist.py "'+plId+'"'))

        // fix selected tags enable and disable
        //var newTags=[]
        //for(var index in tmpPlaylist.tags){
        //    newTags.push({text: tmpPlaylist.tags[index] , selected: true})
        //}
        //tmpPlaylist.tags=newTags
        playlist = tmpPlaylist

        viewName = 'playlist'
        //print('playlist.name', playlist.name)
        playlistVideosId.source = getVideosOfPlaylist(playlistId)
        //print('S.State.playlistVideos', playlistVideos)
    }
    function goToPlaylists(){
        playlistsId.source = getPlaylists('')
    }


    // ============================Back work======================================
    function getPlaylists(filterText){
        return JSON.parse(Korni3Api.runCommand('', './yt-backend/yt-playlists.py "'+filterText+'"'))
    }
    function getVideosOfPlaylist(playlistId){
        return JSON.parse(Korni3Api.runCommand('', './yt-backend/yt-videos.py "'+playlistId+'"  '))
    }



    Component.onCompleted: {
        //goToPlaylists()
        //goToPlaylist('UCVIDh3IrKeFOd41TUCFTGxA')

        goToPlaylist('PL3xTr7kT-yE9B3L7m5C2YMrtgpIFOVaWl') // UCfRP4GY7iS9UuOGlZiSGhNw PLLqKATfceKNvS2MXnJMhLf2sAtNT6WHQL
        //goToVideo('PLLqKATfceKNvS2MXnJMhLf2sAtNT6WHQL', 'kX6hlJn4F-k')  // JY-q3tNSCNw
    }
}



//Korni3Process {
//    id: process
//    onReadyRead: text.text = readAll();
//}

//Timer {
//    interval: 1000
//    repeat: true
//    triggeredOnStart: true
//    running: true
//    onTriggered: process.start(/bin/cat, [ /proc/uptime ]);
//}
