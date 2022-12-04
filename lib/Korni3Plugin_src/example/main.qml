import QtQml 2.3
import QtQuick 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import Korni3Plugin 1.0

Rectangle {
    id: mainWindow
    visible: true
    width: 640
    height: 480



    Rectangle {
        id: infoRect
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 250
        color: "gray"
        opacity: 0.8

    }
    ListView {
        id: playlistId
        x:255; y: 32
        visible: false

        delegate: ColumnLayout{
                Text {
                    text: '* ' + index + '-' + modelData.length
                }
                ColumnLayout {
                    Repeater {
                    model: modelData
                        TextEdit {
                            text: modelData
                            selectByMouse: true
                        }
                    }
                }
        }
    }

    ColumnLayout {
        x:255; y:32
        Repeater {
            id: videosId
            Row {
                Text {
                    text: modelData.title
                }
                Text {
                    text: '--- ' + modelData.epoch
                }

            }
        }
    }

    //    Text {
//        id: dataId
//        x:255; y: 32
//        //text: qsTr("text")
//    }
    function openFile(path){
        // TODO escape
        // path.replace('"', '\"')
        Korni3Api.execInBack('xdg-open "'+path+'"  ') // xdg-utils
    }
    function showOpenFileDialog(filter, isCofirmOverride, isDirecrory, isMultiple, isSaveDialog, separator){
        filter = filter  || '"*.cpp" "*.pdf" '
        isCofirmOverride = isCofirmOverride || true
        isDirecrory = isDirecrory || false
        isMultiple = isMultiple  || true
        isSaveDialog = isSaveDialog || false
        //var name = --filename=ИМЯ_ФАЙЛА
        separator = separator || '|||'

        return Korni3Api.runCommand('', 'zenity --file-selection --file-filter ' + filter
                                        + (isCofirmOverride ? ' --confirm-overwrite ' : '')
                                        + (isMultiple ? ' --multiple ' : '')
                                        + (isDirecrory ? ' --directory ' : '')
                                        + (isSaveDialog ? '--save ' : '')
                                        + '--separator="'+separator+'" ' )


    }
    function showTextInputDialog(title, text){
        title = title || 'Введите данные'
        text = text || 'Пример'
        return Korni3Api.runCommand('', 'zenity  --entry --text="' + title
                                    + '" --entry-text="' + text + '" '
            + (false ? ' --hide-text ' : ''))
    }
    // TESTS
    function playlists(){
        return Korni3Api.runCommand('', './yt-playlists.py')
    }
    // TESTS
    function videosOfPlaylist(playlistName){
        return Korni3Api.runCommand('', './yt-videos.py "'+playlistName+'"  ')
    }

    Component.onCompleted: {
//        Korni3Api.newCommandResult.connect(function(cid, data){
//            dataId.text = data
//        })

        //dataId.text = Korni3Api.runCommand("ls1", "ls /")
        //dataId.text = Korni3Api.runCommand("korni1", "korni3 db yt")
        // openFile('/home/mp/Документы/Haas_J._Anatomia_tanca.pdf')
        // print(showOpenFileDialog('"*.txt"'))
        //print(showTextInputDialog())
        //dataId.text = playlists()
        playlistId.model = JSON.parse(playlists())
        var videos = JSON.parse(videosOfPlaylist(playlistId.model[0]))
        videosId.model = videos

        //Qt.quit()
    }
}
