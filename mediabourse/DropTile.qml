import QtQuick 2.0

//! [0]
DropArea {
    id: dragTarget

    property string colorKey
    property string answer

    width: 100; height: 64

    Rectangle {
        id: dropRectangle

        anchors.fill: parent
        color: colorKey

    }
    onEntered: {
        drag.source.objectName
    }

//! [0]
}
