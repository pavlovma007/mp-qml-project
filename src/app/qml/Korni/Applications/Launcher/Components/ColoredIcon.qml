import QtQuick 2.6
import QtGraphicalEffects 1.0
//import Industrial 1.0

Item {
    id: root

    property alias source: image.source
    property bool mirror: false
    //property alias color: image.color
    property color color: 'white'
    property bool animate: false
    property int animFrames: 12

    onAnimateChanged: {
        if (!animate)
            rotation = mirror ? 180 : 0
    }

    Timer {
        interval: animFrames
        repeat: true
        running: animate
        onTriggered: root.rotation += 5
    }

    rotation: mirror ? 180 : 0
    implicitWidth: image.implicitWidth
    implicitHeight: image.implicitHeight

    Image /*SvgItem */{
        id: image
        anchors.fill: parent
    }
}

