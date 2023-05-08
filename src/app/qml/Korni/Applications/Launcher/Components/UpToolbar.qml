import QtQml 2.3
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.6                         // ScrollBar Button
import Industrial.Controls 1.0 as Controls          // ToolTip Theme
import '../StateTube' 1.0 as S

Item {
    property alias menu: menuId

    height: 50;  width: parent.width;

    Rectangle {
        color: '#2E2F30'
        x:0; y:0; height: 50;  width: rootId.width;
    }
    RowLayout {
        x:0; y:0; height: 50;  width: rootId.width;
        spacing: Controls.Theme.spacing

        // BACK playlistS button
        UpToolbarIconedButton {
            tipText: qsTr('К плейлистам' ) + S.State.uploaderId
            iconSource: './icons/peoples.1.png'
            isEnabled: true
            sizeFactor: 1.7
            onGo: S.State.goToPlaylists(S.State.uploaderId)
        }

        // BACK playlist button
        UpToolbarIconedButton {
            tipText: qsTr('К плейлисту ') +
                     (S.State.playlistName!=='' ? ': '+S.State.playlistName
                                                : '')
            iconSource: './icons/playlist-icon-40-1.svg'
            isEnabled: S.State.playlistId !== ''
            onGo: S.State.goToPlaylist(S.State.playlistId, S.State.playlistName)
        }

        // Menu button
        Rectangle {
            id: menuId
            width: 2 * Controls.Theme.margins + Controls.Theme.baseSize
            height: 2 * Controls.Theme.margins + Controls.Theme.baseSize
            color: '#04112A'
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                Controls.ToolTip {
                    text: qsTr('Меню')
                    visible: parent.containsMouse || menuIconId.hovered
                }
                onClicked: menuButtonId.open()
            }
            HoveredImage {
                id: menuIconId
                anchors.centerIn: parent
                source: './icons/menu-flat-icon-1.svg'
                width: Controls.Theme.iconSize
                height: width
//                        source
                onClicked: menuButtonId.open()
            }
            Menu {
                id: menuButtonId
                title: qsTr('Действия с видео')
                MenuItem {
                    id: control
                    text: qsTr('Скачать видео в папочку')
//                                contentItem: Controls.Label {
//                                    text: control.text
//                                    font: control.font
//                                    color: Controls.Theme.colors.tipText
//                                    wrapMode: Text.WordWrap
//                                    horizontalAlignment: Qt.AlignHCenter
//                                }

//                                background: Rectangle {
//                                    color: Controls.Theme.colors.tip
//                                    radius: Controls.Theme.rounding

//                                    MouseArea {
//                                        anchors.fill: parent
//                                        onPressed: if(control.сloseOnClick) control.close()
//                                    }
//                                }

                    //shortcut: StandardKey.Save
                    onTriggered: print('not implemented')
                }
            }
        }

        // to r mover
        Item {
            Layout.fillWidth: true
        }
        // account icon
        HoveredImage {
            width: 40
            height: 40

            source: './icons/user.svg'
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
                        text: qsTr('Управление аккаунтом\nПользователь: TODO')
                        color: 'white'
                    }
                    Button {
                        enabled: false // TODO
                        text: qsTr('запустить приложение')

                    }
                }
                background: Rectangle {
                    color: '#606060' //'#2E2F30'
                }
            }
        }
    }

}
