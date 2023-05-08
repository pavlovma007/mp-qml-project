import QtQml 2.3
import QtQuick 2.6
import QtQuick.Controls 2.10 // Button
import QtQuick.Layouts 1.3
import '../Components' 1.0 as C
import '../StateTube' 1.0 as S

Column {
    id: componentId
    width: rootId.width
    spacing: 5
    C.UpToolbar {
        id: upToolbarId
    }
    C.SearchLine {
        id: searchLineId
        enabled: false
    }

    ScrollView {
        width: rootId.width
        height: rootId.height
                - componentId.spacing * (componentId.children.length - 1)
                - upToolbarId.height - searchLineId.height
        clip: true

        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        Column {
            id: contentId
            spacing: 10
            width: rootId.width
            Repeater {
                model : S.State.playlists

                RowLayout {
                    Button {
                        text: model.name
                        flat: true
                        hoverEnabled: true
                        highlighted: hovered || pressed

                        font.pixelSize: 22
                        //font.italic: true
                        onClicked: {
                            S.State.goToPlaylist(model.id, model.name)
                        }
                    }
                    Label {
                        text: '('+model.uploader+')'
                        font.pixelSize: 16
                    }
                }
            }
        }
    }
}
