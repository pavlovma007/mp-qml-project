import QtQml 2.3
import QtQuick 2.6
import QtMultimedia 5.12 // MediaPlayer.PlayingState

Item {
    property bool isWindowMaximized: false
    property string viewName: 'playlist' // video | playlist | playlists
    // =================for video ==============================
    property string videoFile: '/home/mp/Видео/Библиотека-2022-11-07_18.53.11.mp4'
    property int playState: 0
    onPlayStateChanged: print('playState', playState)

    property var comments: [
        {id: '10', text: 'Да полное фуфло - ваша статья', likes: 100, dislikes: 200, parent: '', date: '1 дань назад', isILike: true, isIDislike: true},
        {id: '20', text: 'сам ты козел', likes: 200, dislikes: 100, date: '1 дань назад', isILike: true, isIDislike: false},
        {id: '30', text: 'Вау! это то что я искал', likes: 1000, dislikes: 10, date: '1 дань назад',isILike: true, isIDislike: true,
            isHasReplies: true },
    ]
    // ==============for playlist ===========================
    property string playlistId: 'promtech'
    property string playlistName: 'Промышленные Технологии'
    property var playlistVideos: [
        {
            id: '10',
            imagePreviewSource: "https://i.ytimg.com/vi/lpdVWXk-ZKY/hqdefault.jpg",
            videoFile: '/home/mp/Видео/Библиотека-2022-11-07_18.53.11.mp4',
            name: "Укрепление рубля / \nЗакрытие ядерного ...",
            channelName: "aftershock.news",
            viewCount: "25 тыс. просмотров",
            whenLoaded : '10 дней назад',
        }
    ]
//    Timer { // TODO
//        id: playdelayTimerId
//        interval: 500
//        onTriggered: {
//            playState = MediaPlayer.PlayingState
//        }
//    }
    function goToVideo(playlistId, videoId){
        videoFile = '/home/mp/Видео/Библиотека-2022-11-07_18.53.11.mp4'// TODO
        viewName = 'video'
        // auto play
//        playdelayTimerId.start()
    }

}
