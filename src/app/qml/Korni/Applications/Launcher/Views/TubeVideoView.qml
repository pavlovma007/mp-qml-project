import QtQml 2.3
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.6 // ScrollBar Button
import QtQuick.Window 2.1 // Screen
import Industrial.Controls 1.0 as Controls

import '../Components' 1.0 as C
import '../StateTube' 1.0 as S

// video
FocusScope {
	width: childrenRect.width; height: childrenRect.height
	x:childrenRect.x; y: childrenRect.y
    anchors.fill: parent

	Flickable {
		id: flickVideoId
		objectName: 'flickVideoId'
		visible: S.State.viewName === 'video'
		contentWidth: contentId.width
		contentHeight: contentId.height

        boundsBehavior: Flickable.StopAtBounds

		ScrollBar.vertical: ScrollBar { // todo size + customization
			id: sbVideoId
            focus: true
			width: 10
			height: flickVideoId.height
			orientation: Qt.Vertical
			visible: true
            policy: ScrollBar.AlwaysOn
		}
		function down(){
			if(sbVideoId.position + sbVideoId.stepSize < 0.89)
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
		onContentHeightChanged: { // если ширина изменилась то и высота тоже - надо чтобы скрол точно был на прежнем месте
			sbVideoId.position = 0.0
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
                    spacing: Controls.Theme.spacing

                    // BACK playlist button
                    Rectangle {
                        width: 2 * Controls.Theme.margins + Controls.Theme.baseSize
                        height: 2 * Controls.Theme.margins + Controls.Theme.baseSize
                        Layout.leftMargin: Controls.Theme.margins
                        color: '#04112A'
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            Controls.ToolTip {
                                text: qsTr('К плейлисту')
                                visible: parent.containsMouse || playlistIconId.hovered
                            }
                            onClicked: { S.State.goToPlaylist(S.State.playlistId) }
                        }
                        C.HoveredImage {
                            id: playlistIconId
                            anchors.centerIn: parent
                            source: './icons/playlist-icon-40-1.svg'
                            width: Controls.Theme.iconSize
                            height: width
    //                        source
                            onClicked: { S.State.goToPlaylist(S.State.playlistId) }
                        }
                    }

                    // Menu button
                    Rectangle {
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
                        C.HoveredImage {
                            id: menuIconId
                            anchors.centerIn: parent
                            source: './icons/menu-flat-icon-1.svg'
                            width: Controls.Theme.iconSize
                            height: width
    //                        source
                            onClicked: menuButtonId.open()
                        }
                        C.Menu {
                            id: menuButtonId
                            title: qsTr('Действия с видео')
                            C.MenuItem {
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

                    Item {
						Layout.fillWidth: true
					}
					C.HoveredImage {
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
                                    text: qsTr('Управление аккаунтом\nПользователь: abc')
									color: 'white'
								}
								Button {
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
            VideoView {
				id: videoId
				height: S.State.isWindowMaximized ?
							Screen.height * 0.8
						  : 510

				player.source: !!S.State.video ? S.State.video.videoFile : ''
                stateIn: S.State.playStateIn
				Connections {
					target: videoId.player
					onSourceChanged: {
						print('need play! ')//player.play()
						videoId.player.play()
					}
				}
                onStateOutChanged: {
                    S.State.playStateOut = stateOut
                    S.State.playStateIn = stateOut // fact
                }
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
							onClicked: print('not implemented. tag=', modelData.text)
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
					readOnly: true
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
                            Controls.ToolTip {
								visible: parent.containsMouse
                                text: qsTr('на момент сохранния видео в базе')
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
                            source: !!S.State.video && !!S.State.video.likedByYour ? '../Components/icons/like-filled.png' : '../Components/icons/like.png'
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
                            source: !!S.State.video && !!S.State.video.dislikedByYour ? '../Components/icons/dislike-filled.png' : '../Components/icons/dislike.png'
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
                    CommentWithReplies {
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
                    Comment {
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

