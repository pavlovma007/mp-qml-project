import QtQml 2.3
import QtQuick 2.3
import Korni3Plugin 1.0
import QSyncable 1.0
import './' 1.0 as S

Item {
    property bool isWindowMaximized: false
    property string viewName: 'playlist' // video | playlist | playlists
    property bool isListMode: false

    // ================= for video ==============================
    property var video
    property bool isAutoPlay : true
    property int playStateIn: 0 // command for video    1 play 2 pause
    property int playStateOut: 0 // report from player
    property alias comments: commentsId
    JsonListModel {
        id: commentsId
        keyField: 'id'
        fields: ['id','text','likes','dislikes','parent','date','isILike','isIDislike',
                'repliesCount','author_thumbnail']
    }
    Korni3ApiProcess {
        id: processVideoId
        property string data
        onStarted: data = ''
        onReadyRead: data += readAll()
        onFinished: {
            video=JSON.parse(data)
            viewName = 'video'
            if(isAutoPlay)
                playStateIn = 1
        }
    }
    Korni3ApiProcess {
        id: processCommentsId
        property string data
        onStarted: data = ''
        onReadyRead: data += readAll()
        onFinished: {
            var commentsTmp = JSON.parse(data)
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
        }
    }
    function goToVideo(playlistId, videoId){
        if(!video || !video.id || videoId !== video.id){ //
            processVideoId.start('./yt-backend/yt-video.py', [videoId] )
            processCommentsId.start('./yt-backend/yt-video-comments.py', [videoId, 'root'] )
        }else{
            viewName = 'video'
            if(isAutoPlay)
                playStateIn = 1
        }
    }

    // ==============for playlist (many videos) ===========================
    property string playlistId: ''
    property string playlistName: ''
    //    property var playlist
    property alias playlistVideos: playlistVideosId
    JsonListModel {
        id: playlistVideosId
        keyField: 'id'
        fields: ['id','zT','imagePreviewSource','name','channelName','viewCount','whenLoaded','duration',
            'playlist', 'release_timestamp', 'epoch'] // videoFileId
    }
    Korni3ApiProcess {
        id: processVideosId
        property string data
        onStarted: data = ''
        onReadyRead: data += readAll()
        onFinished: {
            playlistVideosId.source = JSON.parse(data)
            viewName = 'playlist'
        }
    }
    Korni3ApiProcess {
        id: processPlaylistId
        property string data

        property string plId: ''
        property string plName: ''

        onStarted: data = ''
        onReadyRead: data += readAll()
        onFinished: {
            playlistVideosId.source = JSON.parse(data)
            playlistId = plId
            playlistName = plName
            viewName = 'playlist'
        }
    }
    function goToPlaylist(plId, name){
        name = name || ''
        playStateIn = 2 // pause
        if(playlistId !== plId ){
            processPlaylistId.plId = plId
            processPlaylistId.plName = name
            processPlaylistId.start('./yt-backend/yt-playlist.py', [plId] )
            processVideosId.start('./yt-backend/yt-videos.py', [plId] )
        } else
            viewName = 'playlist'
    }


    // ============ playlists (many pls) ==============================
    property string uploaderId
    property alias playlists: playlistsId
    JsonListModel {
        id: playlistsId
        keyField: 'id'
        fields: ["id","zT","name","type","zU","uploader","url","tags"]
    }
    Korni3ApiProcess {
        id: processPlayListsId
        property string uploader : ''
        property string data
        onStarted: data = ''
        onReadyRead:  data += readAll()
        onFinished: {
            var tmpPlaylists = JSON.parse(data)
            playlistsId.source = tmpPlaylists
            uploaderId = uploader

            playStateIn = 2 // pause
            viewName = 'playlists'
        }
    }
    function goToPlaylists(uploader){
        uploader = uploader || ''  // TODO
        processPlayListsId.uploader = uploader
        processPlayListsId.start('./yt-backend/yt-playlists.py', [uploader])
    }


    Component.onCompleted: {
        goToPlaylists()

        //goToPlaylist('PL0jsIjRtCuJ1mk1y-Gow88KwSLAxAaZ9q') // учеба
        //goToPlaylist('PL3xTr7kT-yE9B3L7m5C2YMrtgpIFOVaWl') // UCfRP4GY7iS9UuOGlZiSGhNw PLLqKATfceKNvS2MXnJMhLf2sAtNT6WHQL
        //goToPlaylist('PLLqKATfceKNvFCXEgtm4U-Ey9HuALpQCj') // черный треугольник Защита
        //goToPlaylist('PLEm80CtdsYuyOVbAcDgjxmvif7nTySRWL')
        //goToPlaylist('PLhGvxgDCtsZCKjLvtdJr69isoP3bstdhL')
        //goToVideo('PLLqKATfceKNvS2MXnJMhLf2sAtNT6WHQL', 'kX6hlJn4F-k')  // JY-q3tNSCNw
        
        //goToPlaylist('PLT4VoYPje97tMcpP3XCO0OyQE-laBDrVX')
    }
}
